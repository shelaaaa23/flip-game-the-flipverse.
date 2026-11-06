CREATE DATABASE IF NOT EXISTS flipverse CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE flipverse;
CREATE TABLE worlds (
 id INT AUTO_INCREMENT PRIMARY KEY, world_number TINYINT UNIQUE NOT NULL,
 title VARCHAR(120) NOT NULL, description TEXT, is_active TINYINT DEFAULT 1
);
CREATE TABLE questions (
 id INT AUTO_INCREMENT PRIMARY KEY, world_id INT NOT NULL,
 indicator VARCHAR(180) NOT NULL, difficulty ENUM('Mudah','Sedang','Sulit') DEFAULT 'Mudah',
 question_text TEXT NOT NULL, option_a VARCHAR(255) NOT NULL, option_b VARCHAR(255) NOT NULL,
 option_c VARCHAR(255) NOT NULL, option_d VARCHAR(255) NOT NULL,
 correct_option CHAR(1) NOT NULL, explanation TEXT NOT NULL, is_active TINYINT DEFAULT 1,
 FOREIGN KEY (world_id) REFERENCES worlds(id)
);
INSERT INTO worlds(world_number,title,description) VALUES
(1,'Gerbang Konsep','Mengenal konsep dan unsur dasar.'),
(2,'Jejak Pythagoras','Memahami hubungan sisi segitiga siku-siku.'),
(3,'Pythagoras dalam Kehidupan','Menerapkan Pythagoras pada masalah kontekstual.'),
(4,'Kastel Bangun Ruang','Mengenal bangun ruang sisi datar.'),
(5,'Misi Pemecahan Masalah','Menggabungkan konsep untuk memecahkan masalah.');
INSERT INTO questions(world_id,indicator,difficulty,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES
(1,'Mengidentifikasi segitiga siku-siku','Mudah','Segitiga dengan satu sudut 90° disebut ...','Sama sisi','Siku-siku','Tumpul','Lancip','B','Segitiga siku-siku memiliki tepat satu sudut 90°.'),
(1,'Mengenali hipotenusa','Mudah','Sisi di depan sudut 90° disebut ...','Alas','Tinggi','Hipotenusa','Sejajar','C','Hipotenusa adalah sisi yang berhadapan dengan sudut siku-siku.'),
(2,'Memilih rumus Pythagoras','Mudah','Jika c hipotenusa, rumus yang benar ...','a+b=c','a²+b²=c²','a²-b²=c²','a×b=c','B','Kuadrat hipotenusa sama dengan jumlah kuadrat kedua sisi siku-siku.'),
(2,'Menghitung hipotenusa','Sedang','Sisi siku-siku 3 cm dan 4 cm. Hipotenusa ...','5 cm','6 cm','7 cm','8 cm','A','c=√(3²+4²)=5 cm.'),
(3,'Penerapan Pythagoras','Sedang','Tangga 10 m, kaki tangga 6 m dari tembok. Tinggi ujung tangga ...','4 m','6 m','8 m','10 m','C','Tinggi=√(10²−6²)=8 m.'),
(3,'Menentukan jarak','Sulit','Berjalan 6 m ke timur lalu 8 m ke utara. Jarak lurus ...','10 m','12 m','14 m','16 m','A','Jarak=√(6²+8²)=10 m.'),
(4,'Mengidentifikasi bangun ruang','Mudah','Bangun dengan 6 sisi persegi sama besar ...','Balok','Prisma','Kubus','Limas','C','Kubus memiliki enam sisi persegi kongruen.'),
(4,'Memahami unsur balok','Mudah','Jumlah rusuk balok adalah ...','8','10','12','14','C','Balok memiliki 12 rusuk.'),
(4,'Menghitung volume kubus','Sedang','Rusuk kubus 4 cm. Volumenya ...','16 cm³','32 cm³','48 cm³','64 cm³','D','V=s³=4³=64 cm³.'),
(5,'Menghitung volume balok','Sedang','Balok 8 cm × 3 cm × 2 cm. Volumenya ...','13 cm³','24 cm³','48 cm³','64 cm³','C','V=p×l×t=48 cm³.'),
(5,'Diagonal ruang kubus','Sulit','Kubus memiliki rusuk 2 cm. Diagonal ruang ...','2√2 cm','2√3 cm','4√2 cm','4√3 cm','B','Diagonal ruang kubus=s√3=2√3 cm.'),
(5,'Masalah kontekstual','Sulit','Taman 9 m × 12 m. Panjang diagonal ...','13 m','14 m','15 m','16 m','C','Diagonal=√(9²+12²)=15 m.');
