import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class AdminAccountInformationPage extends StatefulWidget {
  const AdminAccountInformationPage({Key? key, required this.cookieRequest})
      : super(key: key);
  final CookieRequest cookieRequest;

  @override
  _AdminAccountInformationPageState createState() =>
      _AdminAccountInformationPageState(cookieRequest);
}

class _AdminAccountInformationPageState
    extends State<AdminAccountInformationPage> {
  final CookieRequest cookieRequest;

  _AdminAccountInformationPageState(this.cookieRequest);

  bool isEditing = false;
  late String username;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController alamatController;
  late int orders_completed;

  @override
  void initState() {
    super.initState();
    username = '';
    orders_completed = 0;
    namaController = TextEditingController();
    emailController = TextEditingController();
    alamatController = TextEditingController();

    _fetchAccountInfo(cookieRequest).then((accountInfo) {
      username = accountInfo[3];
      namaController.text = accountInfo[0] ?? '';
      emailController.text = accountInfo[1] ?? '';
      alamatController.text = accountInfo[2] ?? '';
      orders_completed = accountInfo[4];
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
        title: const Text('Admin Account Information'),
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
              )
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
        Text('Orders Completed: ${listtt[4]}'),
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
