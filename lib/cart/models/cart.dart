// // To parse this JSON data, do
// //
// //     final cart = cartFromJson(jsonString);

// import 'dart:convert';

// List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

// String cartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Cart {
//     int pk;
//     Book book;
//     int totalAmount;

//     Cart({
//         required this.pk,
//         required this.book,
//         required this.totalAmount,
//     });

//     factory Cart.fromJson(Map<String, dynamic> json) => Cart(
//         pk: json["pk"],
//         book: Book.fromJson(json["Book"]),
//         totalAmount: json["total_amount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "pk": pk,
//         "Book": book.toJson(),
//         "total_amount": totalAmount,
//     };
// }

// class Book {
//     int pk;
//     String title;
//     String author;
//     int price;

//     Book({
//         required this.pk,
//         required this.title,
//         required this.author,
//         required this.price,
//     });

//     factory Book.fromJson(Map<String, dynamic> json) => Book(
//         pk: json["pk"],
//         title: json["title"],
//         author: json["author"],
//         price: json["price"],
//     );

//     Map<String, dynamic> toJson() => {
//         "pk": pk,
//         "title": title,
//         "author": author,
//         "price": price,
//     };
// }
