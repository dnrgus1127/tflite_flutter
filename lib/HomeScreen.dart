import 'package:fluting/Constant.dart';
import 'package:fluting/HomeBottomNav.dart';
import 'package:fluting/Pest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'HomeScreenBody.dart';
import 'PestDictionaryPage.dart';
import 'HomeScreenBottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  final List<Pest>? pestlist;

  HomeScreen({@required this.pestlist});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Scaffold(
        appBar: buildAppBar(),
        body: HomeBody(pestlist: pestlist,),
        //bottomNavigationBar: HomeBottomNavBar(),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.camera_enhance),
        //   backgroundColor: kPrimaryColor,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return PestDictionaryPage();
        //         },
        //       ),
        //     );
        //   },
          
        // ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterDocked,
      ),
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
