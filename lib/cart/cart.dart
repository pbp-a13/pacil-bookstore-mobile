import 'package:flutter/material.dart';
import 'package:toko_buku/book/models.dart'; // Update with your actual model
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> orders = []; // Assume Order model contains purchased book details

  // Function to fetch initial order details (replace with your actual logic)
  Future<void> fetchOrders() async {
    // Simulated data - replace with actual logic
    List<Order> orderList = [
      //Order(
      //   orderId: '1',
      //   books: [
      //     Book(
      //       model: Model.BOOK_BOOK,
      //       pk: 1,
      //       fields: Fields(
      //         title: 'Book 1',
      //         price: 20,
      //       ),
      //     ),
      //     Book(
      //       model: Model.BOOK_BOOK,
      //       pk: 2,
      //       fields: Fields(
      //         title: 'Book 2',
      //         price: 15,
      //       ),
      //     ),
      //   ],
      // ),
      // Order(
      //   orderId: '2',
      //   books: [
      //     Book(
      //       model: Model.BOOK_BOOK,
      //       pk: 3,
      //       fields: Fields(
      //         title: 'Book 3',
      //         price: 25,
      //       ),
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
                    Text(
                      'Order ${orders[index].orderId}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: orders[index].books.length,
                      itemBuilder: (context, bookIndex) {
                        Book book = orders[index].books[bookIndex];
                        return ListTile(
                          title: Text(book.fields.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: \$${book.fields.price}'),
                              Text('Quantity: ${book.quantity}'), // Assume 'quantity' is a property in Order model
                            ],
                          ),
                          // Add more details or actions as needed
                        );
                      },
                    ),
                    Divider(),
                    Text(
                      'Total: \$${calculateOrderTotal(orders[index])}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
    );
  }

  double calculateOrderTotal(Order order) {
    double total = 0;
    for (Book book in order.books) {
      total += (book.fields.price * book.quantity);
    }
    return total;
  }
}
