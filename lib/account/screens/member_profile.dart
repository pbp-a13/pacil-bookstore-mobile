import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({Key? key, required this.cookieRequest})
      : super(key: key);
  final CookieRequest cookieRequest;
  @override
  _AccountInformationPageState createState() =>
      _AccountInformationPageState(cookieRequest);
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  final CookieRequest cookieRequest;
  _AccountInformationPageState(this.cookieRequest);

  bool isEditing = false;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController alamatController;
  late String username;
  late int saldo;
  late List<String> purchasedBooks;
  late List<String> reviews;

  @override
  void initState() {
    super.initState();
    username = '';
    namaController = TextEditingController();
    emailController = TextEditingController();
    alamatController = TextEditingController();
    saldo = 0;
    purchasedBooks = [];
    reviews = [];
    _fetchAccountInfo(cookieRequest).then((accountInfo) {
      namaController.text = accountInfo[0] ?? '';
      emailController.text = accountInfo[1] ?? '';
      alamatController.text = accountInfo[2] ?? '';
      username = accountInfo[3] ?? '';
      saldo = accountInfo[4] ?? 0;
      // purchasedBooks = List<String>.from(accountInfo[5] ?? []);
      // reviews = List<String>.from(accountInfo['reviews'] ?? []);
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Account Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(isEditing ? 'Cancel' : 'Edit'),
            ),
            const SizedBox(height: 20),
            if (isEditing)
              _buildEditForm()
            else
              FutureBuilder<Widget>(
                future: _buildAccountInfo(cookieRequest),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  return snapshot.data ?? CircularProgressIndicator();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: namaController,
            decoration: const InputDecoration(labelText: 'Nama'),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: alamatController,
            decoration: const InputDecoration(labelText: 'Alamat'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _updateAccountInfo(cookieRequest);
              setState(() {
                isEditing = false;
              });
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<Widget> _buildAccountInfo(CookieRequest request) async {
    String djangoServerUrl = 'http://localhost:8000';
    String apiUrl = '$djangoServerUrl/auth/get_account';
    final List<dynamic> listtt = [];

    try {
      final response = await request.get(apiUrl);

      response.forEach((key, value) {
        listtt.add(value);
      });
    } catch (e) {
      print('Exception during account fetch: $e');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username: ${listtt[3]}'),
        Text('Nama: ${listtt[0]}'),
        Text('Email: ${listtt[1]}'),
        Text('Alamat: ${listtt[2]}'),
        Text('Saldo: ${listtt[4]}'),
        // masih belom selesai
        Text('Buku yang Telah Dibeli: belom sempet bikin'),
        Text('Reviews: harusnya tar ada tombol buat dua ini'),
      ],
    );
  }

  Future<List<dynamic>> _fetchAccountInfo(CookieRequest request) async {
    String djangoServerUrl = 'http://localhost:8000';
    String apiUrl = '$djangoServerUrl/auth/get_account';
    final List<dynamic> listtt = [];

    try {
      final response = await request.get(apiUrl);

      response.forEach((key, value) {
        listtt.add(value);
      });

      return listtt;
    } catch (e) {
      print('Exception during account fetch: $e');
      return [];
    }
  }

  Future<void> _updateAccountInfo(CookieRequest request) async {
    String nama = namaController.text;
    String email = emailController.text;
    String alamat = alamatController.text;

    Map<String, String> data = {
      'nama': nama,
      'email': email,
      'alamat': alamat,
    };

    String jsonData = jsonEncode(data);

    try {
      final response = await request.postJson(
          'http://localhost:8000/auth/update_account', jsonData);
      // final response = await http.post(
      //   Uri.parse(apiUrl),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonData,
      // );

      if (response.statusCode == 200) {
        print('Account updated successfully');
        print('Failed to update account: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during account update: $e');
    }
  }
}
