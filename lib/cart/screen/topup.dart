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
    Account account = getLoggedInUserAccount(); //ganti
    setState(() {
      account.balance += amount;
    });
    sendUpdatedAccountToServer(account);
  }

  Account getLoggedInUserAccount() {
    // return Account(
    //   user: User(
    //     username: 'john_doe',
    //     password: 'password',
    //     email: 'john.doe@example.com',
    //     firstName: 'John',
    //     lastName: 'Doe',
    //   ),
    //   name: 'John Doe',
    //   email: 'john.doe@example.com',
    //   purchasedBooks: [],
    //   ongoingPurchase: [],
    //   balance: 100,
    //   address: '123 Main St',
    // );
  }

  void sendUpdatedAccountToServer(Account account) {
    print('Updated Account: ${account.toJson()}');
  }
}
