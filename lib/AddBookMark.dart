import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddBookMark extends StatefulWidget {
  final Future<Database> db;
  AddBookMark(this.db);

  @override
  State<StatefulWidget> createState() => _AddBookMark();
}

class _AddBookMark extends State<AddBookMark> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("33"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
