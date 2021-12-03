import 'dart:io';

import 'package:expenses_app/new_transaction.dart';
import 'package:expenses_app/transaction_list.dart';
import './chart.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses app',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.cyan.shade50,
        fontFamily: 'Nunito',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Groceries', amount: 50, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Phone', amount: 109.99, date: DateTime.now()),
  ];

  bool showChart = false;
  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext ctx) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Expenses App',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(ctx),
          color: Colors.white,
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top,
          margin: EdgeInsets.all(5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (!isLandscape) Expanded(child: Chart(_recentTransactions)),
                if (!isLandscape)
                  Expanded(
                      flex: 4,
                      child:
                          TransactionList(_transactions, _deleteTransaction)),
                if (isLandscape)
                  Switch(
                      activeColor: Theme.of(context).primaryColor,
                      value: showChart,
                      onChanged: (val) {
                        setState(() {
                          showChart = val;
                        });
                      }),
                if (isLandscape)
                  showChart
                      ? Expanded(child: Chart(_recentTransactions))
                      : Expanded(
                          flex: 4,
                          child: TransactionList(
                              _transactions, _deleteTransaction)),
              ]),
        ),
      ),
      floatingActionButton: !Platform.isIOS
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(ctx),
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
