// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:toko_buku/account/models/account.dart';
import 'package:toko_buku/account/screens/admin_profile.dart';
import 'package:toko_buku/account/screens/all_members_page.dart';
import 'package:toko_buku/account/screens/login.dart';
import 'package:toko_buku/account/screens/member_profile.dart';
import 'package:toko_buku/account/screens/register.dart';
import 'package:toko_buku/account/screens/review_page.dart';
import 'package:toko_buku/cart/screen/cart.dart';
import 'package:toko_buku/cart/screen/show_cart.dart';
import 'package:toko_buku/main/models/admin.dart';
// import 'package:pacil_inventory/models/item.dart';
// import 'package:pacil_inventory/screens/list_item.dart';
// import 'package:pacil_inventory/screens/menu.dart';
// import 'package:pacil_inventory/screens/inventory_list_form.dart';
import 'package:toko_buku/main/screens/main_page.dart';
import 'package:toko_buku/order/screens/list_orders.dart';
import 'package:toko_buku/order/screens/orderlist.dart';
import 'package:toko_buku/book_info/screens/book_info.dart';
import 'package:http/http.dart' as http;

class LeftDrawer extends StatelessWidget {
  final bool isLoggedIn;
  final bool isAdmin;
  final bool isAdminMode;

  const LeftDrawer(
      {Key? key,
      required this.isLoggedIn,
      required this.isAdmin,
      required this.isAdminMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    print(request.jsonData['username']);
    var childrenTemp = [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.indigo,
        ),
        child: Column(
          children: [
            Text(
              'Pacil Bookstore',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Cari Buku Yang Diinginkan",
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
                builder: (context) => const MainPage(),
              ));
        },
      ),
      if (isLoggedIn == false)
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Register'),
          // Bagian redirection ke InventoryFormPage
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RegisterPage(key: key, cookieRequest: request),
                ));
          },
        ),
      if (isLoggedIn && isAdminMode == false)
        ListTile(
          leading: const Icon(Icons.reviews_rounded),
          title: const Text('See Reviews'),
          // Bagian redirection ke MyHomePage
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemberReviewsPage(
                  key: key,
                  cookieRequest: request,
                ),
              ),
            );
          },
        ),

      if (isLoggedIn && isAdminMode == false)
        ListTile(
          leading: const Icon(Icons.shopping_basket),
          title: const Text('Daftar Item'),
          onTap: () async {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
              );
          },
      ),

      if (isLoggedIn)
        ListTile(
          leading: const Icon(Icons.account_box),
          title: isAdminMode
              ? const Text('Account Info(Admin)')
              : const Text('Account Info(Member)'),
          onTap: () async {
            if (isAdminMode) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminAccountInformationPage(
                    key: key,
                    cookieRequest: request,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountInformationPage(
                    key: key,
                    cookieRequest: request,
                  ),
                ),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.read_more),
          title: const Text('Your Orders'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersPage(),
                ));
          },
        ),
      ],
        
        

      if (isAdminMode == true)
        ListTile(
          leading: const Icon(Icons.account_box_rounded),
          title: const Text('See All Account Info'),
          // Bagian redirection ke MyHomePage
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemberListScreen(
                  key: key,
                  cookieRequest: request,
                ),
              ),
            );
          },
        ),
//       if (isLoggedIn)
//         ListTile(
//             leading: const Icon(Icons.shopping_basket),
//             title: const Text('Daftar Item'),
//             onTap: () {
//                 // Route menu ke halaman produk
//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ShowCartPage()),
//                 );
//             },
//         ),

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
      //       arguments: BookInfoArguments(bookId: "62" // dummy
      //           ),
      //     );
      //   },
      // ),

// buat ngetest aja
      
    ];
    if (isLoggedIn == true) {
      childrenTemp += [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async {
            final response = await request.logout(
                // TODO: Ganti URL sesuai kebutuhan
                "https://pts-a13.vercel.app/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
          },
        ),
      ];
      if (isAdmin == true) {
        String listText;
        if (isAdminMode == true) {
          listText = "Member";
        } else {
          listText = "Admin";
        }
        childrenTemp += [
          ListTile(
              leading: const Icon(Icons.mode),
              title: Text('$listText Mode'),
              onTap: () async {
                final response = await request
                    .post('https://pts-a13.vercel.app/switch_mode_flutter', {
                  "username": request.jsonData["username"],
                });

                // melakukan decode response menjadi bentuk json
                request.jsonData["is_admin_mode"] = response["is_admin_mode"];
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );

                //print(data);
              }),
        ];
      }
    } else {
      childrenTemp += [
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text('Login'),
          // Bagian redirection ke InventoryFormPage
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          },
        ),
      ];
    }
    return Drawer(
      child: ListView(children: childrenTemp),
    );
  }
}
