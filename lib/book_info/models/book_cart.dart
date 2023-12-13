// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<BookCart> cartFromJson(String str) => List<BookCart>.from(json.decode(str).map((x) => BookCart.fromJson(x)));

String cartToJson(List<BookCart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookCart {
    String model;
    int pk;
    Fields fields;

    BookCart({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookCart.fromJson(Map<String, dynamic> json) => BookCart(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
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
