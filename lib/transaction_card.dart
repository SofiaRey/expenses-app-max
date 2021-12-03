import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  Function delete;

  TransactionCard(this.transaction, this.delete);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Row(
          children: <Widget>[
            Container(
              child: new Icon(
                Icons.attach_money,
                size: 25.0,
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.only(left: 20),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(10),
              child: Text(
                transaction.amount.toStringAsFixed(2),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600),
                  ),
                  Text(
                    DateFormat.yMMMd().format(transaction.date),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ]),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                delete(transaction.id) as void Function(),
                            label: Text('Delete'))
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                delete(transaction.id) as void Function(),
                            color: Theme.of(context).primaryColor,
                          ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
