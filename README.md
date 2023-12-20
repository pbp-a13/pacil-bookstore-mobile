<<<<<<< HEAD
<<<<<<< Updated upstream
# Proyek Tengah Semester Kelompok A13 -- pacil-bookstore
## Website: [http://pacil-bookstore.pbp.cs.ui.ac.id/](http://pacil-bookstore.pbp.cs.ui.ac.id/)
=======
=======
>>>>>>> 1a2e8a9de218a4668d1cfa699bd8ef78df9b9559
# Proyek Akhir Semester Kelompok A13 -- pacil-bookstore
## Website: [https://pts-a13-not0nlines-projects.vercel.app/](https://pts-a13-not0nlines-projects.vercel.app/)

### Link Berita Acara: https://docs.google.com/spreadsheets/d/16WONjLGPqOpak5w6WIo5dhGA5JXVEU15I9eXDtfJNIo/edit?usp=sharing
<<<<<<< HEAD
>>>>>>> Stashed changes
=======
>>>>>>> 1a2e8a9de218a4668d1cfa699bd8ef78df9b9559

Berikut deskripsi proyek kami.

<h1>
  Anggota Kelompok
</h1>

- William Joel Matthew Quinn Rompis - 2206081843 </br>
- Adrial Natanael Liong - 2206026321 </br>
- Kezia Lasma Angelica - 2206082234 </br>
- Alifa Muhammad Hafidz - 2206082852 </br>
- Shafira Ramadhina Adifa  - 2206082972 </br>



<h1>
  Deskripsi aplikasi
</h1>
Berdasarkan tema utama yang diberikan, yaitu "Literasi dan Buku", kelompok kami mengembangkan ide proyek toko buku. Aplikasi toko buku yang kami buat terdiri atas 3 role user, yaitu Admin, Member, dan Non-Member dengan masing-masing <i>role</i> memiliki kapabilitas akses yang berbeda-beda. Pada halaman utama, aplikasi toko buku kami akan menampilkan data umum buku seperti judul, <i>cover</i>, dan harga dengan fitur <i>sort</i> berdasarkan peringkat tertentu juga fitur <i>filter</i> berdasarkan kategori tertentu. Selain itu, pada halaman utama juga terdapat <i>search bar</i> juga <i>navigation bar</i> yang dapat mengarahkan pengguna untuk <i>register</i> atau <i>login</i> atau menampilkan <i>username</i> dari <i>user</i> yang sedang <i>login</i> di aplikasi. Kemudian jika <i>user</i> melakukan klik pada buku yang diinginkan, user akan diarahkan ke halaman berisi info detail buku, dimana pada halaman tersebut juga tersedia <i>button</i> untuk <i>add cart</i> dan <i>checkout</i> (pada Member). Kami juga menyediakan halaman keranjang atau <i>cart</i>, dimana Member dapat melihat item buku yang sudah dimasukkan ke keranjangnya untuk <i>checkout</i>.  Pengiriman buku yang dipesan oleh Member dapat diatur oleh <i>role</i> Admin, dimana <i>role</i> Admin juga memiliki akses untuk melihat info seluruh Member dan dapat berganti ke mode user biasa jika diinginkan.


<h1> Integrasi dengan Situs Web  </h1>
<h3>Berikut adalah langkah-langkah yang akan dilakukan untuk mengintegrasikan aplikasi dengan server web:</h3>

- Mengimplementasikan sebuah wrapper class dengan menggunakan library http dan map untuk mendukung penggunaan cookie-based authentication pada aplikasi. </br>
- Mengimplementasikan REST API pada Django (views.py) dengan menggunakan JsonResponse atau Django JSON Serializer. </br>
- Mengimplementasikan desain front-end untuk aplikasi berdasarkan desain website yang sudah ada sebelumnya.</br>
- Melakukan integrasi antara front-end dengan back-end dengan menggunakan konsep asynchronous HTTP.</br>

<h1>
  Penjelasan dan Pembagian Fitur
</h1>

Sumber database: https://www.gutenberg.org/cache/epub/feeds/pg_catalog.csv


<h2>
  Modul
</h2>

<h3>
  Main
</h3>

