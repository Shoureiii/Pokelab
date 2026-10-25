# PokéLab

PokéLab adalah aplikasi mobile berbasis Flutter untuk membantu penggemar Pokémon mengenal karakteristik Pokémon dan menyusun tim sederhana berdasarkan tipe.

## Fitur

- Menjelajahi 10 Pokémon pilihan.
- Mencari Pokémon berdasarkan nama atau nomor Pokédex.
- Memfilter Pokémon berdasarkan tipe.
- Melihat detail Pokémon, termasuk statistik, kemampuan, dan jalur evolusi.
- Menyusun tim hingga enam Pokémon.
- Melihat cakupan tipe dan kelemahan tipe dalam tim.

## Teknologi

- Flutter dan Dart
- Material Design 3
- Data Pokémon contoh yang disimpan secara lokal
- Ilustrasi Pokémon dimuat melalui URL gambar; koneksi internet diperlukan untuk menampilkannya

Aplikasi belum mengambil data Pokémon dari API. Struktur proyek disiapkan agar sumber data dapat dikembangkan ke PokéAPI pada tahap berikutnya.

## Menjalankan aplikasi

Pastikan Flutter SDK sudah terpasang dan emulator atau perangkat Android tersedia. Dari direktori proyek, jalankan:

```bash
flutter pub get
flutter run
