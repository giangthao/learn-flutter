import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions = <Transaction>[];

  TransactionList({required this.transactions});

  ListView _buildListView() {
    return ListView.builder(
      itemCount: transactions.length,
        itemBuilder: (context, index) {
          return  Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            color: Colors.pinkAccent,
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      transactions[index].content,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        "Price: ${transactions[index].amount}",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10))
                  ],
                ),
                Expanded(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            "Date: ${transactions[index].createdAt != null ? DateFormat.yMd().format(transactions[index].createdAt!) : 'N/A'}",
                            style: TextStyle(color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10))
                      ],
                    ))

              ],
            ),
            // child: ListTile(
            //   leading: const Icon(Icons.access_alarm),
            //   title: Text("This is content: ${transactions[index].content}",
            //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            //   subtitle: Text("This is amount: ${transactions[index].amount}",
            //     style: TextStyle(
            //         color: Colors.white
            //     ),),
            //   onTap: () {
            //     print('On list tap!');
            //   },
            // ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: _buildListView()
    );
  }
}