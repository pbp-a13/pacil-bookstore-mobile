import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:toko_buku/account/models/review.dart';
import 'package:toko_buku/book/models.dart';
import 'package:toko_buku/book_info/screens/book_review.dart';
import 'package:toko_buku/book_info/screens/edit_form.dart';
import 'package:toko_buku/book_info/widgets/feature_button.dart';
import 'package:toko_buku/main/widgets/left_drawer.dart';

class BookInfoPage extends StatelessWidget {
  BookInfoPage({super.key, required this.id});
  final int id;

  Future<Book> getBook() async {
    var url = "http://localhost:8000/json/$id/";
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    // print(data);
    var buku = Book.fromJson(data[0]);
    // print(buku);
    return buku;
  }

  @override
  Widget build(BuildContext context) {
    final List<FeatureButton> button = [
      FeatureButton("Edit", Icons.edit, Colors.blue, id),
      FeatureButton("Delete", Icons.delete, Colors.red, id),
      FeatureButton("Masukkan Keranjang", Icons.add_shopping_cart, Colors.lightBlueAccent, id),
    ]; 
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Pacil Inventory',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromRGBO(68, 126, 212, 1),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getBook(),
              builder: (context, AsyncSnapshot<Book> snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text("Tidak ada informasi buku.", style: TextStyle(color: Color(0xff59A5D8), fontSize: 20)),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    Book book = snapshot.data!;
                    // return ListView.builder(
                    //   itemCount: 1,
                    //   itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Container(
                                  alignment: Alignment.center,
                                  child: 
                                    Icon(
                                      Icons.image_outlined,
                                      color: Colors.grey,
                                      size: 200,
                                    ),
                                  // Container(
                                  // child: Image.asset("${book.fields.image}",
                                  //   width: 174,
                                  //   height: 204,
                                  // ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book.fields.authors}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book.fields.title}",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    child: Text(
                                      "Rp${book.fields.price}",
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 102, 255, 1),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text("Tersisa ${book.fields.stock} stock", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [ 
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${book.fields.rating}",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    child: Text("|", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400),)
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    child: Text("${book.fields.jumlahTerjual} Terjual", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),)
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              // display button
                              Container(
                                child: Column(
                                  children: button.map((FeatureButton button) {
                                    return Column(
                                      children: [
                                        DisplayButton(button),
                                        SizedBox(height: 8),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Kategori",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.indigo),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book.fields.categories}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Deskripsi",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.indigo),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Buku karya ${book.fields.authors} berjudul ${book.fields.title} dengan kategori ${book.fields.categories}.",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Detail",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.indigo),
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Judul Buku",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book.fields.title}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Pengarang",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book.fields.authors}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Jumlah Halaman",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${book.fields.noOfPages}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Penerbit",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Keperpustakaan PBP A13",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 30),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => BookReviewPage(id: id), // Ganti ReviewPage dengan nama halaman yang sesuai
                              //       ),
                              //     );
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     primary: Colors.indigo, // Atur warna latar belakang tombol
                              //     onPrimary: Colors.white, // Atur warna teks tombol
                              //   ),
                              //   child: Text("Lihat Penilaian & Ulasan"),
                              // ),
                              SizedBox(height: 30),
                              // Container(
                              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "Penilaian & Ulasan",
                              //     textAlign: TextAlign.start,
                              //     style: TextStyle(
                              //       fontSize: 20,
                              //       fontWeight: FontWeight.w700,
                              //       color: Colors.indigo),
                              //   ),
                              // ),
                              // SizedBox(height: 6),
                              // Container(
                              //   width: MediaQuery.of(context).size.width - 32,
                              //   height: 120,
                              //   padding: EdgeInsets.all(25),
                              //   margin: EdgeInsets.symmetric(vertical: 10),
                              //   decoration: BoxDecoration(
                              //     color: Color.fromARGB(255, 207, 222, 255),
                              //     border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
                              //     borderRadius: BorderRadius.circular(8),
                              //   ),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         children: [
                              //           Text("0", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
                              //           SizedBox(width: 4),
                              //           Text("dari 5", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700)),
                              //         ],
                              //       ),
                              //       SizedBox(height: 10),
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         children: [
                              //           for (int i = 0; i < 5; i++)
                              //             Icon(Icons.star, size: 16, color: i < 0 ? Colors.black : Colors.black.withOpacity(0.2)),
                              //           SizedBox(width: 4),
                              //           Text("(0)", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(height: 20),
                              // Row(
                              //   children: [
                              //     Container(
                              //       alignment: Alignment.centerLeft,
                              //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              //       child: Text(
                              //         "Apply Sort:",
                              //         style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w400),
                              //       ),
                              //     ),
                              //     Container(
                              //       padding: EdgeInsets.all(4),
                              //       decoration: BoxDecoration(
                              //         color: Color.fromARGB(255, 221, 183, 71),
                              //         borderRadius: BorderRadius.circular(4),
                              //       ),
                              //       child: Text("Ascending", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
                              //     )
                              //   ],
                              // ),
                              // SizedBox(height: 20),
                              // for (int i = 0; i < 3; i++)
                              //   Container(
                              //     width: MediaQuery.of(context).size.width - 32,
                              //     padding: EdgeInsets.all(25),
                              //     margin: EdgeInsets.symmetric(vertical: 10),
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
                              //       borderRadius: BorderRadius.circular(8),
                              //     ),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: [
                              //         Container(
                              //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              //           alignment: Alignment.centerLeft,
                              //           child: Text(
                              //             "Username", 
                              //             style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                              //           ),
                              //         ),                    
                              //         Container(
                              //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              //           alignment: Alignment.centerLeft,
                              //           child: Row(
                              //             children: [
                              //               Icon(Icons.star, color: Colors.yellow, size: 20,),
                              //               SizedBox(height: 10),
                              //               Text("5", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              //           alignment: Alignment.centerLeft,
                              //           child: Text(
                              //             "Bukunya bagus, pengiriman cepat, mantap polll!", 
                              //             style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                              //           ),
                              //         ),  
                              //       ],
                              //     ),
                              //   ),
                            ],
                          ),
                        );
                    //   }
                    // );
                  }
                }
              }
            ),
            // FutureBuilder(
            //   future: getBookReviews(),
            //   builder: (context, AsyncSnapshot snapshot) {
            //     if (snapshot.data == null) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else {
            //       if (!snapshot.hasData) {
            //         return const Column(
            //           children: [
            //             Text("Belum ada penilaian untuk buku ini.", style: TextStyle(color: Color(0xff59A5D8), fontSize: 20)),
            //             SizedBox(height: 8),
            //           ],
            //         );
            //       } else {
            //         List<Review> reviews = snapshot.data ?? [];
            //         return ListView.builder(
            //           itemCount: reviews.length,
            //           itemBuilder: (context, index) {
            //             return Card(
            //               child: Column(
            //                 children: [
            //                   Container(
            //                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            //                     alignment: Alignment.centerLeft,
            //                     child: Text(
            //                       "Penilaian & Ulasan",
            //                       textAlign: TextAlign.start,
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w700,
            //                         color: Colors.indigo),
            //                     ),
            //                   ),
            //                   SizedBox(height: 6),
            //                   Container(
            //                     width: MediaQuery.of(context).size.width - 32,
            //                     height: 120,
            //                     padding: EdgeInsets.all(25),
            //                     margin: EdgeInsets.symmetric(vertical: 10),
            //                     decoration: BoxDecoration(
            //                       color: Color.fromARGB(255, 207, 222, 255),
            //                       border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
            //                       borderRadius: BorderRadius.circular(8),
            //                     ),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           crossAxisAlignment: CrossAxisAlignment.center,
            //                           children: [
            //                             Text("0", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
            //                             SizedBox(width: 4),
            //                             Text("dari 5", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700)),
            //                           ],
            //                         ),
            //                         SizedBox(height: 10),
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           crossAxisAlignment: CrossAxisAlignment.center,
            //                           children: [
            //                             for (int i = 0; i < 5; i++)
            //                               Icon(Icons.star, size: 16, color: i < 0 ? Colors.black : Colors.black.withOpacity(0.2)),
            //                             SizedBox(width: 4),
            //                             Text("(0)", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   SizedBox(height: 20),
            //                   Row(
            //                     children: [
            //                       Container(
            //                         alignment: Alignment.centerLeft,
            //                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //                         child: Text(
            //                           "Apply Sort:",
            //                           style: TextStyle(
            //                             color: Colors.black,
            //                             fontSize: 12,
            //                             fontWeight: FontWeight.w400),
            //                         ),
            //                       ),
            //                       Container(
            //                         padding: EdgeInsets.all(4),
            //                         decoration: BoxDecoration(
            //                           color: Color.fromARGB(255, 221, 183, 71),
            //                           borderRadius: BorderRadius.circular(4),
            //                         ),
            //                         child: Text("Ascending", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
            //                       )
            //                     ],
            //                   ),
            //                   SizedBox(height: 20),
            //                   for (int i = 0; i < 3; i++)
            //                     Container(
            //                       width: MediaQuery.of(context).size.width - 32,
            //                       padding: EdgeInsets.all(25),
            //                       margin: EdgeInsets.symmetric(vertical: 10),
            //                       decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
            //                         borderRadius: BorderRadius.circular(8),
            //                       ),
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           Container(
            //                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //                             alignment: Alignment.centerLeft,
            //                             child: Text(
            //                               "Username", 
            //                               style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
            //                             ),
            //                           ),                    
            //                           Container(
            //                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //                             alignment: Alignment.centerLeft,
            //                             child: Row(
            //                               children: [
            //                                 Icon(Icons.star, color: Colors.yellow, size: 20,),
            //                                 SizedBox(height: 10),
            //                                 Text("5", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
            //                               ],
            //                             ),
            //                           ),
            //                           Container(
            //                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //                             alignment: Alignment.centerLeft,
            //                             child: Text(
            //                               "Bukunya bagus, pengiriman cepat, mantap polll!", 
            //                               style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
            //                             ),
            //                           ),  
            //                         ],
            //                       ),
            //                     ),
            //                 ]
            //               ),
            //             );
            //           }
            //         );
            //       }
            //     }
            //   },
            // ),
          ]
        )
      )
    );
  }
}