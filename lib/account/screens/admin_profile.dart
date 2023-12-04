import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_buku/account/models/account.dart';

// Account tar diganti ama admin
class AdminAccountInformationPage extends StatefulWidget {
  final Account admin;

  const AdminAccountInformationPage({super.key, required this.admin});

  @override
  _AdminAccountInformationPageState createState() =>
      _AdminAccountInformationPageState();
}

class _AdminAccountInformationPageState
    extends State<AdminAccountInformationPage> {
  bool isEditing = false;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    namaController = TextEditingController();
    emailController = TextEditingController();
    alamatController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
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
            if (isEditing) _buildEditForm() else _buildAccountInfo(),
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
              // Implement your logic to update account details
              _updateAccountInfo();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    // Replace with your logic to fetch and display admin details
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username: ${widget.admin.user.username}'),
        Text('Nama: ${widget.admin.name}'),
        Text('Email: ${widget.admin.email}'),
        Text('Alamat: ${widget.admin.address}'),
        const SizedBox(height: 20),
        // masih perlu admin
        // Text('No. of Books Added: ${widget.admin.booksAdded}'),
        // Text('No. of Orders Completed: ${widget.admin.ordersCompleted}'),
      ],
    );
  }

  Future<void> _updateAccountInfo() async {
    // Retrieve values from controllers
    String nama = namaController.text;
    String email = emailController.text;
    String alamat = alamatController.text;

    // Prepare data for the POST request
    Map<String, String> data = {
      'nama': nama,
      'email': email,
      'alamat': alamat,
    };

    // Convert data to JSON
    String jsonData = jsonEncode(data);

    // Replace the URL with your Django server URL
    String djangoServerUrl = 'https://pts-a13-not0nlines-projects.vercel.app/';
    String apiUrl = '$djangoServerUrl/update_account_info/';

    try {
      // Send the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Success
        print('Account updated successfully');
        // You can perform additional actions or navigate to another screen if needed
      } else {
        // Handle the error
        print('Failed to update account: ${response.statusCode}');
        print('Response body: ${response.body}');
        // You can show an error message to the user or perform other error handling
      }
    } catch (e) {
      // Handle network or other exceptions
      print('Exception during account update: $e');
      // You can show an error message to the user or perform other error handling
    }
  }
}
