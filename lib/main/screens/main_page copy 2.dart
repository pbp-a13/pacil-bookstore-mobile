// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:toko_buku/book/models.dart';
// import 'package:toko_buku/main/widgets/left_drawer.dart';
// import 'package:toko_buku/main/widgets/search_sort.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';




// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   var value = "";
//   var search_text = ""; 
//   var search_mode = "";



//   Future<List<Book>> fetchItem(request, value, search_mode, sort_mode) async {
    

//     value = value.replaceAll(' ', '+');

//     final response = await request.postJson(
//       "https://pts-a13.vercel.app/json-flutter/",
//       jsonEncode(<String, String>{
//           'value': value.toString(),
//           'search_mode': search_mode.toString(),
//           'sort_mode': sort_mode.toString(),
//           // TODO: Sesuaikan field data sesuai dengan aplikasimu
//       }));
//     // if (search_mode == "title"){
//     //   if (sort_mode == "title"){

//     //   }
//     //   else{

//     //   }
//     // }
//     // else{
//     //   if (sort_mode == "title"){

//     //   }
//     //   else{
        
//     //   }
//     // }

//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     List<Book> listItem = [];
//     for (var d in data) {
//       if (d != null) {
//         listItem.add(Book.fromJson(d));
//       }
//     }
//     return listItem;
//   }


//   String searchText = '';
//   String radioGroup1 = '';
//   String radioGroup2 = '';

//   void collectStates(String searchText, String radioGroup1, String radioGroup2) {
//     // Do something with the states...
//     setState(() {
//       this.searchText = searchText;
//       this.radioGroup1 = radioGroup1;
//       this.radioGroup2 = radioGroup2;
//     });

//     // Print or perform any action with the collected states
    

//     print('Search Text: $searchText');
//     print('Radio Group 1: $radioGroup1');
//     print('Radio Group 2: $radioGroup2');
//   }

//   @override
//   Widget build(BuildContext context) {
//             final request = context.watch<CookieRequest>();

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(150.0),
//         child: AppBar(
//           toolbarHeight: 150,
//           title: MyRowWidget(onSubmit: collectStates),
//         ),
//       ),
//       drawer: const LeftDrawer(),
//       body: FutureBuilder(
//         future: fetchItem(request, "", "title", "title"),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             if (!snapshot.hasData) {
//               return const Column(
//                 children: [
//                   Text(
//                     "Tidak ada data Item.",
//                     style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               );
//             } else {
//               return LayoutBuilder(
//                 builder: (context, constraints) {
//                   final double cardWidth = 200.0; // Adjust as needed
//                   final int crossAxisCount =
//                       (constraints.maxWidth / cardWidth).floor();
//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount,
//                       crossAxisSpacing: 0.0,
//                       mainAxisSpacing: 0.0,
//                     ),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (_, index) => GestureDetector(
//                       onTap: () {
//                         // Handle the card tap, e.g., navigate to detail page
//                         // Navigator.pushNamed(
//                         //   context,
//                         //   ItemDetailPage.routeName,
//                         //   arguments: ItemDetailArguments(
//                         //     "${snapshot.data![index].pk}"
//                         //   ),
//                         // );
//                       },
//                       child: Card(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 5,
//                           vertical: 5,
//                         ),
//                         child: Container(
//                           constraints: BoxConstraints(
//                             maxWidth: cardWidth,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${snapshot.data![index].fields.title}",
//                                   style: const TextStyle(
//                                     fontSize: 13.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   softWrap: true,
//                                   maxLines: 5,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   "${snapshot.data![index].fields.authors}",
//                                   style: const TextStyle(
//                                     fontSize: 9,
//                                   ),
//                                   softWrap: true,
//                                   overflow: TextOverflow.ellipsis,
//                                   ),
//                                 const SizedBox(height: 10),
//                                   Text(
//                                     "${snapshot.data![index].fields.price}",
//                                     style: const TextStyle(
//                                       fontSize: 9,
//                                     ),
//                                     softWrap: true,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }
