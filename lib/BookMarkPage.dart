import 'dart:collection';
import 'dart:convert';

import 'package:fluting/Constant.dart';
import 'package:fluting/Pest.dart';
import 'package:fluting/PestInformationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({
    Key? key,
  }) : super(key: key);

  @override
  _BookMarkPageState createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  //List<BookMark> bmList = List.empty(growable: true);
  final List<Pest> pestlist = List.empty(growable: true);
  List data = List.empty(growable: true);
  var items = List.empty(growable: true);
  HashMap<String, bool> bookMarkMap = new HashMap<String, bool>();

  @override
  void initState() {
    super.initState();

    this.loadJsonData().then(
      (value) {
        for (var i in data) {
          pestlist.add(
            Pest(
              name: i['name'],
              targetCrop: i['target'],
              imagePath: "repo/images/" + i['name'] + ".jpg",
              solution: i['solution'],
              shape: i['shape'],
              damage: i['damage'],
            ),
          );
          // _loadData(i['name']).then((value) => {
          //       bookMarkMap.addAll({i['name']: value}),
          //       filterBookMarkResult()
          //     });
          // _loadDataAll 메서드 만들어서 대체 
        
        }
        _loadDataAll(pestlist);
      },
    );
    setState(() => {});
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/pest.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }


  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _loadData("먹노린재").then((value) => print(value)),
          _addData("먹노린재"),
        },
      ),
      appBar: AppBar(
        title: Text(
          "BookMarkPage",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        color: kPrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // SearchBox
                //alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                    vertical: kDefaultPadding / 2),
                padding: EdgeInsets.only(left: size.width / 30),
                height: size.height / 15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.38)),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        //filterSearchResults(value);
                      },
                      //controller: editingController,
                      decoration: InputDecoration(
                        hintText: "작물 / 해충 이름 검색",
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.8)),
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height - 155,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5, 10),
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.38))
                    ]),
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 3),
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PestInfomationPage(
                                name: items[index].name,
                              );
                            },
                          ),
                        ).then(
                            (value) => {_loadDataAll(pestlist), filterBookMarkResult()});
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 2,
                              color: kPrimaryColor.withOpacity(0.48),
                            ),
                            //SizedBox(height :40),
                            Row(
                              children: [
                                Image.asset(
                                  items[index].imagePath!,
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${items[index].name!}\n",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "${items[index].targetCrop}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void filterBookMarkResult() { // 북마크 리스트에 있는 해충들만 검색해서 item 리스트에 추가
    List<Pest> dummySearchList = List.empty(growable: true);
    dummySearchList.addAll(pestlist);

    List<Pest> dummyListData = List.empty(growable: true);
    if (pestlist.isEmpty) {
      print("empty");
    }
    if (bookMarkMap.isEmpty) {
      print("empty");
    }
    dummySearchList.forEach((item) {
      if (bookMarkMap[item.name] == true) {
        dummyListData.add(item);
        dummyListData.sort((a, b) => a.name!.compareTo(b.name!));
      }
    });
    setState(() {
      items.clear();
      items.addAll(dummyListData);
    });
  }
  
  void _loadDataAll(List<Pest> pestlist) { // List<Pest> 형태의 Pest 목록들을 기준으로 이름을 검색해서 모든 북마크 값 읽음
    for (var i in pestlist) {
      _loadData(i.name!).then((value) => {
            bookMarkMap.addAll({i.name!: value}),
            filterBookMarkResult()
          });
    }
  }

  void _setData(String pestname) async { // 북마크 리스트에서 해당 해충명 제거  
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(pestname, false);
  }

  void _addData(String pestname) async { // 북마크 리스트에 해당 해충명 추가 
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(pestname, true);
  }

  Future _loadData(String pestname) async {  // 매개변수로 해충 이름을 받아서 해당 해충의 북마크 여부 bool값 반환
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool(pestname);
    if (value == null) { // 내부 저장소에 북마크값 생성 되어있는지 확인
      _setData(pestname);
    }
    return pref.getBool(pestname);
  }
}

class BookMark {   // 즐겨찾기 이름, 즐겨찾기 여부 클래스
  String? name;
  bool? isBookMark;

  BookMark({this.name, this.isBookMark});
}
