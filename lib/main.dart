// @dart=2.9
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';

void main() => runApp(MaterialApp(
      home: HomeScreen(),
    ));

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cloths',
      amount: 69.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Card(
            color: Colors.blue,
            child: Text('CHART!'),
          ),
          Column(
              children: transactions.map((tx) {
            return Card(
                child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  child: Text(
                    '\$${tx.amount}',
                    // tx.amount.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 17),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      DateFormat.yMMMd().format(tx.date),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ));
          }).toList())
        ],
      ),
    );
  }
}
