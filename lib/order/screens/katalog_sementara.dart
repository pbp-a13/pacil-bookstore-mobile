// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';

class KatalogPage extends StatefulWidget {
  const KatalogPage({Key? key}) : super(key: key);

  @override
  _KatalogPageState createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  Future<List<Book>> fetchBook(request) async {
    var response = await request.get(
      'http://127.0.0.1:8000/order/all_books/',
    );

    List<Book> listBook = [];
    for (var d in response) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: const LeftDrawer(),
        appBar: AppBar(
          title: const Text('Katalog'),
        ),
        body: FutureBuilder(
            future: fetchBook(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.authors}"),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: width * 0.5,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          child: const Text(
                                            'Order',
                                            style: TextStyle(
                                              fontSize: 10, // Font size
                                              fontWeight: FontWeight
                                                  .bold, // Font weight
                                            ),
                                          ),
                                          onPressed: () async {
                                            final response = await request.postJson(
                                                "http://127.0.0.1:8000/order/make_order/",
                                                jsonEncode(<String, String>{
                                                  'pk': snapshot.data![index].pk
                                                      .toString()
                                                }));
                                            if (response['status'] == true) {
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Book has been ordered!")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Book is already ordered!")));
                                            }
                                          })),
                                ),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
