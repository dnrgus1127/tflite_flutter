//ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SecondPage extends StatefulWidget {
  final String data;
  final File _image;
  const SecondPage(this.data, this._image);

  @override
  State<StatefulWidget> createState() {
    return _SecondPage();
  }
}

class _SecondPage extends State<SecondPage> {
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Result Page'),
      ),
      child: Center(
      
        child: Column(children: <Widget>[
          SizedBox(
            height: 80,
          ),
          ClipRRect(
            child: Image.file(
              File(widget._image.path),
              fit: BoxFit.fill,
              width: 150,
              height: 150,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          Text("${widget.data}"),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.brown.shade300,
                border: Border(
              top: BorderSide(width: 2.0, color: Colors.black38),
              bottom: BorderSide(width: 2.0, color: Colors.black38),
            )),
            child: Text(
              " 방제 방법",style: TextStyle(fontWeight: FontWeight.bold),
            ),
            width: MediaQuery.of(context).size.width, //앱 화면 넓이 double Ex> 360.0
            //color: Colors.,
          )
        ]),
      ),
    );
  }
}
