<?php
require_once __DIR__.'/../config/database.php';
require_once __DIR__.'/../app/helpers.php';
$worlds=db()->query('SELECT * FROM worlds WHERE is_active=1 ORDER BY world_number')->fetchAll();
$num=max(1,min(5,(int)($_GET['world']??1)));
$s=db()->prepare('SELECT * FROM worlds WHERE world_number=?'); $s->execute([$num]); $world=$s->fetch() ?: $worlds[0];
$s=db()->prepare('SELECT * FROM questions WHERE world_id=? AND is_active=1 ORDER BY RAND() LIMIT 12'); $s->execute([$world['id']]);
$questions=array_map(fn($q)=>['indicator'=>$q['indicator'],'difficulty'=>$q['difficulty'],'question'=>$q['question_text'],'options'=>['A'=>$q['option_a'],'B'=>$q['option_b'],'C'=>$q['option_c'],'D'=>$q['option_d']],'correct'=>$q['correct_option'],'explanation'=>$q['explanation']],$s->fetchAll());
?>
<!doctype html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>FLIP GAME — The Flipverse</title><link rel="stylesheet" href="assets/style.css"></head><body>
<header><a class="brand" href="index.php"><b>F</b> FLIP GAME <small>THE FLIPVERSE</small></a><span>RUANG PETUALANGAN MATEMATIKA</span></header>
<main><section class="hero"><div><p class="eyebrow">SELAMAT DATANG, PENJELAJAH!</p><h1>Belajar matematika,<br><em>satu kartu setiap waktu.</em></h1><p>Pilih dunia, buka kartu, pecahkan tantangan, dan kumpulkan poin.</p></div><div class="spark">✦</div></section>
<nav><?php foreach($worlds as $w):?><a class="<?=((int)$w['world_number']===$num?'active':'')?>" href="?world=<?=(int)$w['world_number']?>"><small>DUNIA <?=(int)$w['world_number']?></small><b><?=e($w['title'])?></b></a><?php endforeach;?></nav>
<section class="heading"><div><p class="eyebrow">DUNIA <?=(int)$world['world_number']?></p><h2><?=e($world['title'])?></h2><p><?=e($world['description']??'')?></p></div><div class="score">SKOR<strong id="score">0</strong>poin</div></section>
<?php if(count($questions)<12):?><p class="notice">Dunia ini memiliki <?=count($questions)?> soal aktif. Tambahkan soal agar tersedia 12 kartu unik.</p><?php endif;?>
<div class="progress"><b id="progress">0 dari <?=count($questions)?> kartu selesai</b><div class="track"><i id="fill"></i></div></div><section id="grid" class="grid"></section>
<section id="result" class="result hidden"><h2>✦ Misi selesai!</h2><p id="result-copy"></p><button onclick="location.reload()">Main lagi</button></section><p class="foot">Kesalahan adalah bagian dari belajar. Baca pembahasan dan coba lagi!</p></main>
<div id="modal" class="overlay hidden"><article><button id="close" class="x">×</button><p id="meta" class="eyebrow"></p><small id="indicator"></small><h2 id="question"></h2><div id="options" class="options"></div><p id="attempt"></p><div id="feedback" class="feedback hidden"></div><button id="continue" class="hidden">Lanjutkan</button></article></div>
<script>window.FLIP_QUESTIONS=<?=json_encode($questions,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES)?>;</script><script src="assets/game.js"></script></body></html>
