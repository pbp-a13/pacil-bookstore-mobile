import 'package:flutter/material.dart';
import 'package:toko_buku/account/screens/login.dart';
import 'package:toko_buku/cart/cart.dart';
// import 'package:pacil_inventory/models/item.dart';
// import 'package:pacil_inventory/screens/list_item.dart';
// import 'package:pacil_inventory/screens/menu.dart';
// import 'package:pacil_inventory/screens/inventory_list_form.dart';
import 'package:toko_buku/main/screens/main_page.dart';
import 'package:toko_buku/order/screens/orderlist.dart';
import 'package:toko_buku/book_info/screens/book_info.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
    color: Colors.indigo,
  ),
  child: Column(
    children: [
      Text(
        'Pacil Inventory',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Padding(padding: EdgeInsets.all(10)),
      Text("Catat seluruh keperluan inventory-mu di sini!",
          textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          ),
      ),
    ],
  ),
          ),
          ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Halaman Utama'),
  // Bagian redirection ke MyHomePage
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
  },
),

ListTile(
    leading: const Icon(Icons.shopping_basket),
    title: const Text('Daftar Item'),
    onTap: () {
        // Route menu ke halaman produk
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
        );
    },
),

// ListTile(
//   leading: const Icon(Icons.add_shopping_cart),
//   title: const Text('Tambah Item'),
//   // Bagian redirection ke InventoryFormPage
//   onTap: () {
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const InventoryFormPage(),
//         ));
//   },
// ),

// buat ngetest aja
// ListTile(
//   leading: const Icon(Icons.read_more),
//   title: const Text('Book Info'),
//   onTap: () {
//     Navigator.pushNamed(
//       context,
//       BookInfoPage.routeName,
//       arguments: BookInfoArguments(
//         bookId: "62" // dummy
//       ),
//     );
//   },
// ),

ListTile(
  leading: const Icon(Icons.add_shopping_cart),
  title: const Text('Login'),
  // Bagian redirection ke InventoryFormPage
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  },
),
        ],
      ),
    );
  }
}