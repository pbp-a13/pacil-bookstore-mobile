import 'package:flutter/material.dart';
import 'package:toko_buku/book/models.dart';
import 'package:http/http.dart' as http;
import 'package:toko_buku/cart/screen/topup.dart';
import 'package:toko_buku/order/screens/orderlist.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> orders = [];
  double userBalance = 100.0; // ganti

  //
  Future<void> fetchOrders() async {
    // ganti
    List<Order> orderList = [
      // Order(
      //   orderId: '1',
      //   books: [
      //     Book(
      //       model: Model.BOOK_BOOK,
      //       pk: 1,
      //       fields: Fields(
      //         title: 'Book 1',
      //         price: 20,
      //       ),
      //       quantity: 2,
      //     ),
      //     Book(
      //       model: Model.BOOK_BOOK,
      //       pk: 2,
      //       fields: Fields(
      //         title: 'Book 2',
      //         price: 15,
      //       ),
      //       quantity: 1,
      //     ),
      //   ],
      // ),
    ];

    setState(() {
      orders = orderList;
    });
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
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Display
                  Text(
                    'Order ID: ${orders[orderIndex].orderId}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  // ... (Other order-related details)

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
                builder: (context) => OrderListPage(orders: orders),
              ),
            );
          } else {
            // If balance is insufficient, navigate to TopUpBalancePage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopUpBalancePage(),
              ),
            );
          }
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
    for (Order order in orders) {
      for (Book book in order.books) {
        total += (book.fields.price * book.quantity);
      }
    }
    return total;
  }
}
