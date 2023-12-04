import 'package:flutter/material.dart';
import 'package:toko_buku/account/models/account.dart';

// Account tar diganti ama admin
class AdminAccountInformationPage extends StatefulWidget {
  final Account admin;

  AdminAccountInformationPage({required this.admin});

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
        title: Text('Admin Account Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Account Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(isEditing ? 'Cancel' : 'Edit'),
            ),
            SizedBox(height: 20),
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
            decoration: InputDecoration(labelText: 'Nama'),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: alamatController,
            decoration: InputDecoration(labelText: 'Alamat'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement your logic to update account details
              _updateAccountInfo();
            },
            child: Text('Submit'),
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
        SizedBox(height: 20),
        // masih perlu admin
        // Text('No. of Books Added: ${widget.admin.booksAdded}'),
        // Text('No. of Orders Completed: ${widget.admin.ordersCompleted}'),
      ],
    );
  }

  void _updateAccountInfo() {
    // Implement your logic to send a POST request to update account details
    // Use the values from controllers: namaController.text, emailController.text, etc.
  }
}
