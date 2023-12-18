import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:toko_buku/account/models/account.dart';
import 'package:toko_buku/account/screens/spesific_member_page.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key, required this.cookieRequest})
      : super(key: key);
  final CookieRequest cookieRequest;

  @override
  _MemberListScreenState createState() => _MemberListScreenState(cookieRequest);
}

class _MemberListScreenState extends State<MemberListScreen> {
  final CookieRequest cookieRequest;
  _MemberListScreenState(this.cookieRequest);

  final TextEditingController _searchController = TextEditingController();
  List<Account> _accounts = [];
  List<Account> _displayAccounts = [];

  @override
  void initState() {
    super.initState();
    _fetchMembers(cookieRequest);
  }

  Future<void> _fetchMembers(CookieRequest request) async {
    final data = await request.get(
      'http://localhost:8000/auth/get_all_members/',
    );

    List<Account> accounts = (data['members'] as List)
        .map((member) => Account.fromJson(member))
        .toList();

    setState(() {
      _accounts = accounts;
      _displayAccounts = accounts;
    });
  }

  void _searchMembers(String query) {
    if (query.isEmpty) {
      setState(() {
        _displayAccounts = _accounts;
      });
      return;
    }

    final searchResults = _accounts.where((account) {
      return account.user.username.contains(query) ||
          account.name.contains(query);
    }).toList();

    setState(() {
      _displayAccounts = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View All Members'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'View All Members',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for members...',
                    ),
                    onChanged: _searchMembers,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _displayAccounts.length,
                itemBuilder: (context, index) {
                  Account account = _displayAccounts[index];
                  return ListTile(
                    leading: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MemberDetailsPage(account: account),
                          ),
                        );
                      },
                      child: const Text('Info'),
                    ),
                    title: Text('${account.user.username} - ${account.name}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
