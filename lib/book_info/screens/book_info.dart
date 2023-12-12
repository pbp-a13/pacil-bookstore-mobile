import 'package:flutter/material.dart';
import 'package:toko_buku/book_info/screens/edit_form.dart';

class BookInfoPage extends StatelessWidget {
  BookInfoPage({Key? key}) : super(key: key);

  final List<FeatureButton> button = [
    FeatureButton("Edit", Icons.edit, Colors.blue),
    FeatureButton("Delete", Icons.delete, Colors.red),
    FeatureButton("Masukkan Keranjang", Icons.add_shopping_cart, Colors.lightBlueAccent),
  ];

  static const String routeName = '/bookInfo';

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
                alignment: Alignment.center,
                child: Container(
                  width: 174,
                  height: 204,
                  color: Colors.grey,
                )
                // child: Image.asset("",
                //   width: 174,
                //   height: 204,
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Burroughs, Edgar Rice",
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
                "A Princess of Mars",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    "Rp100.000",
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
                  child: Text("Stok Tersedia", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
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
                        "4.5",
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
                  child: Text("16 Terjual", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),)
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
            // button edit
            // Container(
            //   width: MediaQuery.of(context).size.width - 32,
            //   height: 40,
            //   padding: EdgeInsets.all(4),
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Icon(Icons.edit, color: Colors.white, size: 16,),
            //       SizedBox(width: 8),
            //       Text("Edit", style: TextStyle(fontSize: 16, color: Colors.white , fontWeight: FontWeight.w400),),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8),
            // // button delete
            // Container(
            //   width: MediaQuery.of(context).size.width - 32,
            //   height: 40,
            //   padding: EdgeInsets.all(4),
            //   decoration: BoxDecoration(
            //     color: Colors.red,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Icon(Icons.delete, color: Colors.white, size: 16,),
            //       SizedBox(width: 8),
            //       Text("Delete", style: TextStyle(fontSize: 16, color: Colors.white , fontWeight: FontWeight.w400),),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8),
            // // button masukkan keranjang
            // Container(
            //   width: MediaQuery.of(context).size.width - 32,
            //   height: 40,
            //   padding: EdgeInsets.all(4),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(width: 1, color: Color(0xFF0066FF)),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Icon(Icons.add_shopping_cart_outlined, color: Colors.blue, size: 16,),
            //       SizedBox(width: 8),
            //       Text("Masukkan Keranjang", style: TextStyle(fontSize: 16, color: Color(0xFF0066FF) , fontWeight: FontWeight.w400),),
            //     ],
            //   ),
            // ),
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
                "Science fiction; Mars (Planet) -- Fiction",
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
                "Buku karya Burroughs, Edgar Rice, 1875-1950 dengan kategori Science fiction; Mars (Planet) -- Fiction",
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
                "A Princess of Mars",
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
                "Burroughs, Edgar Rice",
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
                "965",
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              alignment: Alignment.centerLeft,
              child: Text(
                "Penilaian & Ulasan",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo),
              ),
            ),
            SizedBox(height: 6),
            Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 120,
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 207, 222, 255),
                border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("0", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
                      SizedBox(width: 4),
                      Text("dari 5", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(Icons.star, size: 16, color: i < 4 ? Colors.black : Colors.black.withOpacity(0.2)),
                      SizedBox(width: 4),
                      Text("(10)", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Apply Sort:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 221, 203, 149),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text("Low to High", style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w400),),
                )
              ],
            ),
            SizedBox(height: 20),
            for (int i = 0; i < 3; i++)
              Container(
                width: MediaQuery.of(context).size.width - 32,
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.blueGrey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Username", 
                        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),                    
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 20,),
                          SizedBox(height: 10),
                          Text("4", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bukunya bagus, pengiriman cepat, mantap polll!", 
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),  
                  ],
                ),
              ),
          ],
        ),
      ),
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
        onTap: () async {
          if (button.name == "Edit") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditFormPage()),
            );
          }
          if (button.name == "Masukkan Keranjang") {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text("Berhasil menambahkan item ke keranjang!")));
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 40,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: button.name == "Masukkan Keranjang" ? Colors.white : button.color,
            border: button.name == "Masukkan Keranjang" ? Border.all(width: 1, color: button.color) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                button.icon, size: 16, color: button.name == "Masukkan Keranjang" ? Colors.blue : Colors.white,
                ),
              SizedBox(width: 8),
              Text(
                button.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: button.name == "Masukkan Keranjang" ? Color(0xFF0066FF) : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}