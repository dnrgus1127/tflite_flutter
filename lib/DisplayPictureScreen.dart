import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'ImageCrop.dart';

class DisplayPictureScreen extends StatefulWidget {
  final File? imagePath;

  const DisplayPictureScreen({Key? key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? imageTemp;
  List? _outputs;
  String? index = "Defalut Value";

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
    imageTemp = widget.imagePath;
    classifyImage(imageTemp!).then((_){
      index = _outputs![0]['label'];
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(microseconds: 1000), (){
      
    });
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: _pictureBody(context),
    );
  }

  Widget _pictureBody(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                child: Image.file(
                  widget.imagePath!,
                  fit: BoxFit.fill,
                  width: 150,
                  height: 150,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              Text(
                "이 해충은 $index 입니다.",
                style: TextStyle(fontSize: 20),
              ),
              CupertinoButton(
                child: Text("Button"),
                onPressed: () async {
                  await classifyImage(widget.imagePath!);

                  setState(() {
                    index = _outputs![0]['label'];
                  });
                },
              ),
              CupertinoButton(child: Text("Crop"), onPressed: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageCrop(imageFile: widget.imagePath, title: "가",),
                                
                          ),
                        );
              })
            ],
          ),
        ),
      ),
    );
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

  String _aiAnalisys() {
    return "";
  }
}
