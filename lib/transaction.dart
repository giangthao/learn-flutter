import 'package:flutter/material.dart';

class Transaction{
  String content = '';
  double amount = 0;
  DateTime? createdAt;

  Transaction({required this.content, required this.amount, this.createdAt});

  @override
  String toString() {
    // TODO: implement toString
    return content + amount.toString() + '\n';
  }
}