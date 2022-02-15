// @dart=2.9
import 'package:demo/widgets/chart.dart';
import 'package:demo/widgets/new_transaction.dart';
import 'package:demo/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:demo/models/transaction.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
      ),
      home: HomeScreen(),
    ),
  );
}

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _userTransactions = [];
  void _addTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            addtx: _addTransaction,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: const Icon(Icons.add),
        )
      ],
      title: const Text('Expense Tracker'),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
            _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        (isLandscape == true ? 0.7 : 0.3),
                    child: Chart(
                      recentTransactions: _recentTransaction,
                    ),
                  )
                : SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: _userTransactions.isEmpty
                        ? const Center(
                            child: Text('No Transactions to show'),
                          )
                        : TransactionList(
                            transactions: _userTransactions,
                            deleteTx: _deleteTransaction,
                          ),
                  )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
