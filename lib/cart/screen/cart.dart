import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/cart/models/cart_models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart App',
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModels> orders = [];
  double userBalance = 100.0;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fetchOrders().then((fetchedOrders) {
      setState(() {
        orders = fetchedOrders;
        totalAmount = calculateTotalAmount(orders);
      });
    });
  }

  Future<List<CartModels>> fetchOrders() async {
    var url = Uri.parse('http://127.0.0.1:8000/book-info/get-cart-flutter/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<CartModels> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(CartModels.fromJson(d));
      }
    }

    return listProduct;
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
              // Add Card for each book in the order
              ...orders[orderIndex].books.map((Book book) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile( 
                    title: Text(book.fields.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Author: ${book.fields.authors}'),
                        Text('Price: \$${book.fields.price}'),
                        Text('Quantity: ${book.quantity}'),
                      ],
                    ),
                  ),
                );
              }).toList(),
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
                builder: (context) => PaymentPage(totalAmount: totalAmount),
              ),
            );
          } else {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => TopUpBalancePage(),
            //   ),
            // );
          }
        },
        child: Icon(Icons.payment),
      ),
    );
  }

  bool checkBalance() {
    return userBalance >= totalAmount;
  }

  double calculateTotalAmount(List<CartModels> orders) {
    double total = 0;
    for (CartModels order in orders) {
      for (Book book in order.books) {
        total += (book.fields.price * book.quantity);
      }
    }
    return total;
  }
}


class PaymentPage extends StatelessWidget {
  final double totalAmount;

  const PaymentPage({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent, // Warna latar belakang
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                handlePayment(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Warna latar belakang tombol
              ),
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void handlePayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Thank you for your purchase!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}