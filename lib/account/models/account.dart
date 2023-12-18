// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:pbp_django_auth/pbp_django_auth.dart';

class Account {
  User user;
  String name;
  String email;
  int balance;
  String address;

  Account({
    required this.user,
    required this.name,
    required this.email,
    required this.balance,
    required this.address,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    var names = (json['nama'] as String).split(' ');
    var firstName = names.sublist(0, names.length - 1).join(' ');
    var lastName = names.last;

    return Account(
      user: User(
        username: json['username'],
        email: json['email'],
        firstName: firstName,
        lastName: lastName,
      ),
      name: json['nama'],
      email: json['email'],
      balance: json['saldo'],
      address: json['alamat'],
    );
  }
}

class User {
  String username;
  String email;
  String firstName;
  String lastName;

  User({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
}
