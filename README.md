# Jelajah Nusantara

Aplikasi mobile panduan wisata Indonesia yang dibuat dengan Flutter sebagai tugas
Ujian Tengah Semester (UTS) mata kuliah **Mobile Programming** (Semester Ganjil 2025/2026).

## Tema dan Tujuan

Jelajah Nusantara membantu pengguna mengenal dan memilih destinasi wisata di
Indonesia. Pengguna dapat menjelajahi destinasi berdasarkan kategori (Pantai,
Gunung, Budaya, Alam), mencari berdasarkan nama atau lokasi, membaca informasi
waktu terbaik berkunjung, daya tarik, serta tips berkunjung, dan menyimpan
destinasi favorit.

## Daftar Halaman

| Halaman | File | Fungsi |
| --- | --- | --- |
| Beranda | `lib/screens/home_screen.dart` | Sapaan, kolom pencarian, pilihan kategori, destinasi populer (rating tertinggi), dan destinasi terbaru. |
| Daftar Destinasi | `lib/screens/list_screen.dart` | Daftar seluruh destinasi dengan pencarian dan filter kategori. Tampil sebagai grid dua kolom pada layar lebar. |
| Detail Destinasi | `lib/screens/detail_screen.dart` | Informasi lengkap: lokasi, kategori, rating, waktu terbaik, cocok untuk siapa, deskripsi, daya tarik, tips berkunjung, dan tombol favorit. |
| Favorit | `lib/screens/favorites_screen.dart` | Daftar destinasi yang ditandai favorit. |

Navigasi memakai `BottomNavigationBar` (Beranda, Destinasi, Favorit) pada
`lib/screens/main_shell.dart` dan `Navigator.push` untuk membuka halaman detail.

## Struktur Proyek

```
jelajah_nusantara/
├── assets/data/destinations.json         # Data dummy (JSON lokal)
├── lib/
│   ├── main.dart                         # Titik masuk aplikasi
│   ├── data/destination_repository.dart  # Sumber data (JSON lokal, siap diganti API)
│   ├── models/destination.dart           # Model Destination (fromJson / toJson)
│   ├── state/app_state.dart              # State: filter, pencarian, favorit
│   ├── theme/app_theme.dart              # Warna dan tema
│   ├── utils/helpers.dart                # Format tanggal, ikon kategori, navigasi
│   ├── widgets/destination_card.dart     # Kartu destinasi yang dipakai ulang
│   └── screens/                          # Halaman aplikasi
└── pubspec.yaml
```

## Data

Data dummy disimpan di `assets/data/destinations.json` dengan format
`{"destinations": [...]}`. Setiap destinasi memiliki `id`, `name`, `location`,
`category`, `bestTime`, `suitableFor`, `emoji`, `color`, `description`,
`rating`, `publishedAt`, `highlights`, dan `tips`. Nilai rating dan tanggal
bersifat dummy untuk keperluan tampilan.

Pembacaan data dipusatkan di `DestinationRepository.fetchDestinations()`. Pada
tahap berikutnya, fungsi ini cukup diganti dengan permintaan HTTP ke API
(komentar contoh ada di dalam file) tanpa mengubah model maupun tampilan.

## Cara Menjalankan

Prasyarat: [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart 3.0 atau lebih baru)
dan emulator Android/iOS atau perangkat fisik.

1. Clone repositori dan masuk ke foldernya:
   ```bash
   git clone <url-repositori>
   cd jelajah_nusantara
   ```
2. Jika folder `android/` dan `ios/` belum ada, buat file platform:
   ```bash
   flutter create .
   ```
3. Unduh dependensi:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Pengembangan Lanjutan

- Mengganti sumber data lokal dengan API (`http`/`dio`) pada `DestinationRepository`.
- Menyimpan daftar favorit secara permanen (`shared_preferences`).
- Menambahkan foto destinasi dari URL dan peta lokasi.
