import 'package:flutter/material.dart';
import 'package:toko_buku/account/models/account.dart';

class TopUpBalancePage extends StatefulWidget {
  const TopUpBalancePage({Key? key}) : super(key: key);

  @override
  _TopUpBalancePageState createState() => _TopUpBalancePageState();
}

class _TopUpBalancePageState extends State<TopUpBalancePage> {
  final TextEditingController _balanceController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up Balance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _balanceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    int amount = int.parse(_balanceController.text);
                    updateBalance(amount);
                  }
                },
                child: Text('Top Up Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateBalance(int amount) {
    // Assume 'account' is the current user's account
    Account account = getLoggedInUserAccount(); // Replace with actual function
    setState(() {
      account.balance += amount;
    });

    // You may want to update the user's account on the server as well
    // Call a function to send the updated account information to the server
    sendUpdatedAccountToServer(account);
  }

  Account getLoggedInUserAccount() {
    // Replace this with actual logic to get the logged-in user's account
    // For simplicity, returning a dummy account for now
    return Account(
      user: User(
        username: 'john_doe',
        password: 'password',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      ),
      name: 'John Doe',
      email: 'john.doe@example.com',
      purchasedBooks: [],
      ongoingPurchase: [],
      balance: 100,
      address: '123 Main St',
    );
  }

  void sendUpdatedAccountToServer(Account account) {
    // Replace this with actual logic to send the updated account to the server
    // For simplicity, printing the updated account information for now
    print('Updated Account: ${account.toJson()}');
  }
}
