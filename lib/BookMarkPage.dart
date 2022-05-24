import 'dart:io';

import 'package:fluting/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({
    Key? key,
  }) : super(key: key);

  @override
  _BookMarkPageState createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  //int _count = 0;
  List<BookMark> bmList = List.empty(growable: true);

  @override
  void initState() {
    bookMarks().then((value) => {bmList = value, setState(() {}) });
  }

  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    insertBookMark(fido);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => {
        deleteAll()
      },),
      appBar: AppBar(title: Text("BookMarkPage",style: TextStyle(color: Colors.white),),backgroundColor: kPrimaryColor,elevation: 0,),
      body: Container(
        padding: EdgeInsets.all(5),
        color: kPrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  // SearchBox
                  //alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                      vertical: kDefaultPadding / 2),
                  padding: EdgeInsets.only(left: size.width / 30),
                  height: size.height / 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.38)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          //filterSearchResults(value);
                        },
                        //controller: editingController,
                        decoration: InputDecoration(
                          hintText: "작물 / 해충 이름 검색",
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.8)),
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      )),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              Container(
                height: size.height,
                //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(5, 10),
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.38))
                      ]),
                  padding: EdgeInsets.only(top: 10,bottom: 20,left: 3),
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: ListView.builder(
                  itemCount: bmList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        child: Column(
                          children: [
                            
                            //SizedBox(height :40),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${bmList[index].id!}  ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "${bmList[index].name}",
                                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 2,
                              //color: kPrimaryColor.withOpacity(0.48),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('BookMark DataBase'),
    //   ),
    //   body: Container(child: Column(
    //     children: [
    //       TextButton(onPressed: ()  {
    //        // bmList = await bookMarks(); // DB 내의 북마크 리스트 획득

    //       },child: Text("3"),),
    //       TextButton(onPressed: () {
    //         for(int i= 0; i<bmList.length;i++){
    //           print(bmList[i].name);
    //           print(bmList[i].id);
    //         }

    //       }, child: Text("print"))
    //     ],
    //   ),),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () async {
    //       //final bookmark = await Navigator.of(context).pushNamed('/add');
    //     },
    //     child: Icon(Icons.add),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    // );
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

  await db.insert('bookMark', bookMark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, );
  //db.execute("SELECT DISTINCT")
}

Future<Database> initDatabase() async {
  // 데이터베이스를 열어서 반환해주는
  return openDatabase(
    join(await getDatabasesPath(), 'bookMark4.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE bookmark(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "name TEXT)",
        // "CREATE TABLE bookmark(id INTEGER, "
        // "name TEXT PRIMARY KEY)",
        
      );
    },
    version: 1,
  );
}

final fido = BookMark(
  name: "밤나방",
);

final fido2 = BookMark(
  name: "나방",
);

final fido3 = BookMark(
  name: "밤",
);

Future<List<BookMark>> bookMarks() async {
  // 데이터베이스 reference를 획득.
  final Database db = await initDatabase();

  // 모든 Bookmark를 얻기 위해 테이블에 질의.
  final List<Map<String, dynamic>> maps = await db.query('bookMark',distinct: true);

  // List<Map<String, dynamic>를 List<bookmark>으로 변환합니다.
  return List.generate(maps.length, (i) {
    return BookMark(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

Future<void> deleteDog(String name) async {
  // 데이터베이스 reference를 얻습니다.
  final db = await initDatabase();

  // 데이터베이스에서 Dog를 삭제합니다.
  await db.delete(
    'bookMark',
    // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
    where: "name = ?",
    // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
    whereArgs: [name],
  );
}

deleteAll () async {
  Database db = await initDatabase();
  return await db.rawDelete("Delete * from bookMark");
}