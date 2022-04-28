import 'dart:io';

import 'package:fluting/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'HomeScreenBody.dart';
import 'PestInformationPage.dart';
import 'HomeScreenBottomNavBar.dart';
import 'Pest.dart';

class DictionaryPage extends StatefulWidget {
  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final List<Pest> pestlist = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    pestlist.add(Pest(
        name: "검거세미나방",
        targetCrop: "담배, 토마토, 오이, 콩, 감자, 가지 등",
        imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/2.jpg"));
    pestlist.add(
        Pest(name: "담배가루이", targetCrop: "토마토", imagePath: "repo/images/3.jpg"));
    pestlist.add(
        Pest(name: "먹노린재", targetCrop: "해충", imagePath: "repo/images/4.png"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: kPrimaryColor,
        child: Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBox(size: size),
              //SizedBox(height: 50,),
              Container(
                height: size.height - 150,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5, 10),
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.38))
                    ]),
                padding: EdgeInsets.only(top: 40),
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DisplayPictureScreen(
                                label: "배추흰나비",
                              );
                            },
                          ),
                        );
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
                                  pestlist[index].imagePath!,
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Text(pestlist[index].name!),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${pestlist[index].name!}\n",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "${pestlist[index].targetCrop}",
                                        style: TextStyle(color: Colors.black),
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
                  itemCount: pestlist.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Text(
        "병해충 사전",
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // SearchBox
      //alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      padding: EdgeInsets.only(left: size!.width / 30),
      height: size!.height / 15,
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
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: "해충 이름 검색",
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
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
    );
  }
}
