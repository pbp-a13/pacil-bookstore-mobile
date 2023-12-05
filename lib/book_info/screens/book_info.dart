import 'package:flutter/material.dart';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';
import 'package:toko_buku/main/widgets/search_sort.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookInfoPage extends StatelessWidget {
  BookInfoPage({Key? key}) : super(key: key);

    final List<FeatureButton> button = [
      FeatureButton("Edit", Icons.edit, Colors.blue),
      FeatureButton("Delete", Icons.delete, Colors.red),
      FeatureButton("Masukkan Keranjang", Icons.add_shopping_cart, Colors.lightBlueAccent),
    ];

  // @override
  // _BookInfoPageState createState() => _BookInfoPageState();
// }

// class _BookInfoPageState extends State<BookInfoPage> {
  // List<Order> orders = []; // Assume Order model contains purchased book details

  // // Function to fetch initial order details (replace with your actual logic)
  // Future<void> fetchOrders() async {
  //   // Simulated data - replace with actual logic
  //   List<Order> orderList = [
  //   ];

  //   setState(() {
  //     orders = orderList;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchOrders();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFFFFBFF)),
          child: Stack(
            children: [
              Positioned(
                left: 19,
                top: 0,
                child: Container(
                  width: 322,
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 174,
                        height: 206,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Burroughs, Edgar Rice, 1875-1950',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'A Princess of Mars',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Rp100.000',
                                          style: TextStyle(
                                            color: Color(0xFF0066FF),
                                            fontSize: 24,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Container(
                                          width: 86,
                                          height: double.infinity,
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF2FCE22),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Stok Tersedia',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Container(
                                              //   width: 15,
                                              //   height: 15,
                                              //   clipBehavior: Clip.antiAlias,
                                              //   decoration: BoxDecoration(),
                                              //   child: Stack(children: [
                                              //   ,
                                              //   ]),
                                              // ),
                                              // const SizedBox(width: 4),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          '|',
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          '16',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Terjual',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GridView.count(
                                    primary: true,
                                    padding: const EdgeInsets.all(0),
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 3,
                                    shrinkWrap: true,
                                    children: button.map((FeatureButton button) {
                                      // Iterasi untuk setiap button
                                      return DisplayButton(button);
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kategori',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 321,
                                    child: Text(
                                      'Science fiction; Mars (Planet) -- Fiction',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deskripsi',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 321,
                                    child: Text(
                                      'Buku karya Burroughs, Edgar Rice, 1875-1950 dengan kategori Science fiction; Mars (Planet) -- Fiction',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Detail',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'Judul Buku',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'A Princess of Mars',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'Pengarang',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'Burroughs, Edgar Rice, 1875-1950',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'Jumlah Halaman',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  '965',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'Penerbit',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 321,
                                                child: Text(
                                                  'Keperpustakaan PBP A13',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Penilaian & Ulasan',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 321,
                                                height: 108,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 0,
                                                      child: Container(
                                                        width: 321,
                                                        height: 108,
                                                        decoration: ShapeDecoration(
                                                          color: Color(0xFFD2E4FF),
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(width: 1, color: Color(0xFFD2D2D2)),
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 91,
                                                      top: 25,
                                                      child: Container(
                                                        width: 140,
                                                        height: 58,
                                                        padding: const EdgeInsets.only(top: 4, left: 12, right: 10, bottom: 3),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    '0',
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 20,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w700,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 4),
                                                                  Text(
                                                                    'dari 5',
                                                                    style: TextStyle(
                                                                      color: Colors.black.withOpacity(0.5),
                                                                      fontSize: 14,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w700,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Container(
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: BoxDecoration(),
                                                                    child: Stack(children: [ 
                                                                      Icon(
                                                                        Icons.star,
                                                                        color: Colors.black,
                                                                        size: 16.0,
                                                                      ),
                                                                    ]),
                                                                  ),
                                                                  const SizedBox(width: 2),
                                                                  Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: BoxDecoration(),
                                                                    child: Stack(children: [ 
                                                                      Icon(
                                                                        Icons.star,
                                                                        color: Colors.black,
                                                                        size: 16.0,
                                                                      ),
                                                                    ]),
                                                                  ),
                                                                  const SizedBox(width: 2),
                                                                  Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: BoxDecoration(),
                                                                    child: Stack(children: [ 
                                                                      Icon(
                                                                        Icons.star,
                                                                        color: Colors.black,
                                                                        size: 16.0,
                                                                      ),
                                                                    ]),
                                                                  ),
                                                                  const SizedBox(width: 2),
                                                                  Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: BoxDecoration(),
                                                                    child: Stack(children: [ 
                                                                      Icon(
                                                                        Icons.star,
                                                                        color: Colors.black,
                                                                        size: 16.0,
                                                                      ),
                                                                    ]),
                                                                  ),
                                                                  const SizedBox(width: 2),
                                                                  Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: BoxDecoration(),
                                                                    child: Stack(children: [ 
                                                                      Icon(
                                                                        Icons.star,
                                                                        color: Colors.black,
                                                                        size: 16.0,
                                                                      ),
                                                                    ]),
                                                                  ),
                                                                  const SizedBox(width: 2),
                                                                  Text(
                                                                    '(10)',
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w700,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Apply Sort:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                      decoration: ShapeDecoration(
                                                        color: Color(0xFFBE7F7F),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'Semua',
                                                            style: TextStyle(
                                                              color: Color(0xFFFFFBFF),
                                                              fontSize: 12,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // LOOP CARD REVIEW
                                                    Container(
                                                      width: 321,
                                                      height: 131,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                              width: 321,
                                                              height: 131,
                                                              decoration: ShapeDecoration(
                                                                color: Color(0xFFFFFBFF),
                                                                shape: RoundedRectangleBorder(
                                                                  side: BorderSide(width: 1, color: Color(0xFFD2D2D2)),
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 15,
                                                            top: 12,
                                                            child: Container(
                                                              width: 290,
                                                              height: 93,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 290,
                                                                    child: Text(
                                                                      'Username',
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 16,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w700,
                                                                        height: 0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Container(
                                                                    child: Row(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        // Container(
                                                                        //   width: 20,
                                                                        //   height: 20,
                                                                        //   clipBehavior: Clip.antiAlias,
                                                                        //   decoration: BoxDecoration(),
                                                                        //   child: Stack(children: [
                                                                        //   ,
                                                                        //   ]),
                                                                        // ),
                                                                        // const SizedBox(width: 4),
                                                                        SizedBox(
                                                                          width: 15,
                                                                          child: Text(
                                                                            '4',
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w700,
                                                                              height: 0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  SizedBox(
                                                                    width: 290,
                                                                    child: Text(
                                                                      'Bukunya bagus, pengiriman cepat, mantap puollll..',
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        height: 0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 14),
                                                    // LOOP CARD REVIEW
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 65,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 360,
                          height: 65,
                          decoration: BoxDecoration(color: Color(0xFF447DD4)),
                        ),
                      ),
                      Positioned(
                        left: 92,
                        top: 18,
                        child: Text(
                          'Pacil Inventory',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeatureButton {
  final String name;
  final IconData icon;
  final Color color;

  FeatureButton(this.name, this.icon, this.color);
}

class DisplayButton extends StatelessWidget {
  final FeatureButton button;

  const DisplayButton(this.button, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: button.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${button.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  button.icon,
                  color: Colors.white,
                  size: 20.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  button.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}