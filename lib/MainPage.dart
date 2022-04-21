//ignore_for_file: prefer_const_constructors

import 'package:fluting/secondPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluting/camera2.dart';
import 'package:fluting/dictionaryPage.dart';
import 'pestItem.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  File? _image;
  final picker = ImagePicker();
  String result = "결과";
  String second = "";
  List? _outputs;
  var per;

  // 앱이 실행될 때 loadModel 호출
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("병해충 진단"),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                child: _image == null
                    ? Image.asset(
                        "repo/images/4.png",
                        fit:  BoxFit.fill,
                      )
                    : Image.file(
                        File(_image!.path),
                        width: 200,
                        height: 200,
                        fit:  BoxFit.fill
                      ),
                borderRadius: BorderRadius.circular(8.0),     
              ),
              const SizedBox(
                height: 10,
              ),
              Text(result),
              Text(second),
              const SizedBox(
                height: 10,
              ),
              CupertinoButton(
                onPressed: () async {
                  await getImage(ImageSource.camera);
                  //await classifyImage(_image!).then((value) => print(_outputs![0]['label']));
                  await classifyImage(_image!).then((value) => print(_outputs));
                  setState(() {
                    result = _outputs![0]['label'];
                  });
                },
                color: Colors.blueAccent,
                child: Text('카메라'),
              ),
              const SizedBox(
                height: 25,
              ),
              CupertinoButton(
                child: Text("갤러리"),
                color: Colors.blueAccent,
                onPressed: () async {
                  await getImage(ImageSource.gallery)
                      .then((value) => print("getImage"));
                  await classifyImage(_image!).then((value) => print(_outputs));
                  setState(() {
                    //result = _outputs![0]['label'] + "와 " + _outputs![0]['confidence'].toString().toUpperCase()+ "일치합니다.";
                    result =
                        "${_outputs![0]['label']} 와 ${_outputs![0]['confidence'] * 100}% 일치합니다.";

                    _outputs!.length < 2
                        ? second = ""
                        : second =
                            "${_outputs![1]['label']} 와 ${_outputs![1]['confidence'] * 100}% 일치합니다.";

                    //result = "담배가루이와 ${per}% 일치합니다.";
                    print(_outputs);
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              CupertinoButton(
                  child: Text("Analysis"),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) =>
                            SecondPage(_outputs![0]['label'], _image!)));
                  })
            ],
          ),
        ));
  }

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  loadModel() async {
    await Tflite.loadModel(
            model: "assets/model96.tflite", labels: "assets/label.txt")
        .then((value) {
      setState(() {});
    });
  }

  Future classifyImage(File image) async {
    print("출력 $image");
    var output = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 10, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    setState(() {
      _outputs = output;
      print("setState");
    });
  }

  recycleDialog(BuildContext context) {
    _outputs != null
        ? showDialog(
            context: context,
            barrierDismissible:
                false, // barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _outputs![0]['label'].toString().toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        background: Paint()..color = Colors.white,
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Center(
                    child: new FlatButton(
                      child: new Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              );
            })
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "데이터가 없거나 잘못된 이미지 입니다.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Center(
                    child: new FlatButton(
                      child: new Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              );
            });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
