import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:pacil_inventory/models/item.dart';
// import 'package:pacil_inventory/screens/item_detail_page.dart';
// import 'package:pacil_inventory/widgets/left_drawer.dart';

import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';
import 'package:toko_buku/main/widgets/search_sort.dart';

class MainPage extends StatefulWidget {
    const MainPage({Key? key}) : super(key: key);

    @override
    _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
Future<List<Book>> fetchItem() async {
    // ATTN: Ganti URL sesuai kebutuhan
    var url = Uri.parse(
        'http://localhost:8000/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Item
    List<Book> listItem = [];
    for (var d in data) {
        if (d != null) {
            listItem.add(Book.fromJson(d));
        }
    }
    return listItem;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0), 
          child : AppBar(
            toolbarHeight: 150,
            title: MyRowWidget(onSubmit: (String searchText, String radioGroup1, String radioGroup2) {  },),
          ),
        ),
          drawer: const LeftDrawer(),
          body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data Item.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => 
                        
                        GestureDetector(
                        // When the child is tapped, show a snackbar.
                        // onTap: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   ItemDetailPage.routeName,
                        //   arguments: ItemDetailArguments(
                        //     "${snapshot.data![index].pk}"
                        //   ),
                        // );
                        // },
                        // The custom button
                        child: Container(
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
                                    Text(
                                        "${snapshot.data![index].fields.price}")
                                ],
                                ),
                                
                            )
                      )
                        
                        
                        );
                    }
                }
            }));
    }
}