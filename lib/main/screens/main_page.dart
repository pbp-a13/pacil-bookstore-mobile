import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/book_info/screens/book_info.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';
import 'package:toko_buku/main/widgets/search_sort.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = '/mainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var value = "*None*";
  var search_mode = "";
  var sort_mode = "";

  Future<List<Book>> fetchItem(value, search_mode, sort_mode) async {
    var url;
    if (value != null) {
      value = value.replaceAll(' ', '+');
    }
    if (value == '' || value == null) {
      value = "*None*";
    }
    if (search_mode == null || search_mode == '') {
      search_mode = 'title';
      sort_mode = 'title';
    }
    url = Uri.parse(
        'https://pts-a13.vercel.app/json-flutter/$value/$search_mode/$sort_mode');

    print(url);

    // if (search_mode == "title"){
    //   if (sort_mode == "title"){
    //     url = 'https://pts-a13.vercel.app/json-flutter/$value/$search_mode/$sort_mode';
    //   }
    //   else{

    //   }
    // }
    // else{
    //   if (sort_mode == "title"){

    //   }
    //   else{

    //   }
    // }

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(Book.fromJson(d));
      }
    }
    return listItem;
  }

  String searchText = '';
  String radioGroup1 = '';
  String radioGroup2 = '';

  collectStates(String searchText, String radioGroup1, String radioGroup2) {
    // Do something with the states...
    setState(() {
      this.searchText = searchText;
      this.radioGroup1 = radioGroup1;
      this.radioGroup2 = radioGroup2;
    });

    value = searchText;
    search_mode = radioGroup1;
    sort_mode = radioGroup2;

    // Print or perform any action with the collected states

    // fetchItem(searchText, radioGroup1, radioGroup2);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    print(request.jsonData);
    // final request = context.watch<CookieRequest>();
    // var value, search_mode, sort_mode = collectStates(searchText, radioGroup1, radioGroup2);
    //     print('build value: $value');
    //     print('build search mode: $search_mode');
    //     print('build sort mode: $sort_mode');

    var isLoggedIn;
    var isAdmin;
    var isAdminMode;
    var cookieData = request.jsonData;
    if (cookieData.length == 0) {
      isLoggedIn = false;
      isAdmin = false;
      isAdminMode = false;
    } else {
      isLoggedIn = true;
      isAdmin = cookieData['is_admin'];
      isAdminMode = cookieData['is_admin_mode'];
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          toolbarHeight: 150,
          title: MyRowWidget(onSubmit: collectStates),
        ),
      ),
      drawer: LeftDrawer(
          isLoggedIn: isLoggedIn, isAdmin: isAdmin, isAdminMode: isAdminMode),
      body: FutureBuilder(
        future: fetchItem(value, search_mode, sort_mode),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data Item.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return LayoutBuilder(
                builder: (context, constraints) {
                  const double cardWidth = 200.0; // Adjust as needed
                  final int crossAxisCount =
                      (constraints.maxWidth / cardWidth).floor();
                  var cardColor = Colors.white70;
                  //TODO: Handle Jika berbagai role
                  if (isLoggedIn) {
                    if (isAdmin) {
                      if (isAdminMode) {
                        cardColor = Colors.yellow;
                      } else {}
                    }
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        // Handle the card tap, e.g., navigate to detail pageb
                        // Navigator.pushNamed(
                        //   context,
                        //   BookInfoPage.routeName,
                        //   arguments: BookInfoArguments(
                        //     bookId: "${snapshot.data![index].pk}"
                        //   ),
                        // );
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return BookInfoPage(
                              id: snapshot.data![index].pk!,
                            );
                          },
                        ));
                      },
                      child: Card(
                        color: cardColor,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: cardWidth,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${snapshot.data![index].fields.authors}",
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${snapshot.data![index].fields.price}",
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
