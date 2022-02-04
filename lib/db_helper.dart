import 'package:sqflite/sqflite.dart' as sql;



class DBHelper{
  static Future<void> createTable(sql.Database database) async{
    await database.execute("""CREATE TABLE courses(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,courseName Text,courseTime TEXT,coursePrice TEXT)""");
  }


  static  Future<sql.Database>db() async{
    return sql.openDatabase("Courses.db",version:1,onCreate:
    (sql.Database database,int version) async {
      await createTable(database);
    });

  }


  static Future<int>addNewCourses(String courseName,String courseTime,String coursePrice) async{
    final db= await DBHelper.db();
    final data={
      'courseName': courseName,
      'courseTime': courseTime,
      'coursePrice': coursePrice,
    };
    final id= await db.insert('courses', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getAllCourses() async{
    final db= await DBHelper.db();
    return db.query('courses',orderBy: "id");
  }

  static Future<int>updateCourses( int id,String courseName,String courseTime,String coursePrice) async{
    final db = await DBHelper.db();
    final data={
      'courseName': courseName,
      'courseTime': courseTime,
      'coursePrice': coursePrice,
    };
    final result= await db.update('courses', data,where: "id=?",whereArgs: [id]);
    return result;
  }

  static Future<void>deleteCourse(int id) async{
    final db= await DBHelper.db();
      await db.delete("courses",where: "id=?",whereArgs: [id]);
    }
  }
