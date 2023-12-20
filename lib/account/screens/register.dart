// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:toko_buku/main/screens/main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.cookieRequest}) : super(key: key);
  final CookieRequest cookieRequest;

  @override
  _RegisterPageState createState() => _RegisterPageState(cookieRequest);
}

class _RegisterPageState extends State<RegisterPage> {
  final CookieRequest cookieRequest;
  _RegisterPageState(this.cookieRequest);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register(CookieRequest request) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    Map<String, String> data = {
      'username': username,
      'password1': password,
      'password2': password,
    };

    String jsonData = jsonEncode(data);
    try {
      final response = await request.postJson(
        'https://pts-a13.vercel.app/account/register_flutter/',
        jsonData,
      );

      if (response["message"] == 'Registration successful') {
        // Registration successful
        String message = 'Registration successful';
        Navigator.pushReplacementNamed(
          context,
          MainPage.routeName,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text("$message. Welcome!")));
      } else {
        // Registration failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration failed'),
            content: Text('Error: ${response['error']}'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Exception during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Register',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _register(cookieRequest);
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
