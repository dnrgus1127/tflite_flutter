import 'dart:io';
import 'dart:math';

import 'package:fluting/BookMarkPage.dart';
import 'package:fluting/CameraPage.dart';
import 'package:fluting/Constant.dart';
import 'package:fluting/Pest.dart';
import 'package:fluting/PestDictionaryPage.dart';
import 'package:fluting/PestImageCropPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'Constant.dart';
import 'HomeBodyHeaderWithSearchbox.dart';

import 'PestInformationPage.dart';

class HomeBody extends StatefulWidget {
  final List<Pest>? pestlist;

  HomeBody({@required this.pestlist});
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  File? imageFile;

  List<Pest> pestlist = List.empty(growable: true);
  List data = List.empty(growable: true);
  int pestRandom = 0;
  @override
  void initState() {
    super.initState();
    pestlist = widget.pestlist!;
    pestRandom = Random().nextInt(20);
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    // It will us total heigth and width of our screen
    Size size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeBodyHeaderWithSearchBox(size: size,pestlist: pestlist,),
            Container(
              color: Colors.white,
              child: TitleWithCustomUnderline(
                text: "메뉴",
              ),
              padding: EdgeInsets.only(
                  left: kDefaultPadding, bottom: kDefaultPadding * 0.8),
            ),
            // TitleWithMoreBtn(
            //   title: "메뉴",
            //   materialRoutePage: PestDictionaryPage(),
            // ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: kDefaultPadding),
              height: size.height / 8,
              padding:
                  EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
              child: Center(
                child: Container(
                  //color: kPrimaryColor,
                  decoration: BoxDecoration(
                    color: kPrimaryColor2,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 6),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.38),
                      ),
                    ],
                  ),
                  child: Container(
                    //child: Center(child: Text("사진촬영",style: TextStyle(color: kPrimaryColor,fontSize: 30,fontWeight: FontWeight.bold),)),

                    padding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                              return CameraPage(pestlist);
                                            },
                                            fullscreenDialog: true),
                                      );

                                      if (imageFile != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PestImageCropPage(
                                                pestlist: pestlist,
                                                title: "이미지 자르기",
                                                imageFile: result,
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      //color: Colors.green,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                              child: Icon(
                                            CupertinoIcons.camera_fill,
                                            color: kPrimaryColor,
                                          )),
                                          Text(
                                            "카메라",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      //color: Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await _pickImage();
                                      if (imageFile != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PestImageCropPage(
                                                pestlist: pestlist,
                                                title: "이미지 자르기",
                                                imageFile: imageFile,
                                              );
                                            },
                                          ),
                                        ).then((value) => pestRandom = Random().nextInt(20));
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      //color: Colors.green,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                              child: Icon(
                                            CupertinoIcons.app_badge_fill,
                                            color: kPrimaryColor,
                                          )),
                                          Text(
                                            "갤러리",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      //color: Colors.green,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return PestDictionaryPage(pestlist: pestlist,);
                                      }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      //color: Colors.green,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                              child: Icon(
                                            CupertinoIcons.book_fill,
                                            color: kPrimaryColor,
                                          )),
                                          Text(
                                            "해충 사전",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),

                                      //color: Colors.yellow,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return BookMarkPage();
                                      })).then((value) => pestRandom = Random().nextInt(20));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      //color: Colors.green,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                              child: Icon(
                                            CupertinoIcons.bookmark_fill,
                                            color: kPrimaryColor,
                                          )),
                                          Text(
                                            "즐겨 찾기",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      //color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TitleWithMoreBtn(
              title: "해충 사전",
              materialRoutePage: PestDictionaryPage(pestlist: pestlist,),
            ),
            Container(
              padding: EdgeInsets.only(left: kDefaultPadding / 2,),
              child: RecomendsPests(
                pestlist: pestlist,
              ),
            ),
            Container(
              child: TitleWithCustomUnderline(
                text: "오늘의 해충",
              ),
              padding: EdgeInsets.only(
                  left: kDefaultPadding),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PestInfomationPage(name: pestlist[pestRandom].name, pestlist: pestlist);
                                
                              
                            },
                          ),
                        ).then((value) => {pestRandom = Random().nextInt(20),setState((){})})
              },
              child: Container(
                height: size.height / 1.6 - 30,
                padding: EdgeInsets.all(kDefaultPadding),
                child: Container(
                  height: size.height / 2.5,
                  width: size.width - kDefaultPadding *2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.38),
                        ),
                      ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          pestlist[pestRandom].imagePath!,
                          fit: BoxFit.fill,
                          width: size.width - kDefaultPadding * 2,
                          height: size.height / 3,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: kDefaultPadding,left: kDefaultPadding),
                        height: size.height / 6,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("명칭",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),),
                            Text(
                              pestlist[pestRandom].name!,
                              style: TextStyle(
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: kDefaultPadding / 2,
                            ),
                            Text("대상 작물",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),),
                            Text(
                                pestlist[pestRandom].targetCrop!,
                                style: TextStyle(
                                    color: Colors.black),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
  }
}

