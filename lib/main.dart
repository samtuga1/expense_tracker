// @dart=2.9
import 'package:demo/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomeScreen(),
    ));

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Card(
              color: Colors.blue,
              child: Text('CHART!'),
            ),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
