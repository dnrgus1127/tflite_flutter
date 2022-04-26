//ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:fluting/MainPage.dart';
import 'package:fluting/camera2.dart';
import 'package:fluting/dictionaryPage.dart';
import 'pestItem.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class CupertinoMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoMain();
  }
}

class _CupertinoMain extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Pest> pestList = List.empty(growable: true);
  File? _image;
  final picker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tabBar!,
        tabBuilder: (context, value) {
          if (value == 2) {
            return dictionaryPage(
              pestList: pestList,
            );
          } else if (value == 0) {
            return MainPage();
          } else if (value == 1) {
            return CameraExample();
          } else {
            return Container(
              child: Center(child: Text('병해충 진단 2P')),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.ant)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.ant_fill)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.ant_circle)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.ant_circle_fill)),
    ]);

  //   pestList.add(
  //       Pest(pestName: "검거세미나방", kind: "해충", imagePath: "repo/images/1.jpg"));
  //   pestList.add(
  //       Pest(pestName: "꽃노랑총채벌레", kind: "해충", imagePath: "repo/images/2.jpg"));
  //   pestList.add(
  //       Pest(pestName: "담배가루이", kind: "해충", imagePath: "repo/images/3.jpg"));
  //   pestList.add(
  //       Pest(pestName: "담배거세미나방", kind: "해충", imagePath: "repo/images/4.png"));
  //   pestList.add(
  //       Pest(pestName: "담배나방", kind: "해충", imagePath: "repo/images/5.jpg"));
  //   pestList.add(
  //       Pest(pestName: "도둑나방", kind: "해충", imagePath: "repo/images/6.jpg"));
  //   pestList.add(
  //       Pest(pestName: "먹노린재", kind: "해충", imagePath: "repo/images/7.jpg"));
  //   pestList.add(
  //       Pest(pestName: "목화바둑명나방", kind: "해충", imagePath: "repo/images/8.jpg"));
  //   pestList.add(Pest(
  //       pestName: "28점박이무당벌레", kind: "해충", imagePath: "repo/images/9.jpg"));
  }
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }
}
