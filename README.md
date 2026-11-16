## Tugas 7

1. **Apa itu widget tree dan bagaimana hubungan parent-child bekerja?**  
   Widget tree adalah susunan widget bertingkat yang membentuk tampilan aplikasi.
   Pada proyek ini, `MaterialApp` menjadi root yang menampung `MyHomePage`.
   `MyHomePage` membangun `Scaffold`, lalu `Scaffold` menampung `AppBar` dan konten
   halaman. Widget parent menentukan tata letak dan menampung widget child; misalnya,
   `Row` menata beberapa `InfoCard` secara horizontal.

2. **Widget apa saja yang digunakan dan apa fungsinya?**  
   `MaterialApp` menyediakan kerangka aplikasi dan tema. `Scaffold` menyediakan
   struktur halaman, sedangkan `AppBar` menampilkan bilah atas. `SafeArea`,
   `Center`, `ConstrainedBox`, dan `SingleChildScrollView` membantu menjaga konten
   tetap aman, terpusat, dan dapat digulir. `Column`, `Row`, dan `GridView.count`
   menyusun konten. `Card`, `Material`, `InkWell`, `Icon`, `Text`, `Padding`, dan
   `SizedBox` membentuk kartu, efek sentuh, ikon, teks, serta jarak. `InfoCard`
   dan `ItemCard` adalah widget khusus yang dapat digunakan kembali.
   `ScaffoldMessenger` dan `SnackBar` menampilkan umpan balik setelah menu ditekan.
   `ItemHomepage` adalah model data untuk menyimpan nama, ikon, dan warna menu.

3. **Apa fungsi MaterialApp dan mengapa umum digunakan sebagai root widget?**  
   `MaterialApp` menyiapkan fitur dasar aplikasi bergaya Material, seperti tema,
   navigasi, dan konfigurasi halaman. Widget ini biasa menjadi root karena widget
   di bawahnya dapat menggunakan konfigurasi tersebut melalui `BuildContext`.

4. **Apa perbedaan StatelessWidget dan StatefulWidget? Kapan memilihnya?**  
   `StatelessWidget` cocok untuk tampilan yang tidak menyimpan perubahan state
   internal, seperti `MyHomePage`, `InfoCard`, dan `ItemCard` pada proyek ini.
   `StatefulWidget` digunakan ketika tampilan perlu diperbarui berdasarkan state
   yang berubah, misalnya nilai formulir atau daftar yang bertambah setelah aksi
   pengguna.

5. **Apa itu BuildContext dan mengapa penting?**  
   `BuildContext` menunjukkan posisi sebuah widget di dalam widget tree. Dari
   `build`, context dapat digunakan untuk mengambil konfigurasi dari ancestor,
   seperti warna melalui `Theme.of(context)` atau menampilkan SnackBar melalui
   `ScaffoldMessenger.of(context)`.

6. **Apa perbedaan hot reload dan hot restart?**  
   Hot reload menerapkan perubahan kode saat pengembangan sambil mempertahankan
   state aplikasi yang sedang berjalan. Hot restart menjalankan ulang aplikasi
   dari awal dan mengatur ulang state. Restart penuh diperlukan untuk perubahan
   yang tidak dapat diterapkan lewat hot reload, seperti perubahan konfigurasi
   native atau dependensi proyek.

## Penggunaan AI

- **Alat:** ChatGPT/Codex.
- **Cara menggunakan:** Saya memberikan folder tugas sebagai konteks sebelum memberikan pertanyaan lanjutan.
- **Bagian yang dibantu:** Pemetaan requirement dan penyesuaian icon pada tiap action card.
- **Batasan dan pemeriksaan:** Saran AI tetap perlu dicocokkan dengan brief dan
  dijalankan di proyek. Saya memeriksa tampilan kartu pada layar sempit dan menjalankan
  `flutter analyze`.
- **Perubahan manual:** Saya meninjau dan mengikuti saran maupun penilaian
   dari AI pada aspek kerapihan kode dan penyesuaian icon pada tiap action card.