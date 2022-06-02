import 'package:fluting/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BookMarkPage.dart';
import 'Constant.dart';
import 'PestDictionaryPage.dart';

class HomeBottomNavBar extends StatefulWidget {

  const HomeBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  _HomeBottomNavBarState createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeScreen(), PestDictionaryPage() ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      currentIndex: _currentIndex,
      backgroundColor: kPrimaryColor,
      onTap: (int index){
        setState(() {
          _currentIndex = index;
          Navigator.push(context, MaterialPageRoute(builder: (context) => _children[index]));
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.camera_fill),label: '카메라', ),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.collections_solid), label: '갤러리',),
        // BottomNavigationBarItem(icon: Icon(CupertinoIcons.bookmark), label: 'Text'),
        // BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_2), label: '정보'),
      ],
      // currentIndex: _selectedIndex,
      //onTap: _onItemTapped,
      
    );
  }
}
