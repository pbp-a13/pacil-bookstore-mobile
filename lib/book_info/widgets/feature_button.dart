import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/book_info/screens/edit_form.dart';

class FeatureButton {
  final String name;
  final IconData icon;
  final Color color;
  final int bookId;

  FeatureButton(this.name, this.icon, this.color, this.bookId);
}

class DisplayButton extends StatelessWidget {
  final FeatureButton button;
  const DisplayButton(this.button, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();  
    return Material(
      color: button.color,
      child: InkWell(
        onTap: () async {
          if (button.name == "Edit") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditFormPage(bookId: button.bookId)),
            );
          }
          if (button.name == "Masukkan Keranjang") {
            final response = await request.postJson(
              "http://localhost:8000/book-info/add-to-cart-flutter/${button.bookId}/1/",
              jsonEncode(<String, String>{
                'amount': '1',
              })
            );
            if (response['status'] == 'success') {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text("Berhasil menambahkan item ke keranjang!")));
            } else {
              ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Terdapat kesalahan, silakan coba lagi."))
              );
            }
          }
          if (button.name == "Delete"){
            bool confirmDelete = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Konfirmasi Hapus"),
                  content: Text("Apakah Anda yakin ingin menghapus buku ini?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // No, do not delete
                      },
                      child: Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // Yes, delete
                      },
                      child: Text("Hapus"),
                    ),
                  ],
                );
              },
            );
            if (confirmDelete == true) {
              final response = await request.postJson(
                "http://localhost:8000/delete-flutter/${button.bookId}/",
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
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 40,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: button.name == "Masukkan Keranjang" ? Colors.white : button.color,
            border: button.name == "Masukkan Keranjang" ? Border.all(width: 1, color: button.color) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                button.icon, size: 16, color: button.name == "Masukkan Keranjang" ? Colors.blue : Colors.white,
                ),
              SizedBox(width: 8),
              Text(
                button.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: button.name == "Masukkan Keranjang" ? Color(0xFF0066FF) : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}