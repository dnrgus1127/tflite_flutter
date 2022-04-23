import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final File? imagePath;

  const DisplayPictureScreen({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진 
      // 경로로 `Image.file`을 생성하세요.
      body: Image.file(imagePath!),
    );
  }
}