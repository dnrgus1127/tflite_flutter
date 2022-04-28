import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constant.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu),label: 'Text',),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Text'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Text'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Text'),
      ],
      // currentIndex: _selectedIndex,
      //onTap: _onItemTapped,
      
    );
  }
}
