# Kopi Kita ☕

Aplikasi katalog menu kafe sederhana berbasis Flutter (UTS Mobile Programming, Semester Ganjil 2025/2026).

## Tema & Tujuan
Menampilkan menu kafe (kopi, non-kopi, makanan, dessert) dengan antarmuka modern dan bersih.
Data memakai data dummy berbentuk JSON (`lib/data/coffee_data.dart`) dan model `Coffee`
sudah memiliki `fromJson` / `toJson` sehingga siap dihubungkan ke API pada tahap berikutnya.

## Halaman
| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/pages/home_page.dart` | Sapaan, pencarian, kategori cepat, menu populer & terbaru |
| Menu | `lib/pages/menu_page.dart` | Daftar menu + filter kategori + pencarian |
| Favorit | `lib/pages/favorite_page.dart` | Daftar menu yang di-favoritkan |
| Detail | `lib/pages/detail_page.dart` | Info lengkap, bahan, pilih ukuran & jumlah |

Navigasi: `BottomNavigationBar` (Beranda/Menu/Favorit) dan `Navigator.push` (menuju Detail).

## Struktur Folder
```
lib/
├── main.dart
├── theme.dart
├── models/coffee.dart
├── data/coffee_data.dart
├── pages/ (main_shell, home, menu, favorite, detail)
└── widgets/coffee_card.dart
```

## Cara Menjalankan
1. Pastikan Flutter SDK terpasang (`flutter doctor`).
2. `flutter pub get`
3. Hubungkan HP Android / jalankan emulator.
4. `flutter run`
