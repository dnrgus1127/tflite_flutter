import 'dart:async';

import 'package:fluting/Constant.dart';
import 'package:fluting/HomeScreen.dart';
import 'package:fluting/LoadPestlist.dart';
import 'package:fluting/Pest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget{


  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  List<Pest> pestlist = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    LoadPestlist pl = new LoadPestlist();
    pestlist = pl.getPestlist();

    Timer(Duration(milliseconds: 1500), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(pestlist: pestlist,)));
    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Center(child: Text("금공강",style: TextStyle(color: kPrimaryColor,fontSize: 50,fontWeight: FontWeight.bold ),),),
      ),
    );

  }
}