- PJ: William Joel Matthew Quinn Rompis 2206081843
- Berisi main page (member) dan main page (admin)
- Menampilkan semua buku yang tersedia di toko buku.
- Informasi buku yang ditampilkan: judul buku, pengarang buku, harga buku, dan rating buku
- Buku bisa diklik untuk mengalihkan ke book info page
- Ada search bar untuk search buku berdasarkan judul atau pengarang.
- Bisa sort/filter berdasarkan alphabetic, best-seller, top-rated.
- [Khusus admin] Ada opsi untuk menambah judul buku -- menambahkan buku baru ke dalam katalog, diarahkan ke book info page yang kosong

<h3>
  Book
</h3>

- PJ: Shafira Ramadhina Adifa (2206082972)
- Page berisi **info** dan **detail produk** dari suatu buku yg diklik user.
- [Khusus User] Terdapat informasi status produk (Tersedia/Habis), jumlah yang ingin dibeli (Default: 1) yang dapat ditambah/kurang (Batas jumlah pembelian: 1 sampai total stock produk), dan button `Add to Cart`. Button `-` dan `+` hanya dapat diklik jika masih di dalam batas jumlah pembelian. Button `Add to Cart` dapat diklik hanya jika stock produk tersedia minimal 1.
- [Khusus Admin] Terdapat informasi jumlah stock produk dan button `Edit` untuk akses mengedit seluruh informasi buku.
  
<h4>
  (1) Info
</h4>

- Info berisi `Foto`, `Book-Author`, `Book-Title`, `Book-Price`, jumlah terjual, dan `Ratings`.
- `Ratings` berupa angka desimal dalam range 0-5 (higher value denoting higher appreciation) disertai jumlah pembeli yang telah memberikan rating. Rating diperoleh dari rerata nilai yang diberikan user setelah melakukan pembelian (bilangan bulat 1-5). Default dari nilai rating adalah 0 (kondisi ketika belum memiliki nilai rating dari pembeli).

<h4>
  (2) Detail Produk
</h4>

- Detail produk berupa: Kategori, Deskripsi, Details, dan Penilaian Produk.
- Details terdiri dari `Book-Title`, `Book-Author`, `Year-Of-Publication`, dan `Publisher`.
- Penilaian produk terdiri dari `Ratings` dan `Review`.
- Review berupa kumpulan ulasan produk dari user berbentuk narasi.

<h3>
  Order
</h3>

- PJ: Kezia Lasma Angelica (2206082234)
- Role <b>Admin</b> memiliki akses untuk melihat seluruh order dari customer
- Untuk halaman seluruh pesanan atau <i>order list</i>, terdapat pilihan untuk melihat pesanan <i>ongoing</i> atau <i>completed</i> yang menyediakan informasi <i>username</i>, judul buku yang dibeli, serta jumlahnya
- Jika admin melakukan klik pada suatu pesanan, maka akan mengarahkan sistem ke halaman order page yang menampilkan suatu pesanan secara spesifik. Jika pesanan tersebut berstatus <b>ongoing</b>, maka akan tersedia button <b>Kirim</b> untuk mengubah status pesanan menjadi <b>completed</b>
- Role <b>Member</b> memiliki akses untuk melihat seluruh pesanan yang pernah dibuat oleh member tersebut, dimana halaman defaultnya adalah order list member yang menampilkan informasi buku yang dipesan.
- Setiap pesanan dapat diklik untuk mengarahkan ke order page member yang berisi semua detail tentang satu order spesifik seperti jenis dan jumlah buku yang dipesan, tanggal pemesanan, dan estimasi pesanan sampai.

<h3>
  Payment
</h3>

- PJ: Alifa Muhammad Hafidz (2206082852)
- Halaman "Payment" adalah halaman di mana user (member) menyelesaikan pembayaran untuk buku-buku yang ada dalam keranjang (cart) mereka.
- User dapat melihat daftar buku-buku yang ada dalam cart beserta harga dan jumlahnya.
- Setiap item dalam cart memiliki opsi untuk menambah dan mengurangi jumlahnya serta menghapus item dari cart.
- User akan melihat saldo mereka yang tersedia di akun mereka, dan total harga pembayaran. Jika saldo user mencukupi untuk membayar pesanan, user dapat memilih untuk menggunakan saldo tersebut untuk pembayaran.
- Terdapat tombol atau tautan yang mengarahkan user ke halaman "Isi Saldo Page" jika saldo mereka kurang untuk membayar pesanan.
- Terdapat tombol "Bayar" yang akan mengambil buku-buku dari cart pengguna dan memasukkannya ke dalam daftar pesanan (order list). Tombol "Bayar" hanya dapat diklik jika saldo user cukup untuk membayar pesanan. Jika saldo kurang dari total harga, tombol tersebut tidak dapat diklik.
- Jika transaksi berhasil, saldo user akan dikurangkan sejumlah total harga buku-buku yang dibeli.
- Setelah pembayaran selesai, user akan menerima konfirmasi pembayaran dan diberikan opsi untuk kembali ke halaman utama atau melanjutkan berbelanja.

