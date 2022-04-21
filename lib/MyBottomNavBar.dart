
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class MyBottonNavBar extends StatelessWidget {
  const MyBottonNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding / 2,
        right: kDefaultPadding / 2,
        bottom: kDefaultPadding ,
      ),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.star_fill,
              color: kPrimaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.heart_fill,
              color:kPrimaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.square_stack_fill,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
