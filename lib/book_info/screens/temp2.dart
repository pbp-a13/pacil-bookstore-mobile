// import 'dart:convert';
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:toko_buku/account/models/review.dart';
// import 'package:toko_buku/book/models.dart';
// import 'package:toko_buku/book_info/screens/book_info.dart';
// import 'package:toko_buku/book_info/widgets/sort.dart';
// import 'package:toko_buku/main/widgets/left_drawer.dart';

// class BookReviewPage extends StatefulWidget {
//   BookReviewPage({Key? key, required this.id, required this.rating});
//   final int id;
//   int rating;

//   @override
//   _BookReviewState createState() => _BookReviewState();
// }
// class _BookReviewState extends State<BookReviewPage>  {
//   var sort_mode = 'review_text';

//   Future<List<Review>> fetchReview(sort_mode) async {
//     var url = Uri.parse('https://pts-a13.vercel.app/book-info/sort-review-flutter/$sort_mode/');
//     var response = await http.get(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );

//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     List<Review> listReview = [];
//     for (var d in data) {
//       if (d != null) {
//         listReview.add(Review.fromJson(d));
//       }
//     }
//     return listReview;
//   }

//   String selectedOption = '';

//   collectStates(String selectedOption) {
//     setState(() {
//       this.selectedOption = selectedOption;
//     });
//     sort_mode = selectedOption;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     var isLoggedIn;
//     var isAdmin;
//     var isAdminMode;
//     var cookieData = request.jsonData;
//     if (cookieData.length == 0){
//       isLoggedIn = false;
//       isAdmin = false;
//       isAdminMode = false;
//     }
//     else{
//       isLoggedIn = true;
//       isAdmin = cookieData['is_admin'];
//       isAdminMode = cookieData['is_admin_mode'];
//     }

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white,),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: SortWidget(onSubmit: collectStates),
//         backgroundColor: Colors.indigoAccent[400],
//       ),
//       body: FutureBuilder(
//         future: fetchReview(sort_mode),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             if (!snapshot.hasData) {
//               return Column(
//                 children: [
//                   // SortWidget(onSubmit: collectStates),
//                   Container(
//                     height: MediaQuery.of(context).size.height - 378,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.sentiment_very_dissatisfied, size: 80, color: Colors.black.withOpacity(0.3)),
//                         Text(
//                           "Belum ada penilaian untuk buku ini.",
//                           style: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 20, fontWeight: FontWeight.w600,),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               return LayoutBuilder(
//                 builder: (context, Constraints) {
//                   double cardWidth = MediaQuery.of(context).size.width - 32.0; // Adjust as needed
//                   const int crossAxisCount = 1;
//                   var cardColor = Colors.white;
//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount,
//                       crossAxisSpacing: 0.0,
//                       mainAxisSpacing: 0.0,
//                     ),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (_, index) => InkWell(
//                       child: Card(
//                         color: cardColor,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: Container(
//                           constraints: BoxConstraints(
//                             maxWidth: cardWidth,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "${snapshot.data![index].username}", 
//                                     style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
//                                   ),
//                                 ),                    
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                                   alignment: Alignment.centerLeft,
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.star, color: Colors.yellow, size: 20,),
//                                       SizedBox(height: 10),
//                                       Text("${widget.rating}", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "${snapshot.data![index].review_text}", 
//                                     style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
//                                   ),
//                                 ),  
//                               ],
//                             ),
//                           )
//                         ),
//                       ),
//                     )
//                   );
//                 },
//               );
//             }
//           }
//         }
//       ),
//       bottomNavigationBar: BottomAppBar(
//         height: 90,
//         shape: CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         color: Colors.indigoAccent[400],
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(Icons.menu_book_rounded, color: Colors.white),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Ink(
//                   decoration: ShapeDecoration(
//                     color: Colors.white.withOpacity(0.1), // Warna latar belakang icon
//                     shape: CircleBorder(),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.comment, color: Colors.white),
//                     onPressed: () {},
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text('Ulasan', style: TextStyle(color: Colors.white)),
//               ]
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }