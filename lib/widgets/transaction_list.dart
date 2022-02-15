import 'package:demo/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  // ignore: use_key_in_widget_constructors
  const TransactionList({this.transactions, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          child: Card(
            elevation: 5,
            child: ListTile(
              trailing: MediaQuery.of(context).size.width > 450
                  ? FlatButton.icon(
                      textColor: Colors.red,
                      onPressed: () {
                        deleteTx(transactions[index].id);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'))
                  : IconButton(
                      color: Theme.of(context).errorColor,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteTx(transactions[index].id);
                      },
                    ),
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
