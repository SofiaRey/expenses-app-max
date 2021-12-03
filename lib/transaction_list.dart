import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(children: <Widget>[
                  Text(
                    'No transaction added yet!',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      './assets/images/empty.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ]);
              })
            : ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                              color: Theme.of(context).accentColor,
                              blurRadius: 5.0,
                              spreadRadius: -1,
                              offset: Offset(3, 5)),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TransactionCard(transactions[index], deleteTx));
                },
                itemCount: transactions.length,
              ));
  }
}
