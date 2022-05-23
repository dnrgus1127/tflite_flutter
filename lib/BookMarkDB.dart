import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


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
  id : 0,
  name : "밤나방",
);

