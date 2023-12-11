import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_buku/book/models.dart';
import 'package:http/http.dart' as http;
import 'package:toko_buku/cart/models/cart_models.dart';
import 'package:toko_buku/cart/screen/payment.dart';
import 'package:toko_buku/cart/screen/topup.dart';
import 'package:toko_buku/order/screens/orderlist.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModels> orders = [];
  double userBalance = 100.0;
  double totalAmount = 0.0;

  Future<List<CartModels>> fetchOrders() async {
    final response = await http.get('http://localhost:8000/book-info/get-cart/' as Uri);

      // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<CartModels> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(CartModels.fromJson(d));
        }
    }
    return list_product;
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: orders.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, orderIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orders[orderIndex].books.length,
                      itemBuilder: (context, bookIndex) {
                        Book book = orders[orderIndex].books[bookIndex];
                        return ListTile(
                          title: Text(book.fields.title),
                          subtitle: Text('Price: \$${book.fields.price} | Quantity: ${book.quantity}'),
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (checkBalance()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(totalAmount: totalAmount)
              ),
            );
          } 
          // else {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => TopUpBalancePage(),
          //     ),
          //   );
          // }
        },
        child: Icon(Icons.payment),
      ),
    );
  }

  bool checkBalance() {
    double totalAmount = calculateTotalAmount();
    return userBalance >= totalAmount;
  }

  double calculateTotalAmount() {
    double total = 0;
    for (CartModels order in orders) {
      for (Book book in order.books) {
        total += (book.fields.price * book.quantity);
      }
    }
    return total;
  }
}
