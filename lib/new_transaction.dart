import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController = TextEditingController();

  final titleController = TextEditingController();
  DateTime? _selectedDate = null;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }

      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
                bottom: MediaQuery.of(context).viewInsets.bottom + 5),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0.0),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No date chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}'),
                      ),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: Text('Choose date',
                              style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                OutlinedButton(
                    onPressed: _submitData,
                    child: Text('Add Transaction'),
                    style: OutlinedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        side: BorderSide(
                            width: 1.0, color: Theme.of(context).primaryColor)))
              ],
            ),
          )),
    );
  }
}
