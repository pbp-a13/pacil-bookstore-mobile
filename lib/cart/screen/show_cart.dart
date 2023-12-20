// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:toko_buku/cart/models/cart.dart';

// class ShowCartPage extends StatelessWidget {
//   ShowCartPage({super.key});

//   Future<List<Cart>> fetchCartList() async {
//     var url = 'http://localhost:8000/book-info/get-cart-flutter/';
//     var response = await http.get(Uri.parse(url), headers: {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     });

//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     List<Cart> listCart = [];
//     for (var d in data) {
//       if (d != null) {
//         listCart.add(Cart.fromJson(d));
//       }
//     }
//     print(listCart.toString());
//     return listCart;
//     // return [
//     //   Cart(pk: 1, book: Book(pk: 1, title: 'Sample Book', author: 'John Doe', price: 20), totalAmount: 40),
//     //   // dummy
//     // ];
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
//         title: Text('Your Cart'),
//       ),
//       body: FutureBuilder<List<Cart>>(
//         future: fetchCartList(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             print(snapshot.data);
//             return Center(
//               child: Text('Your cart is empty.'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 Cart cart = snapshot.data![index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(cart.book.title),
//                     subtitle: Text('${cart.book.author} - \$${cart.book.price}'),
//                     trailing: Text('Total: \$${cart.totalAmount}'),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
