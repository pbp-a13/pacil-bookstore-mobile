import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_buku/account/models/account.dart';
import 'package:toko_buku/account/screens/spesific_member_page.dart';
import 'package:toko_buku/book/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View All Members',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemberListScreen(),
    );
  }
}

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  _MemberListScreenState createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    // Fetch initial data when the screen loads
    _searchMembers('');
  }

  Future<void> _searchMembers(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://pts-a13-o3pdazjyd-not0nlines-projects.vercel.app/get_all_member_info/'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Account> searchData = _filterAccounts(data['members'], query);

      setState(() {
        _accounts = searchData;
      });
    } else {
      print('Failed to load members');
    }
  }

  List<Account> _filterAccounts(List<dynamic> members, String query) {
    return members
        .where((member) =>
            member['user']['username']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            member['name'].toLowerCase().contains(query.toLowerCase()))
        .map((member) => Account(
              user: User(
                username: member['user']['username'],
                password: member['user']['password'],
                email: member['user']['email'],
                firstName: member['user']['firstName'],
                lastName: member['user']['lastName'],
              ),
              name: member['name'],
              email: member['email'],
              purchasedBooks: List<Book>.from(
                  member['purchasedBooks'].map((x) => Book.fromJson(x))),
              ongoingPurchase: List<Book>.from(
                  member['ongoingPurchase'].map((x) => Book.fromJson(x))),
              balance: member['balance'],
              address: member['address'],
            ))
        .toList();
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
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _searchMembers(_searchController.text);
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _accounts.length,
                itemBuilder: (context, index) {
                  Account account = _accounts[index];
                  return ListTile(
                    title: Text(account.user.username),
                    subtitle: Text(account.name),
                    onTap: () {
                      _navigateToAccountDetails(account);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAccountDetails(Account account) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberDetailsPage(account: account),
      ),
    );
  }
}
