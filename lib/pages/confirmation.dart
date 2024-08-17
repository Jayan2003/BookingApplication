import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final Map flight;

  ConfirmationPage({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations! Ticket payment is successful.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Ticket Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('From: ${flight['country_from']}'),
            Text('To: ${flight['country_to']}'),
            Text('Class: ${flight['class']}'),
            Text('Price: ${flight['price']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Back to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
