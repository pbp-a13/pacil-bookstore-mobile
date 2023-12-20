import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toko_buku/book/models.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditFormPage extends StatefulWidget {
  static const String routeName = '/editForm';

  final int bookId;

  EditFormPage({required this.bookId, Key? key}) : super(key: key);

  @override
  _EditFormPageState createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _authors = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _stock = TextEditingController();
  TextEditingController _price = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Ambil data buku dan set nilai awal controller
    fetchBookData(widget.bookId);
  }

  Future<Book> fetchItem(String bookId) async {
    var url = Uri.parse('https://pts-a13.vercel.app/book-info/json/${bookId}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return Book.fromJson(data[0]);
  }

  Future<void> fetchBookData(int bookId) async {
    final Book book = await fetchItem(bookId.toString());
    setState(() {
      _authors.text = book.fields.authors ?? '';
      _title.text = book.fields.title;
      _stock.text = book.fields.stock.toString();
      _price.text = book.fields.price.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Judul Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _title,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Judul tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pengarang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _authors,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama pengarang tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _stock,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Stok tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Stok buku harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _price,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Kirim ke Django dan tunggu respons
                    final response = await request.post(
                      "https://pts-a13.vercel.app/book-info/edit-flutter/${widget.bookId}/",
                      // headers: <String, String>{
                      //   'Content-Type': 'application/json; charset=UTF-8',
                      // },
                      jsonEncode(<String, String>{
                        'title': _title.text,
                        'authors': _authors.text,
                        'price': _price.text,
                        'stock': _stock.text,
                      }),
                    );
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Perubahan berhasil disimpan!"),
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Terdapat kesalahan, silakan coba lagi."),
                      ));
                    }
                    Navigator.pop(context); // Navigate back
                  }
                },
                child: const Text('Save',
                    style: TextStyle(color: Colors.indigoAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
