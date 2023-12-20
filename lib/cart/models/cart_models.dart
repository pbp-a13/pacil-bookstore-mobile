// To parse this JSON data, do
//
//     final cartModels = cartModelsFromJson(jsonString);

import 'dart:convert';
import 'package:toko_buku/book/models.dart';

List<CartModels> cartModelsFromJson(String str) => List<CartModels>.from(json.decode(str).map((x) => CartModels.fromJson(x)));

String cartModelsToJson(List<CartModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModels {
  String model;
  int pk;
  Fields fields;
  List<Book> books; // Add this line

  CartModels({
    required this.model,
    required this.pk,
    required this.fields,
    required this.books, // Add this line
  });

  factory CartModels.fromJson(Map<String, dynamic> json) => CartModels(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
        books: (json["fields"]["books"] as List<dynamic>)
            .map((bookJson) => Book.fromJson(bookJson))
            .toList(), // Assuming the key for books is "books"
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
        "books": books.map((book) => book.toJson()).toList(), // Add this line
      };
}


class Fields {
    int user;
    int book;
    int amount;
    int totalAmount;

    Fields({
        required this.user,
        required this.book,
        required this.amount,
        required this.totalAmount,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        amount: json["amount"],
        totalAmount: json["total_amount"],
    );


    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "amount": amount,
        "total_amount": totalAmount,
    };
}
