import 'dart:io';

import 'package:fluting/BookMarkPage.dart';
import 'package:fluting/Constant.dart';
import 'package:fluting/PestDictionaryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'Constant.dart';
import 'HomeBodyHeaderWithSearchbox.dart';
import 'PestImageCropPage.dart';
import 'CameraPage.dart';
import 'PestInformationPage.dart';

class HomeBody extends StatelessWidget {
  File? imageFile;

  
  @override
  Widget build(BuildContext context) {
    // It will us total heigth and width of our screen
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HomeBodyHeaderWithSearchBox(size: size),
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding * 1.8,
              right: kDefaultPadding * 1.8,
              top: kDefaultPadding / 6,
              bottom: kDefaultPadding,
            ), 
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 10),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.20),
                        ),
                      ]),
                  child: CupertinoButton(
                    child: Text("사진 촬영"),
                    color: kPrimaryColor,
                    onPressed: () async {
                      final result = await Navigator.push(context, 
                      MaterialPageRoute(builder: (context){
                        return CameraPage();
                      },fullscreenDialog: true), );

                      if (imageFile != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PestImageCropPage(
                                title: "이미지 자르기",
                                imageFile: result,
                              );
                            },
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    minSize: 0,
                    padding: EdgeInsets.only(
                      bottom: kDefaultPadding,
                      top: kDefaultPadding,
                      left: kDefaultPadding * 2,
                      right: kDefaultPadding * 2 ,
                    ),
                  ),
                ),
                Spacer(),
                 Container(
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 10),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.20),
                        ),
                      ]),
                   child: CupertinoButton(
                    child: Text("갤러리"),
                    color: kPrimaryColor,
                    onPressed: () async {
                      await _pickImage();
                      if (imageFile != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PestImageCropPage(
                                title: "이미지 자르기",
                                imageFile: imageFile,
                              );
                            },
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    minSize: 0,
                    padding: EdgeInsets.only(
                      bottom: kDefaultPadding,
                      top: kDefaultPadding,
                      left: kDefaultPadding * 2 ,
                      right: kDefaultPadding * 2,
                    ),
                ),
                 ),
              ],
            ),
          ),
          TitleWithMoreBtn(
            title: "해충 사전",
            materialRoutePage: PestDictionaryPage(),
          ),
          RecomendsPests(),
          TitleWithMoreBtn(
            title: "즐겨 찾기",
            materialRoutePage: BookMarkPage(),
          ),
          RecomendsPests(),
          SizedBox(height: kDefaultPadding,)
          

        ],
      ),
    );
  }
   Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
  }
}

class RecomendsPests extends StatelessWidget {
  const RecomendsPests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RecomendedPestCard(
            image: "repo/images/4.png",
            name: "먹노린재",
            kinds: "해충",
          ),
          RecomendedPestCard(
            image: "repo/images/2.jpg",
            name: "꽃노랑총채벌레",
            kinds: "해충",
          ),
          RecomendedPestCard(
            image: "repo/images/3.jpg",
            name: "담배가루이",
            kinds: "해충",
          ),
          RecomendedPestCard(
            image: "repo/images/5.jpg",
            name: "검거세미밤나방",
            kinds: "나방",
          ),
          RecomendedPestCard(
            image: "repo/images/6.jpg",
            name: "도둑나방",
            kinds: "나방",
          ),
          RecomendedPestCard(
            image: "repo/images/8.jpg",
            name: "목화바둑명나방",
            kinds: "해충",
          ),
        ],
      ),
    );
  }
}

class RecomendedPestCard extends StatelessWidget {
  const RecomendedPestCard({
    Key? key,
    this.image,
    this.name,
    this.kinds,
  }) : super(key: key);

  final String? image, kinds;
  //final Function? press;
  @required final String? name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PestInfomationPage(name: name);
              }));
            },
      child: Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 3,
            bottom: kDefaultPadding * 1.1, 
            ),
        width: size.width * 0.25,
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                image!,
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
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$name\n".toUpperCase(),
                          // style: Theme.of(context).textTheme.button,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: "$kinds",
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                            fontSize: 12,
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
  @required final Widget? materialRoutePage;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          TitleWithCustomUnderline(
            text: title,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) {
              return materialRoutePage!;
            }));
            },
            child: Text(
              "더 보기",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ],
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
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
