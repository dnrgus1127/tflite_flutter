import 'dart:convert';
import 'dart:io';

import 'package:fluting/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pest.dart';

class PestInfomationPage extends StatefulWidget {
  //final File? imagePath;
  final String? name;
  final List<Pest>? pestlist;

  const PestInfomationPage({Key? key, @required this.name, @required this.pestlist,}) : super(key: key);

  @override
  _PestInfomationPage createState() => _PestInfomationPage();
}

class _PestInfomationPage extends State<PestInfomationPage> {
  File? imageTemp;
  List<Pest>? pestlist;

  //List data = List.empty(growable: true);

  String? name = "Defalut Value";
  String? damage = "";
  String? solution = "";
  String? shape ="";
  String? target = "";
  String imagePath = "";
  Pest? pest;
  bool? isBookMark = false;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    pestlist = widget.pestlist!;

    // this.loadJsonData().then((value) {
    //   for(var i in data) {
    //     if (i['name'] == name) {
    //       name = i['name'];
    //       target = i['target'];
    //       imagePath = "repo/images/" + i['name'] + ".jpg";
    //       solution = i['solution'];
    //       shape = i['shape'];
    //       damage = i['damage'];
    //     }
    //   }
    // });
    for(var i in pestlist!) {
        if (i.name == name) {
          name = i.name;
          target = i.targetCrop;
          imagePath = "repo/images/" + i.name! + ".jpg";
          solution = i.solution;
          shape = i.shape;
          damage = i.damage;
        }
      }
    _loadData(widget.name!).then((value) => {
      isBookMark = value,
      setState(() {
      
    })
      
    });
    setState(() {
      
    });
 
  }

  //  Future<String> loadJsonData() async {
  //   var jsonText = await rootBundle.loadString('assets/pest.json');
  //   setState(() => data = json.decode(jsonText));
  //   return 'success';
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(microseconds: 1000), () {});
    return Scaffold(
      backgroundColor: kPrimaryColor,
      //appBar: AppBar(title: Text('Display the Picture')),
      appBar: buildAppBar(context), 
      // ???????????? ??????????????? ????????? ???????????????. ???????????? ???????????? ?????? ?????????
      // ????????? `Image.file`??? ???????????????.
      body: _pictureBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0, // AppBar ????????? ??????
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        // IconButton(
        //   icon: Icon(CupertinoIcons.search),
        //   color: Colors.white,
        //   onPressed: () => Navigator.pop(context),
        // ),
        IconButton(
          icon: isBookMark! ? Icon(CupertinoIcons.bookmark_fill) : Icon(CupertinoIcons.bookmark),
          
          color: Colors.white,
          onPressed: () => {
            if(isBookMark!){
              _setData(widget.name!)
            }
            else{
              _addData(widget.name!),
            },
            isBookMark = !isBookMark!,
            setState(() {
      
            })

            
          },
        ),
        SizedBox(
          width: kDefaultPadding / 4,
        )
      ],
    );
  }
  
  
  Widget _pictureBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 1.3,
            child: Stack(
              children: <Widget>[
                Container(
                  //????????? ????????????
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: kDefaultPadding,
                      right: kDefaultPadding),
                  height: 1000,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -10),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PestName(
                        name: name,
                      ),
                      Description(title: "?????? ??????", content: target),
                      Description(
                        title: "??????",
                        content: shape,
                      ),
                      Description(
                        title: "??????",
                        content: damage,
                      ),
                      Description(
                        title: "????????????",
                        content: solution,
                      ),
                      Description(title: "??????", content: "?????? ?????????, ??????????????? ????????? ?????? ?????????")
                    ],
                  ),
                ),
                TitleWithImage(imageTemp: "repo/images/"+ name! +".jpg", name: name,)
              ],
            ),
          )
        ],
      ),
    );
  }



void _setData(String pest) async {
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(pest, false);
  }
    void _addData(String pest) async {
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(pest, true);
  }
  Future _loadData(String pest) async {
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool(pest);
    if(value == null){
      _setData(pest);
    }
    return pref.getBool(pest);
  }

}

class Description extends StatelessWidget {
  final String? content; 
  final String? title;
  const Description({
    Key? key,
    @required this.title,
    @required this.content,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: RichText(
              text: TextSpan(style: TextStyle(color: kPrimaryColor), children: [
            TextSpan(text: "$title\n"),
            TextSpan(
                text: content,
                style: TextStyle(height: 1.5, color: Colors.black),
        ),
          ],
        ),
      ),
      // child: Text(
      //   "????????? ???????????? 7mm??????,????????? ??? ????????? 12mm ????????????. ?????????????????????, ????????? ??? ????????? ????????????????????????????????????????????????,????????? ???????????????????????????.????????????????????????????????? ?????????0.7mm????????????????????????????????????.?????? ?????????????????????????????????????????????????????????,??? ???????????????????????????.?????????????????????????????? ????????????15~20mm????????????",
      //   style: TextStyle(height: 1.5),
      // ),
    );
  }
}

class PestName extends StatelessWidget {
  final String? name;

  const PestName({
    Key? key,
    final this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text("Color"),
        //       Container(
        //         margin: EdgeInsets.only(
        //             top: kDefaultPadding / 4, right: kDefaultPadding / 2),
        //         padding: EdgeInsets.all(2.5),
        //         height: 24,
        //         width: 24,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(color: kPrimaryColor),
        //         ),
        //         child: DecoratedBox(
        //           decoration: BoxDecoration(
        //             color: kPrimaryColor,
        //             shape: BoxShape.circle,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: RichText(
              text: TextSpan(style: TextStyle(color: kPrimaryColor), children: [
            TextSpan(text: "??????\n"),
            TextSpan(
                text: "$name",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20))
          ])),
        )
      ],
    );
  }
}

class TitleWithImage extends StatelessWidget {
    final String? name;


  const TitleWithImage({
    Key? key,
    @required this.imageTemp,
    @required this.name,
  }) : super(key: key);

  final String? imageTemp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding), // symmetric = ??????
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Row??? Column ??????
        children: [
          // Text(
          //   "?????? ??????",
          //   style: TextStyle(color: Colors.white),
          // ),
          Text(
            "??????",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          // SizedBox(
          //   height: kDefaultPadding / 2,
          // ),
          Row(
            children: <Widget>[
              //Icon(CupertinoIcons.bookmark_fill,color: Colors.yellow,),
              // RichText(
              //   text: 
              //     TextSpan(
              //       children: [
              //         TextSpan(text: "????????????\n"),
              //         TextSpan(
              //           text: "??????????????????",
              //           style: Theme.of(context).textTheme.headline4!.copyWith(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20),
              //         ),
              //       ],
              //   ),
              // ),
              //SizedBox(width: kDefaultPadding / 2),
              Spacer(),
              ClipRRect(
                child: Image.asset(imageTemp!,
                    fit: BoxFit.fill, width: 200, height: 200),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