<h3>
  Account
</h3>

- PJ : Adrial Natanael Liong (2206026321)
- Pada halaman <i>register</i>, pengguna diminta <b>username</b> dan <b>password</b> saja untuk mendaftar.
- Akun <b>admin</b> bisa mengganti mode menjadi akun <b>member</b>, sehingga pengguna biasa tidak bisa register sebagai admin.
- Pada <i>All member info page</i>, hanya akun admin yang dapat melihat list seluruh akun member yang ada dan masuk ke <i>member info page</i> untuk melihat detail akun member seperti <b>name, saldo, pesanan ongoing, buku yang telah dibeli, review</b>.
- Akun <b>member</b> dapat membeli buku, akun <b>non-member</b> perlu login/register untuk membeli buku, akun <b>admin</b> tidak dapat memberli buku (perlu ganti ke akun member dahulu jika ingin beli buku), hanya bisa konfirmasi pembelian buku.
- Pada <i>halaman account info</i>, setiap akun ada data yang bisa diedit (nama, email, alamat, password) dan data yang tidak bisa diedit (username).


<h2>
  Models list
</h2>


Models:
1. Account
   Username, Nama, email, password,

2. Buku
   Judul, pengarang, harga, kategori, deskripsi, jumlah halaman, stok, review, rating, jumlah terjual

3. Order
   Order id, Username, Buku, alamat, tanggal order, status(ongoing/completed), tanggal completed.

4. Review
   Reivew id, Username, Buku, rating, isi review, tanggal review.

5. Member
   Extends account, alamat, saldo, pesanan ongoing, buku yang telah dibeli, review

6. Admin
   Extends account, no. of books added, no. of orders completed.



<h2>
  Page List
</h2>


<h3>
  Main page (member)
</h3>

- Menampilkan buku-buku yang tersedia pada toko buku.
- Informasi buku yang ditampilkan: judul buku, pengarang buku, harga buku, dan rating buku
- Buku bisa diklik untuk mengalihkan ke book info page
- Ada search bar untuk search buku berdasarkan judul atau pengarang.
- Bisa sort/filter berdasarkan alphabetic, best-seller, top-rated.

<h3>
  Main page (admin)
</h3>

- memiliki semua fitur yang dimiliki main mage (member).
- Ada opsi untuk menambah judul buku -- menambahkan buku baru ke dalam katalog, diarahkan ke book info page yang kosong

<h3>
  Book info page (member)
</h3>

- Menampilkan semua informasi tentang buku
- Jika stok tersedia, bisa menambahkan dan mengurangi item ke/dari cart.

<h3>
  Book info page (non-member)
</h3>

- Menampilkan semua informasi tentang buku
- Jika ingin menambahkan item ke cart, akan diminta untuk login/signup

<h3>
  Book info page (admin)
</h3>

- Menampilkan semua informasi tentang buku.
- Ada opsi delete judul -- menghapus buku dari katalog
- Ada tombol "edit" yang akan mengubah semua tampilan menjadi form sehingga bisa dimodifikasi. Setelah itu ada tombol "Save" untuk menyimpan modifikasi.
- Jika sedang menambah judul buku, akan menampilkan form kosong


<h3>
  Cart page
</h3>

- Berisi daftar buku-buku yang ada di cart, harganya, dan total harga
- Bisa tambah dan kurang jumlah untuk masing-masing item
- Bisa remove item dari cart
- Ada tombol menuju payment page

<h3>
  Payment page
</h3>

- Menampilkan total harga yang harus dibayar, dan saldo member yang tersedia
- Ada tombol untuk mengarahkan ke page isi saldo
- Tombol bayar: memasukkan buku ke order list, dan mengurangi saldo member dengan harga total buku.
- Tombol bayar tidak bisa diklik jika saldo kurang dari harga yang harus dibayar


<h3>
  Order list page (admin)
</h3>

