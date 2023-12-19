// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:toko_buku/account/models/review.dart';
// import 'package:toko_buku/book/models.dart';
// import 'package:toko_buku/main/widgets/left_drawer.dart';

// class BookReviewPage extends StatelessWidget {
//   BookReviewPage({super.key, required this.id});
//   final int id;

//   Future<Book> getBook() async {
//     var url = "http://localhost:8000/json/$id/";
//     final response = await http.get(Uri.parse(url), headers: {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     });
//     var data = jsonDecode(utf8.decode(response.bodyBytes));
//     // print(data);
//     var buku = Book.fromJson(data[0]);
//     // print(buku);
//     return buku;
//   }

//   Future<List<Review>> fetchItem(sort_mode) async {
//     print('sort mode: $sort_mode');
//     var url = Uri.parse('http://localhost:8000/sort-review/$sort_mode/');
//     var response = await http.get(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );

//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     List<Review> list_review = [];
//     for (var d in data) {
//       if (d != null) {
//         list_review.add(Review.fromJson(d));
//       }
//     }
//     return list_review;
//   }

//   Future<List<Review>> getBookReviews() async {
//     final url = Uri.parse('http://localhost:8000/get-book-review/$id/');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       // Parsing respons JSON ke dalam list review
//       List<dynamic> jsonReviews = jsonDecode(response.body);
//       List<Review> reviews = jsonReviews.map((json) => Review.fromJson(json)).toList();
//       return reviews;
//     } else if (response.statusCode == 404) {
//       print('Book not found.');
//       return [];
//     } else {
//       print('Failed to load reviews. Status code: ${response.statusCode}');
//       return [];
//     }
//   }

//   String selectedSortOption = 'User';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'Pacil Inventory',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         backgroundColor: Color.fromRGBO(68, 126, 212, 1),
//         foregroundColor: Colors.white,
//       ),
//       drawer: const LeftDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             FutureBuilder(
//               future: Future.wait([
//                 getBook(),
//                 getBookReviews(),
//                 // fetchItem(selectedSortOption),
//               ]),
//               builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//                 if (snapshot.data == null) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   Book book = snapshot.data![0];
//                   List<Review> reviews = snapshot.data![1] ?? [];
//                   if (reviews == null || reviews.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children : [
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Penilaian & Ulasan",
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.indigo),
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Container(
//                             width: MediaQuery.of(context).size.width - 32,
//                             height: 120,
//                             padding: EdgeInsets.all(25),
//                             margin: EdgeInsets.symmetric(vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Color.fromARGB(255, 207, 222, 255),
//                               border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text("${book.fields.rating}", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
//                                     SizedBox(width: 4),
//                                     Text("dari 5", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700)),
//                                   ],
//                                 ),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     for (int i = 1; i <= 5; i++)
//                                       Icon(Icons.star, size: 16, color: i < book.fields.rating ? Colors.black : Colors.black.withOpacity(0.2)),
//                                     SizedBox(width: 4),
//                                     Text("(${reviews.length})", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                 child: Text(
//                                   "Apply Sort:",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(4),
//                                 decoration: BoxDecoration(
//                                   // color: Color.fromARGB(255, 221, 183, 71),
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: DropdownButton<String>(
//                                   value: selectedSortOption,
//                                   onChanged: (String? newValue) {
//                                     // Handle dropdown value change
//                                     if (newValue != null) {
//                                       selectedSortOption = newValue;
//                                       // Implement your sorting logic here
//                                     }
//                                   },
//                                   items: ['User', 'Ulasan'].map((String option) {
//                                     return DropdownMenuItem<String>(
//                                       value: option,
//                                       child: Text(option),
//                                     );
//                                   }).toList(),
//                                 ),
//                               )
//                               // Container(
//                               //   padding: EdgeInsets.all(4),
//                               //   decoration: BoxDecoration(
//                               //     color: Color.fromARGB(255, 221, 183, 71),
//                               //     borderRadius: BorderRadius.circular(4),
//                               //   ),
//                               //   child: Text("Ascending", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
//                               // )
//                             ],
//                           ), 
//                           Container(
//                             height: MediaQuery.of(context).size.height - 378,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.sentiment_very_dissatisfied, size: 80, color: Colors.black.withOpacity(0.3)),
//                                 Text(
//                                   "Belum ada penilaian untuk buku ini.",
//                                   style: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 20, fontWeight: FontWeight.w600,),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ]
//                       )
//                     );
//                   } else {
//                     // List<Review> reviews = snapshot.data ?? [];
//                     return ListView.builder(
//                       itemCount: reviews.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: Column(
//                             children: [
//                               ////////////////////////
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   "Penilaian & Ulasan",
//                                   textAlign: TextAlign.start,
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.indigo),
//                                 ),
//                               ),
//                               SizedBox(height: 6),
//                               Container(
//                                 width: MediaQuery.of(context).size.width - 32,
//                                 height: 120,
//                                 padding: EdgeInsets.all(25),
//                                 margin: EdgeInsets.symmetric(vertical: 10),
//                                 decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 207, 222, 255),
//                                   border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Text("${book.fields.rating}", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
//                                         SizedBox(width: 4),
//                                         Text("dari 5", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700)),
//                                       ],
//                                     ),
//                                     SizedBox(height: 10),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         for (int i = 1; i <= 5; i++)
//                                           Icon(Icons.star, size: 16, color: i < book.fields.rating ? Colors.black : Colors.black.withOpacity(0.2)),
//                                         SizedBox(width: 4),
//                                         Text("(${reviews.length})", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               Row(
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                     child: Text(
//                                       "Apply Sort:",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.all(4),
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 221, 183, 71),
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                     child: Text("Ascending", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
//                                   )
//                                 ],
//                               ),
//                               /////////////////////////////////
//                               SizedBox(height: 20),
//                               for (int i = 0; i < reviews.length; i++)
//                                 Container(
//                                   width: MediaQuery.of(context).size.width - 32,
//                                   padding: EdgeInsets.all(25),
//                                   margin: EdgeInsets.symmetric(vertical: 10),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "${reviews[i].username}", 
//                                           style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
//                                         ),
//                                       ),                    
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                                         alignment: Alignment.centerLeft,
//                                         child: Row(
//                                           children: [
//                                             Icon(Icons.star, color: Colors.yellow, size: 20,),
//                                             SizedBox(height: 10),
//                                             Text("${reviews[i].rating}", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "${reviews[i].reviewText}", 
//                                           style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
//                                         ),
//                                       ),  
//                                     ],
//                                   ),
//                                 ),
//                             ]
//                           ),
//                         );
//                       }
//                     );
//                   }
//                 }
//               },
//             ),
//           ]
//         )
//       )
//     );
//   }
// }