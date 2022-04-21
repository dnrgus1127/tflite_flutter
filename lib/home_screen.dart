import 'package:fluting/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './body.dart';
import 'MyBottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottonNavBar(),

    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 60,
      leading: IconButton(
        icon: Icon(CupertinoIcons.bars),
        onPressed: () {},
      ),
    );
  }
}
