import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';
import 'package:toko_buku/main/widgets/search_sort.dart';

import 'package:flutter/material.dart';

// class OrderListPage extends StatelessWidget {
//   const OrderListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Center(
//             child: Container(
//               width: constraints.maxWidth,
//               height: constraints.maxHeight,
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(color: Color(0xFFFFFBFF)),
//               child: ListView(
//                 children: [
//                   Container(
//                     width: constraints.maxWidth,
//                     height: constraints.maxHeight,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: const BoxDecoration(color: Color(0xFFFBFF)),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           left: 0,
//                           top: 0,
//                           child: Container(
//                             width: constraints.maxWidth,
//                             height: 65,
//                             // navbar
//                             decoration: const BoxDecoration(color: Color(0xFF447DD4)),
//                           ),
//                         ),
//                         Positioned(
//                           left: 20,
//                           top: 171,
//                           child: Container(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: constraints.maxWidth - 40,
//                                   height: 131,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFD9D9D9),
//                                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 60),
//                                 Container(
//                                   width: constraints.maxWidth - 40,
//                                   height: 131,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFD9D9D9),
//                                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 60),
//                                 Container(
//                                   width: constraints.maxWidth - 40,
//                                   height: 131,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFD9D9D9),
//                                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const Positioned(
//                           left: 20,
//                           top: 88,
//                           child: Text(
//                             'Your Recent Order',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 24,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                               height: 0,
//                             ),
//                           ),
//                         ),
//                         const Positioned(
//                           left: 20,
//                           top: 137,
//                           child: Text(
//                             'Apply Sort:',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                               height: 0,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 88,
//                           top: 138,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                             decoration: ShapeDecoration(
//                               color: Color(0xFFBE7F7F),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//                             ),
//                             child: const Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Month',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 8,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFFFFBFF)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 65,
                  decoration: const BoxDecoration(color: Color(0xFF447DD4)),
                ),
              ),
              Positioned(
                left: 20,
                top: 171,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              left: 101,
                              top: 24,
                              child: Container(
                                width: 220,
                                height: 88,
                                padding: const EdgeInsets.only(top: 4, left: 12, right: 10, bottom: 3),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Title:\nQuantity:\nOrder Date:\nTotal Price:\nEstimated Delivery Date:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 245,
                              top: 8,
                              child: Container(
                                width: 64,
                                height: 23,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF447DD4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ongoing',
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
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
                              left: 101,
                              top: 24,
                              child: Container(
                                width: 220,
                                height: 88,
                                padding: const EdgeInsets.only(top: 4, left: 12, right: 10, bottom: 3),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Title:\nQuantity:\nOrder Date:\nTotal Price:\nEstimated Delivery Date:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 245,
                              top: 8,
                              child: Container(
                                width: 64,
                                height: 23,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF447DD4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ongoing',
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
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
                              left: 101,
                              top: 24,
                              child: Container(
                                width: 220,
                                height: 88,
                                padding: const EdgeInsets.only(top: 4, left: 12, right: 10, bottom: 3),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Title:\nQuantity:\nOrder Date:\nTotal Price:\nEstimated Delivery Date:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 245,
                              top: 8,
                              child: Container(
                                width: 64,
                                height: 23,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF447DD4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ongoing',
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 20,
                top: 88,
                child: Text(
                  'Your Recent Order',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 20,
                top: 137,
                child: Text(
                  'Apply Sort:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 88,
                top: 138,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: ShapeDecoration(
                    color: Color(0xFFBE7F7F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Month',
                        style: TextStyle(
                          color: Color(0xFFFFFBFF),
                          fontSize: 8,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
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
      ],
    );
  }
}



