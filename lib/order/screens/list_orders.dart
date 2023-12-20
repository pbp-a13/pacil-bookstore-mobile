// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';
import 'package:toko_buku/order/models/order.dart';
import 'package:toko_buku/order/widgets/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<String> filterOptions = ["completed", "noncompleted"];
  String filter = "noncompleted";

  Future<List<Order>>? orders;

  Future<List<Order>>? fetchOrders(request, filter) async {
    var response = await request.postJson(
        "http://127.0.0.1:8000/order/show_user_orders/",
        jsonEncode({
          "filter": filter,
        }));

    List<Order> listOrders = [];
    for (var d in response) {
      if (d != null) {
        listOrders.add(Order.fromJson(d));
      }
    }
    return listOrders;
  }

  void refreshOrders() {
    setState(() {
      orders = fetchOrders(context.read<CookieRequest>(), filter);
    });
  }

  @override
  void initState() {
    super.initState();
    filter = filterOptions.last;
    refreshOrders();
  }

  Widget _buildFilterButton(
      BuildContext context, String buttonText, String filterValue) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              filter = filterValue;
              refreshOrders();
            });
          },
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton(context, "Ongoing", "noncompleted"),
                _buildFilterButton(context, "Completed", "completed"),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<List<Order>>(
                future: orders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 1,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return OrderCard(snapshot.data![index],
                            refreshOrders: refreshOrders);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
