// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

List<Admin> adminFromJson(String str) => List<Admin>.from(json.decode(str).map((x) => Admin.fromJson(x)));

String adminToJson(List<Admin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Admin {
    String model;
    int pk;
    Fields fields;

    Admin({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
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
    bool isAdminMode;
    int account;
    int ordersCompleted;
    int booksAdded;

    Fields({
        required this.isAdminMode,
        required this.account,
        required this.ordersCompleted,
        required this.booksAdded,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isAdminMode: json["is_admin_mode"],
        account: json["account"],
        ordersCompleted: json["orders_completed"],
        booksAdded: json["books_added"],
    );

    Map<String, dynamic> toJson() => {
        "is_admin_mode": isAdminMode,
        "account": account,
        "orders_completed": ordersCompleted,
        "books_added": booksAdded,
    };
}
