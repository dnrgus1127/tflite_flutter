import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Constant.dart';



class HomeBodyHeaderWithSearchBox extends StatelessWidget {
  const HomeBodyHeaderWithSearchBox({
    Key? key,
    @required this.size,
  }) : super(key: key);

  final Size? size;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1), // SearchBox 와 TitleWithMorebtn 사이 거리
      height: size!.height * 0.18,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding),
            height: size!.height * 0.18 - 18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  "병해충 AI",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.ant_circle,
                  size: 40,
                  color: Colors.black38,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 50, // 검색 창 높이 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.38),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "해충 이름 검색",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        // suffixIcon: Icon(
                        //   CupertinoIcons.search,
                        //   color: kPrimaryColor.withOpacity(0.5),
                        // ),
                      ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.search,
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
