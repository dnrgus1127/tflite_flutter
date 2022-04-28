import 'dart:io';

import 'package:fluting/AI.dart';
import 'package:fluting/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatefulWidget {
  //final File? imagePath;
  final String? label;

  const DisplayPictureScreen({Key? key, this.label}) : super(key: key);

  @override
  _DisplayPictureScreen createState() => _DisplayPictureScreen();
}

class _DisplayPictureScreen extends State<DisplayPictureScreen> {
  File? imageTemp;
  
  String? label = "Defalut Value";

  @override
  void initState() {
    super.initState();
    // loadModel().then((value) {
    //   setState(() {});
    // });
    label = widget.label;
    // classifyImage(imageTemp!).then((_) {
    //   label = _outputs![0]['label'];
    // });
    // aiAnaly().then((_){
    //   setState(() {
        
    //   });
    // });
  }

  Future aiAnaly () async {
    await AiAnal.aiAnal(imageTemp).then((value) => label = value);    
    
  }

  @override
  void dispose() {
    //Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(microseconds: 1000), () {});
    return Scaffold(
      backgroundColor: kPrimaryColor,
      //appBar: AppBar(title: Text('Display the Picture')),
      appBar: buildAppBar(context), 
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: _pictureBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0, // AppBar 그림자 정도
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          icon: Icon(CupertinoIcons.bookmark_fill),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
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
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  //하얀색 컨테이너
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: kDefaultPadding,
                      right: kDefaultPadding),
                  height: 500,
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
                      ]
                      ),
                  child: Column(
                    children: [
                      PestName(
                        label: label,
                      ),
                      Description(
                        title: "형태",
                        content:
                            "성충은 몸길이가 7mm내외,날개를 편 길이는 12mm 내외이다. 머리는흑색이고, 가슴은 배 부분이 등황색이며 날개는 약간 검은 회색이고, 특히앞날개의 기부는진하다. 알은 원형으로 담록색이며 직경이0.7mm이고 잎의 조직속에 산란한다. 유충은 전체가 자흑색에 가는 가로 주름이 많이있고, 검은 벨벳의광택이있다. 가슴은 약간부풀어있고 성장하면15~20mm 에달한다",
                      ),
                      Description(
                        title: "피해",
                        content:
                            "유충은 십자화 과채 소등의 잎을 갉아 먹으며, 피해받은 흔적은 배추흰나비와 밤나방유충의 것과 비슷하지만 큰잎줄기만을 남기며 가장자리부터 갉아 먹는 점이 다르다. 봄에서 가을까지 발생하며, 특히  가을에 피해가 심하다",
                      ),
                      Description(
                        title: "방제방법",
                        content:
                            "통풍을 양호하게 하고, 솎아 주어 작물을 연약하지않게 하는 것 이 중요하다.애벌레의 피해가 보이면 적용약제를 살포한다.",
                      ),
                    ],
                  ),
                ),
                TitleWithImage(imageTemp: "repo/images/1.jpg", label: label,)
              ],
            ),
          )
        ],
      ),
    );
  }

//   loadModel() async {
//     await Tflite.loadModel(
//             model: "assets/model96.tflite", labels: "assets/label.txt")
//         .then((value) {
//       setState(() {});
//     });
//   }

//   Future classifyImage(File image) async {
//     print("출력 $image");
//     var output = await Tflite.runModelOnImage(
//         path: image.path, // required
//         imageMean: 0.0, // defaults to 117.0
//         imageStd: 255.0, // defaults to 1.0
//         numResults: 10, // defaults to 5
//         threshold: 0.2, // defaults to 0.1
//         asynch: true // defaults to true
//         );
//     setState(() {
//       _outputs = output;
//       //print("setState");
//     });
//   }
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
      //   "성충은 몸길이가 7mm내외,날개를 편 길이는 12mm 내외이다. 머리는흑색이고, 가슴은 배 부분이 등황색이며날개는약간검은회색이고,특히앞 날개의기부는진하다.알은원형으로담록색이며 직경이0.7mm이고잎의조직속에산란한다.유충 은전체가자흑색에가는가로주름이많이있고,검 은벨벳의광택이있다.가슴은약간부풀어있고 성장하면15~20mm에달한다",
      //   style: TextStyle(height: 1.5),
      // ),
    );
  }
}

class PestName extends StatelessWidget {
  final String? label;

  const PestName({
    Key? key,
    final this.label,
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
            TextSpan(text: "명칭\n"),
            TextSpan(
                text: "$label",
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
    final String? label;


  const TitleWithImage({
    Key? key,
    @required this.imageTemp,
    @required this.label,
  }) : super(key: key);

  final String? imageTemp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding), // symmetric = 대칭
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Row나 Column 정렬
        children: [
          Text(
            "진단 결과",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "해충",
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Row(
            children: <Widget>[
              //Icon(CupertinoIcons.bookmark_fill,color: Colors.yellow,),
              // RichText(
              //   text: 
              //     TextSpan(
              //       children: [
              //         TextSpan(text: "가해작물\n"),
              //         TextSpan(
              //           text: "검거세미나방",
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
                    fit: BoxFit.fill, width: 220, height: 220),
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
