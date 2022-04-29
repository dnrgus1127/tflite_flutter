//ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:fluting/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'Constant.dart';
import 'ScreenTest.dart';

List<CameraDescription>? cameras;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pest App',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
