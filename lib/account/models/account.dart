import 'package:toko_buku/book/models.dart';

class Account {
  User user;
  String name;
  String email;
  List<Book> purchasedBooks;
  List<Book> ongoingPurchase;
  int balance;
  String address;

  Account({
    required this.user,
    required this.name,
    required this.email,
    required this.purchasedBooks,
    required this.ongoingPurchase,
    required this.balance,
    required this.address,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        user: User.fromJson(json["user"]),
        name: json["name"],
        email: json["email"],
        purchasedBooks: List<Book>.from(
            json["purchasedBooks"].map((x) => Book.fromJson(x))),
        ongoingPurchase: List<Book>.from(
            json["ongoingPurchase"].map((x) => Book.fromJson(x))),
        balance: json["balance"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "name": name,
        "email": email,
        "purchasedBooks":
            List<dynamic>.from(purchasedBooks.map((x) => x.toJson())),
        "ongoingPurchase":
            List<dynamic>.from(ongoingPurchase.map((x) => x.toJson())),
        "balance": balance,
        "address": address,
      };
}

class User {
  String username;
  String
      password; // Note: Never store passwords in plain text in a real application
  String email;
  String firstName;
  String lastName;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}
