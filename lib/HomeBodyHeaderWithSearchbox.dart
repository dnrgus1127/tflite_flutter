import 'package:fluting/BookMarkPage.dart';
import 'package:fluting/PestDictionaryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Constant.dart';



class HomeBodyHeaderWithSearchBox extends StatefulWidget {
  const HomeBodyHeaderWithSearchBox({
    Key? key,
    @required this.size,
  }) : super(key: key);

  final Size? size;

  @override
  _HomeBodyHeaderWithSearchBoxState createState() => _HomeBodyHeaderWithSearchBoxState();
}

class _HomeBodyHeaderWithSearchBoxState extends State<HomeBodyHeaderWithSearchBox> {
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController();
  }
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1), // SearchBox 와 TitleWithMorebtn 사이 거리
      height: widget.size!.height * 0.18,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding),
            height: widget.size!.height * 0.18 - 18,
            decoration: BoxDecoration(
              color: kPrimaryColor2,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  "해충 진단 AI",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                    offset: Offset(0, 6),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.38),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PestDictionaryPage(
                                hint: searchController!.value.text,
                                
                              );
                            },
                          ),
                        ).then((value) => searchController!.text = "");
                      },
                      decoration: InputDecoration(
                        hintText: "작물 / 해충 이름 검색",
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
