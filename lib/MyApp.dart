import 'package:flutter/material.dart';
import 'transaction.dart';
import 'TransactionList.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  // define state
  Transaction _transaction = Transaction(content: '', amount: 0);
  List<Transaction> _transacions = <Transaction>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _insertTransaction() {
    if(this._transaction.content.isEmpty || _transaction.amount == 0 || _transaction.amount.isNaN) {
      return;
    }
    _transaction.createdAt = DateTime.now();
    _transacions.add(_transaction);
    _transaction = Transaction(content: '', amount: 0);
    _contentController.text = '';
    _amountController.text = '';
  }

  void _onButtonShowModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
           return Container(
             padding: EdgeInsets.all(20),
             child: Column(
               children: <Widget>[
                 TextField(
                   decoration: InputDecoration(labelText: 'Content'),
                   controller: _contentController,
                   onChanged: (value){
                     setState(() {
                       _transaction.content = value;
                     });

                   },
                 ),
                 TextField(
                   decoration: InputDecoration(labelText: 'Amount(money)'),
                   controller: _amountController,
                   onChanged: (value) {
                     setState(() {
                       _transaction.amount = double.tryParse(value) ?? 0;
                     });
                   },
                 ),
                 Padding(padding: EdgeInsets.only(bottom: 20)),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     Expanded(
                         child: ElevatedButton(
                             onPressed: () {
                               setState(() {
                                 _insertTransaction();
                               });
                               Navigator.of(context).pop();
                             },
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.blue,
                             ),
                             child: Text("Save", style: TextStyle(color: Colors.white),)
                         )),
                     Padding(padding: EdgeInsets.only(left: 10)),
                     Expanded(
                         child: ElevatedButton(
                             onPressed: () {
                               Navigator.of(context).pop();
                             },
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.black
                             ),
                             child: Text(
                               "Cancel",
                               style: TextStyle(color: Colors.white),
                             )
                         ))
                   ],
                 )
               ],
             ),
           );
        }
        );
 
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: const Text('Transaction Quản ly', style: TextStyle(fontFamily: 'Roboto'),),
       actions: <Widget>[
         IconButton(
             onPressed: () {
               _onButtonShowModalSheet();
             },
             icon: Icon(Icons.add))
       ],
     ),
     floatingActionButton: FloatingActionButton(
       tooltip: "Add Transaction",
       child: Icon(Icons.add),
       onPressed: () {
         _onButtonShowModalSheet();
       },
       backgroundColor: Theme.of(context).primaryColor,
     ),
     key: _scaffoldKey,
     body: SafeArea(
         minimum: const EdgeInsets.only(left: 20, right: 20),
         child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[

               Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
               ButtonTheme(
                 height: 60,
                 child: TextButton(
                   onPressed: () {
                     _onButtonShowModalSheet();
                   },
                   style: TextButton.styleFrom(
                       foregroundColor: Colors.white,
                       backgroundColor: Colors.pink
                   ),
                   child: Text("Insert transaction"),
                 ),
               ),
               TransactionList(transactions: _transacions)
             ],
           ),
         )
     ),

   );
  }
}