import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/account/models/review.dart';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/book_info/screens/book_review.dart';
import 'package:toko_buku/book_info/screens/edit_form.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';

class BookInfoPage extends StatelessWidget {
  BookInfoPage({super.key, required this.id});
  final int id;
  int rating = 0;

  Future<Book> getBook() async {
    var url = "http://localhost:8000/book-info/json/$id/";
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    // print(data);
    var buku = Book.fromJson(data[0]);
    // print(buku);
    return buku;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    var isLoggedIn;
    var isAdmin;
    var isAdminMode;
    var cookieData = request.jsonData;
    if (cookieData.length == 0){
      isLoggedIn = false;
      isAdmin = false;
      isAdminMode = false;
    }
    else{
      isLoggedIn = true;
      isAdmin = cookieData['is_admin'];
      isAdminMode = cookieData['is_admin_mode'];
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Detail Buku', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey[100]),),
        backgroundColor: Colors.indigoAccent[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getBook(),
              builder: (context, AsyncSnapshot<Book> snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text("Tidak ada informasi buku.", style: TextStyle(color: Color(0xff59A5D8), fontSize: 20)),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    Book book = snapshot.data!;
                    rating = book.fields.rating;
                    return Card(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Container(
                            alignment: Alignment.center,
                            child: 
                              Icon(
                                Icons.image_outlined,
                                color: Colors.grey,
                                size: 200,
                              ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[50], 
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${book.fields.authors}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${book.fields.title}",
                                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: isLoggedIn && isAdmin && isAdminMode,
                                      child: Expanded(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => EditFormPage(bookId: id),
                                                  ),
                                                );
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(color: Colors.blueAccent[700]!),
                                                shape: CircleBorder(),
                                              ),
                                              child: Icon(Icons.edit, color: Colors.blueAccent[700], size: 15,),
                                            ),
                                            OutlinedButton(
                                              onPressed: () async {
                                                bool confirmDelete = await showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Konfirmasi Hapus"),
                                                      content: Text("Apakah Anda yakin ingin menghapus buku ini?"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop(false);
                                                          },
                                                          child: Text("Batal"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop(true);
                                                          },
                                                          child: Text("Hapus"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                if (confirmDelete == true) {
                                                  final response = await request.postJson(
                                                    "http://localhost:8000/book-info/delete-flutter/$id/",
                                                    jsonEncode(<String, String>{})
                                                  );
                                                  if (response['status'] == 'success') {
                                                    ScaffoldMessenger.of(context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(SnackBar(
                                                          content: Text("Buku berhasil dihapus!")));
                                                  } else {
                                                    ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(content: Text("Terdapat kesalahan, silakan coba lagi."))
                                                    );
                                                  }
                                                }
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(color: Colors.redAccent[700]!),
                                                shape: CircleBorder(),
                                              ),
                                              child: Icon(Icons.delete, color: Colors.redAccent[700], size: 15,),
                                            ),
                                          ]
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Text(
                                        "Rp${book.fields.price}",
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 102, 255, 1),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: book.fields.stock == 0 ? Colors.red : Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        book.fields.stock == 0 ? 'Stock habis' : 'Tersisa ${book.fields.stock} stock',
                                        style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [ 
                                          Icon(
                                            Icons.star,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${book.fields.rating}",
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Container(
                                      child: Text("|", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400),)
                                    ),
                                    SizedBox(width: 12),
                                    Container(
                                      child: Text("${book.fields.jumlahTerjual} Terjual", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),)
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Kategori",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.indigo),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${book.fields.categories}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Deskripsi",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.indigo),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Buku karya ${book.fields.authors} berjudul ${book.fields.title} dengan kategori ${book.fields.categories}.",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Detail",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.indigo),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16,),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Judul Buku",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${book.fields.title}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16,),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Pengarang",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${book.fields.authors}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16,),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Jumlah Halaman",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${book.fields.noOfPages}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16,),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Penerbit",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Keperpustakaan PBP A13",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ]
                      )
                    );
                  }
                }
              }
            ),
          ]
        )
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.indigoAccent[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink(
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.menu_book_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 4),
                Text('Detail', style: TextStyle(color: Colors.white)),
              ]
            ),
            IconButton(
              icon: Icon(Icons.comment, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookReviewPage(id: id, rating: rating), 
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isLoggedIn){
            if (isAdmin && isAdminMode){
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text("Anda dalam mode Admin, tidak dapat menambahkan item.", style: TextStyle(color: Colors.amber),),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.amber[50], 
              ));
            } else {
              final response = await request.postJson(
                "http://localhost:8000/book-info/add-to-cart-flutter/$id/1/",
                jsonEncode(<String, String>{
                  'amount': '1',
                })
              );
              if (response['status'] == 'success') {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Text("Berhasil menambahkan item ke keranjang!", style: TextStyle(color: Colors.grey[100]),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.indigoAccent[500], 
                ));
              } else if (response['status'] == 'failed') {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Text("Stock habis, gagal menambahkan item!", style: TextStyle(color: Colors.red[600]),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red[50], 
                ));
              }
              else {
                ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Terdapat kesalahan, silakan coba lagi."))
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text("Harap login terlebih dahulu!", style: TextStyle(color: Colors.indigoAccent),),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.indigo[50], 
            ));
          }
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}