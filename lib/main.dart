import 'package:flutter/material.dart';
// import 'package:pacil_inventory/screens/item_detail_page.dart';
// import 'package:pacil_inventory/screens/login.dart';
// import 'package:pacil_inventory/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/main/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child : MaterialApp(
        routes: {
          '/mainPage': (context) => MainPage(),
        },
      title: 'Pacil Inventory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MainPage(),
    ),
    );

  }
}

