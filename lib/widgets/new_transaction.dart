import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(_amountInput.text.isEmpty ){
      return ;
    }
    final enteredTitle = _titleInput.text;
    final enteredAmount = double.parse(_amountInput.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate ==null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _percentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleInput,
              onSubmitted: (_) => _submitData(),
              /*onChanged: (val) {
                      titleInput = val;
                    },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountInput,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              //   onChanged: (val) => amountInput = val,
            ),
            // FlatButton(
            //   child: Text('Add'),
            //   textColor: Colors.purple,
            //   onPressed: () {},
            // ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date Choosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _percentDatePicker,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            FloatingActionButton.extended(
              icon: Icon(Icons.save),
              label: Text("Save"),
              foregroundColor: Colors.white,
              tooltip: 'Add Transaction',
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