- Berisi semua order yang pernah dilakukan, oleh semua member, baik ongoing ataupun completed (ada dua section)
- Setiap order memiliki informasi username, judul buku yang dibeli, serta jumlahnya.
- Setiap order dapat diklik untuk mengarahkan ke order page (admin)

<h3>
  Order page (admin)
</h3>

- Berisi semua detail tentang satu order spesifik.
- Untuk ongoing order, ada tombol "Kirim" --> mengubah status order menjadi completed. 


<h3>
  Order list page (member)
</h3>

- Berisi semua order yang pernah dilakukan oleh member, baik ongoing ataupun completed (ada dua section)
- Setiap order memiliki informasi username, judul buku yang dibeli, serta jumlahnya.
- Setiap order dapat diklik untuk mengarahkan ke order page (member)

<h3>
  Order page (member)
</h3>

- Berisi semua detail tentang satu order spesifik. (jenis dan jumlah buku yang dipesan, kapan dipesan, kapan diperkirakan akan sampai pesanannya)

<h3>
  Isi Saldo Page
</h3>

- Member dapat meng-input jumlah top-up saldo lalu menekan tombol "Isi" untuk mengupdate saldo.


<h3>
  Account Info Page
</h3>

- User dapat melihat semua informasi tentang account.
- Ada tombol "edit" yang akan mengubah semua tampilan menjadi form sehingga bisa dimodifikasi. Setelah itu ada tombol "Save" untuk menyimpan modifikasi.

<h3>
  All Member Info (admin only) 
</h3>

- List semua member yang ada, menampilkan username, tanggal join, dan jumlah order yang pernah dibuat
- Setiap member bisa diklik untuk melihat member info page masing-masing.

<h3>
  Member Info Page (admin only) 
</h3>

- dapat melihat informasi umum sebuah member seperti nama, username, saldo, pesanan ongoing, buku yang telah dibeli, review

<h3>
  Register Page
</h3>
- halaman untuk register menjadi member
- Isinya mirip account info page tapi form kosong, beserta input username & password

<h3>
  General
</h3>

- Terdapat navbar pada setiap halaman untuk dapat berpindah-pindah ke semua halaman yang tidak buku-spesifik atau order-spesifik
- Admin memiliki opsi untuk berganti ke member-mode jika ingin membeli buku seperti member.
- Ada tiga  jenis user:
1. Non member:
   - Hanya dapat mengakses halaman main page (non member)
   - Dapat melihat informasi tentang buku, termasuk judul, pengarang, harga, dan rating
   - Jika ingin menambahkan buku ke keranjang (cart), user akan diminta untuk login atau melakukan pendaftaran
2. Member:
   - Dapat mengakses halaman "Main page (member)" dan semua fitur aplikasi mobile
   - Bisa melihat dan membeli buku
   - Dapat menambahkan buku ke keranjang (cart) dan melakukan transaksi pembayaran
   - Memiliki saldo yang dapat diisi melalui halaman "Isi Saldo"
   - Dapat melihat semua pesanan yang pernah dibuat (baik yang masih berlangsung maupun yang sudah selesai) pada halaman "Order list (member)"
   - Dapat melihat informasi tentang akun mereka pada halaman "Account Info"
3. Admin:
   - Memiliki semua hak akses yang dimiliki oleh Member
   - Dapat mengakses halaman "Main page (admin)" yang memiliki semua fitur yang dimiliki oleh "Main page (member)."
   - Dapat menambahkan judul buku ke dalam katalog melalui halaman "Main page (admin)" dengan mengarahkan ke "Book info page (admin)."
   - Dapat mengedit informasi buku, termasuk menghapus buku dari katalog, Menambahkan buku, serta dapat mengedit deskripsi buku melalui "Book info page (admin)."
   - Dapat mengelola pesanan pada halaman "Order list (admin)" dan mengubah status pesanan menjadi "completed" melalui "Order page (admin)."
   - Dapat mengakses halaman "All Member Info" untuk melihat informasi seluruh anggota dan mengakses halaman "Member Info Page (admin)" untuk melihat detail tentang anggota tertentu.
   - Admin memiliki opsi untuk beralih ke mode "Member" untuk membeli buku seperti pengguna biasa.



Admin:
- bisa switch mode admin mode user:
Mode admin:
- edit data buku (tambah judul, hapus judul, tambah stok, ganti yg lain2)
- Page daftar pesanan (simulasi pengiriman) -- instan kirim
