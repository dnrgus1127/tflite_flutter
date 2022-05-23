import 'dart:io';

import 'package:fluting/AddBookMark.dart';
import 'package:fluting/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BookMarkPage extends StatefulWidget {

  const BookMarkPage({
    Key? key,
  }) : super(key: key);

  @override
  _BookMarkPageState createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  int _count = 0;
  List<BookMark> bmList = List.empty(growable: true);
  Widget build(BuildContext context) {
    insertBookMark(fido);
    insertBookMark(fido2);
    insertBookMark(fido3);

    return Scaffold(
      appBar: AppBar(
        title: Text('BookMark DataBase'),
      ),
      body: Container(child: Column(
        children: [
          TextButton(onPressed: () async {
            bmList = await bookMarks();

            
          },child: Text("3"),),
          TextButton(onPressed: () {
            for(int i= 0; i<bmList.length;i++){
              print(bmList[i].name);
              print(bmList[i].id);
            }
            
          }, child: Text("print"))
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bookmark = await Navigator.of(context).pushNamed('/add');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }

 
}

class BookMark {
  int? id;
  String? name;

  BookMark({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

}

Future<void> insertBookMark(BookMark bookMark) async {
  final Database db = await initDatabase();

  await db.insert('bookMark', bookMark.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
}


Future<Database> initDatabase() async { // 데이터베이스를 열어서 반환해주는
  return openDatabase(
    join(await getDatabasesPath(), 'bookMark.db'),
    onCreate: (db,version){
      return db.execute("CREATE TABLE bookmark(id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "name TEXT)",);
    },
    version: 1,
  );
}

final fido = BookMark(
  name : "밤나방",
);

final fido2 = BookMark(
  name : "나방",
);

final fido3 = BookMark(
  name : "밤",
);

Future<List<BookMark>> bookMarks() async {
  // 데이터베이스 reference를 얻습니다.
  final Database db = await initDatabase();

  // 모든 Dog를 얻기 위해 테이블에 질의합니다.
  final List<Map<String, dynamic>> maps = await db.query('bookMark');

  // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
  return List.generate(maps.length, (i) {
    
    return BookMark(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

Future<void> deleteDog(int id) async {
  // 데이터베이스 reference를 얻습니다.
  final db = await initDatabase();

  // 데이터베이스에서 Dog를 삭제합니다.
  await db.delete(
    'bookMark',
    // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
    where: "id = ?",
    // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
    whereArgs: [id],
  );
}

