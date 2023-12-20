// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
    String model;
    int pk;
    Fields fields;

    Order({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
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
    int quantity;
    bool isCompleted;
    DateTime orderDate;
    dynamic estimatedDeliveryDate;

    Fields({
        required this.user,
        required this.book,
        required this.quantity,
        required this.isCompleted,
        required this.orderDate,
        required this.estimatedDeliveryDate,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        quantity: json["quantity"],
        isCompleted: json["is_completed"],
        orderDate: DateTime.parse(json["order_date"]),
        estimatedDeliveryDate: json["estimated_delivery_date"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "quantity": quantity,
        "is_completed": isCompleted,
        "order_date": orderDate.toIso8601String(),
        "estimated_delivery_date": estimatedDeliveryDate,
    };
}