class RecomendsPests extends StatefulWidget {
  final List<Pest>? pestlist;
  const RecomendsPests({Key? key, @required this.pestlist}) : super(key: key);

  @override
  _RecomendsPestsState createState() => _RecomendsPestsState();
}

class _RecomendsPestsState extends State<RecomendsPests> {
  List<Pest>? pestlist;
  @override
  void initState() {
    super.initState();
    pestlist = widget.pestlist!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![0].imagePath,
            name: pestlist![0].name,
            kinds: pestlist![0].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![1].imagePath,
            name: pestlist![1].name,
            kinds: pestlist![1].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![2].imagePath,
            name: pestlist![2].name,
            kinds: pestlist![2].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![3].imagePath,
            name: pestlist![3].name,
            kinds: pestlist![3].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![4].imagePath,
            name: pestlist![4].name,
            kinds: pestlist![4].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![5].imagePath,
            name: pestlist![5].name,
            kinds: pestlist![5].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![7].imagePath,
            name: pestlist![7].name,
            kinds: pestlist![7].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![6].imagePath,
            name: pestlist![6].name,
            kinds: pestlist![6].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![8].imagePath,
            name: pestlist![8].name,
            kinds: pestlist![8].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![9].imagePath,
            name: pestlist![9].name,
            kinds: pestlist![9].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![10].imagePath,
            name: pestlist![10].name,
            kinds: pestlist![10].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![11].imagePath,
            name: pestlist![11].name,
            kinds: pestlist![11].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![12].imagePath,
            name: pestlist![12].name,
            kinds: pestlist![12].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![13].imagePath,
            name: pestlist![13].name,
            kinds: pestlist![13].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![14].imagePath,
            name: pestlist![14].name,
            kinds: pestlist![14].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![15].imagePath,
            name: pestlist![15].name,
            kinds: pestlist![15].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![16].imagePath,
            name: pestlist![16].name,
            kinds: pestlist![16].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![17].imagePath,
            name: pestlist![17].name,
            kinds: pestlist![17].targetCrop,
          ),
          RecomendedPestCard(
            pestlist: pestlist,
            image: pestlist![18].imagePath,
            name: pestlist![18].name,
            kinds: pestlist![18].targetCrop,
          ),
        ],
      ),
    );
  }
}

class RecomendedPestCard extends StatefulWidget {
  const RecomendedPestCard({
    Key? key,
    this.image,
    this.name,
    this.kinds,
    @required this.pestlist
    
  }) : super(key: key);
  final List<Pest>? pestlist;

  final String? image, kinds;
  //final Function? press;
  @required
  final String? name;

  @override
  _RecomendedPestCardState createState() => _RecomendedPestCardState();
}

class _RecomendedPestCardState extends State<RecomendedPestCard> {
  List<Pest>? pestlist;
  @override
  void initState() {
    super.initState();
    pestlist = widget.pestlist;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PestInfomationPage(
            name: widget.name,
            pestlist: widget.pestlist,
          );
        }));
      },
      child: Container(
        
        margin: EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 3,
          bottom: kDefaultPadding * 1.1,
        ),
        width: size.width * 0.25,
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                widget.image!,
                fit: BoxFit.fill,
                width: 150,
                height: 80,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ]),
              child: Row(
                children: <Widget>[
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 
                          "${widget.name}".length > 8
                              ? "${widget.name}".substring(0, 8) + "\n"
                              : "${widget.name}\n",
                              
                          // style: Theme.of(context).textTheme.button,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                        TextSpan(
                          //text: "$kinds".substring(0,2),
                          text: "${widget.kinds}".length > 8
                              ? "${widget.kinds}".substring(0, 8) + "..."
                              : "${widget.kinds}",
                          //text: Text("$kinds",overflow: TextOverflow.ellipsis,);

                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key? key,
    this.title,
    //this.press,
    this.materialRoutePage,
  }) : super(key: key);

  final String? title;
  //final Function? press;
  @required
  final Widget? materialRoutePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          children: [
            TitleWithCustomUnderline(
              text: title,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return materialRoutePage!;
                }));
              },
              child: Text(
                "더 보기",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor2,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 27,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 20),
            child: Text(
              text!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 20),
              height: 3,
              color: kPrimaryColor.withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}
