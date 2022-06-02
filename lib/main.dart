//ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:fluting/AddBookMark.dart';
import 'package:fluting/BookMarkPage.dart';
import 'package:fluting/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Constant.dart';

List<CameraDescription>? cameras;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Pest App',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      initialRoute: '/',
      // routes: {
      //   '/' : (context) => BookMarkPage(db: database,),
      //   '/add' : (context) => AddBookMark(database),
      // },
    );
  }

   Future<Database> initDatabase() async { // 데이터베이스를 열어서 반환해주는
    return openDatabase(
      join(await getDatabasesPath(), 'BookMark.db'),
      onCreate: (db,version){
        return db.execute("CREATE TABLE bookmark(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "name TEXT)",);
      },
      version: 1,
    );
  }
}
