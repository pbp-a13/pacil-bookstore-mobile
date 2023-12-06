import 'package:flutter/material.dart';
import 'package:toko_buku/account/models/account.dart';

class AccountInformationPage extends StatefulWidget {
  final Account account;

  AccountInformationPage({required this.account});

  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  bool isEditing = false;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    namaController = TextEditingController(text: widget.account.name);
    emailController = TextEditingController(text: widget.account.email);
    alamatController = TextEditingController(text: widget.account.address);
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
        title: Text('Account Information'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username: ${widget.account.user.username}'),
        Text('Nama: ${widget.account.name}'),
        Text('Email: ${widget.account.email}'),
        Text('Alamat: ${widget.account.address}'),
        Text('Saldo: ${widget.account.balance}'),
        SizedBox(height: 20),
        Text('Buku yang Telah Dibeli:'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var book in widget.account.purchasedBooks)
              Text('- ${book.title}'), // asumsi true (kayaknya salah)
          ],
        ),
        SizedBox(height: 20),
        Text('Reviews:'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add logic to display reviews
          ],
        ),
      ],
    );
  }

  void _updateAccountInfo() {
    // Implement your logic to send a POST request to update account details
    // Use the values from controllers: namaController.text, emailController.text, etc.
  }
}
