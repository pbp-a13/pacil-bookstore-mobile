// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/order/models/order.dart';

import 'package:toko_buku/order/screens/list_orders.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback refreshOrders;

  const OrderCard(this.order, {required this.refreshOrders, super.key});

  Future<Book> fetchBook(request) async {
    var response = await request.postJson(
        "http://127.0.0.1:8000/order/get_book/",
        jsonEncode(<String, String>{
          'pk': order.fields.book.toString(),
        }));

    return Book.fromJson(response.first);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;

    String complete = "Finish";
    String status = "Ongoing";
    if (order.fields.isCompleted == true) {
      complete = "Completed";
      status = "Completed";
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      child: InkWell(
          onTap: () async {
            // _showOrder(context, request);
          },
          child: FutureBuilder<Book>(
              future: fetchBook(request),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Container(
                    width: lebar * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: tinggi * 0.4,
                          width: lebar * 0.6,
                          decoration: const BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.fields.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  status,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final response = await request.postJson(
                                              "http://127.0.0.1:8000/order/minus_order/",
                                              jsonEncode(<String, String>{
                                                'order_id': order.pk.toString(),
                                              }));
                                          if (response['status'] == true) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OrdersPage()),
                                            );
                                          }
                                        },
                                        child: const Icon(Icons.delete_outline),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child:
                                          Text(
                                            order.fields.quantity.toString(),
                                            textAlign: TextAlign.center,
                                            ),
                                    ),
                                    SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final response = await request.postJson(
                                              "http://127.0.0.1:8000/order/add_order/",
                                              jsonEncode(<String, String>{
                                                'order_id': order.pk.toString(),
                                              }));
                                          if (response['status'] == true) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OrdersPage()),
                                            );
                                          }
                                        },
                                        child: const Icon(Icons.add_outlined),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: lebar * 0.5,
                                  child: SizedBox(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (!order.fields.isCompleted) {
                                            await request.postJson(
                                                'http://127.0.0.1:8000/order/complete_order/',
                                                jsonEncode({
                                                  "order_id": order.pk.toString(),
                                                }));
                                            refreshOrders();
                                          }
                                        },
                                        child: Text(complete)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: tinggi * 0.4,
                          width: lebar * 0.3,
                          child: const Icon(
                            Icons.book_outlined,
                            size: 200,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })
          ),
    );
  }

  // void _showOrder(BuildContext context, request) {
  //   double lebar = MediaQuery.of(context).size.width;
  //   double tinggi = MediaQuery.of(context).size.height;

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: tinggi * 0.8,
  //         width: lebar * 0.8,
  //         padding: const EdgeInsets.all(10),
  //         child: Card(
  //           child: Column(
  //             children: [
  //               PreferredSize(
  //                 preferredSize: Size.fromHeight(
  //                     tinggi * 0.1), // Define the height of the AppBar
  //                 child: ClipRRect(
  //                   borderRadius: const BorderRadius.only(
  //                     topLeft: Radius.circular(
  //                         10.0), // Define the radius for the top left corner
  //                     topRight: Radius.circular(
  //                         10.0), // Define the radius for the top right corner
  //                   ),
  //                   child: AppBar(
  //                     title: const Text("Detail Buku"),
  //                     // Other AppBar properties
  //                   ),
  //                 ),
  //               ),
  //               FutureBuilder<Buku>(
  //                   future: fetchBuku(request, buku.pk),
  //                   builder: (context, snapshot) {
  //                     if (snapshot.connectionState == ConnectionState.waiting) {
  //                       return const CircularProgressIndicator();
  //                     } else {
  //                       return Container(
  //                         alignment: Alignment.center,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(5),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Container(
  //                                   decoration: const BoxDecoration(
  //                                     borderRadius:
  //                                         BorderRadius.all(Radius.circular(10)),
  //                                   ),
  //                                   width: lebar * 0.2,
  //                                   height: tinggi * 0.2,
  //                                   child: Image.network(
  //                                     snapshot.data!.fields.imageUrl,
  //                                     fit: BoxFit.cover,
  //                                     width: double.infinity,
  //                                   )),
  //                               SizedBox(height: tinggi * 0.02),
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   snapshot.data!.fields.title,
  //                                   textAlign: TextAlign.center,
  //                                   style: const TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 20,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   "Written By: ${snapshot.data!.fields.author}",
  //                                   textAlign: TextAlign.right,
  //                                   style: const TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 15,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   "ISBN: ${snapshot.data!.fields.isbn}",
  //                                   textAlign: TextAlign.right,
  //                                   style: const TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 15,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   "Publication Date: ${snapshot.data!.fields.publicationDate}",
  //                                   textAlign: TextAlign.right,
  //                                   style: const TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 15,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   "Category: ${snapshot.data!.fields.category}",
  //                                   textAlign: TextAlign.right,
  //                                   style: const TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 15,
  //                                   ),
  //                                 ),
  //                               ),
  //                               SizedBox(height: tinggi * 0.02),
  //                               Container(
  //                                 alignment: Alignment.topCenter,
  //                                 width: lebar * 0.8,
  //                                 height: tinggi * 0.4,
  //                                 child: SingleChildScrollView(
  //                                   child: Text(
  //                                     snapshot.data!.fields.description,
  //                                     textAlign: TextAlign.justify,
  //                                     style: const TextStyle(
  //                                       fontWeight: FontWeight.normal,
  //                                       fontSize: 10,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     }
  //                   }),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
