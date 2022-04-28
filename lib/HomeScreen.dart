import 'package:fluting/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'HomeScreenBody.dart';
import 'PestDictionaryPage.dart';
import 'HomeScreenBottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: HomeBody(),
      bottomNavigationBar: HomeBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DictionaryPage();
              },
            ),
          );
        },
        
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 65,
      leading: IconButton(
        icon: Icon(CupertinoIcons.bars),
        onPressed: () {},
      ),
    );
  }
}
