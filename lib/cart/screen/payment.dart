import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final double totalAmount; // Assuming you pass the total amount from the cart screen

  const PaymentPage({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Add your payment method selection widgets here
            // For example, you can use radio buttons, buttons with icons, etc.
            ElevatedButton(
              onPressed: () {
                // Handle payment logic
                handlePayment(context);
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }

  // Replace this with your actual payment logic
  void handlePayment(BuildContext context) {
    // Implement your payment gateway integration or any other payment logic here
    // For simplicity, let's just show a dialog indicating success.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Thank you for your purchase!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
