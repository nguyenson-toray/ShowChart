import 'dart:async';
import 'package:tivn_chart/dataClass/InspectionSummaryDay.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class MySqLite {
  final String tableInspectionDetails = 'InspectionDetails';
  final String tableInspectionSummary = 'InspectionSummary';
  String dbPath = '';
  String dbName = 'toray.db';
  late Database database;
  String query = '';
  Future<String> getPath() async {
    String path;
    path = await getDatabasesPath();
    return '$path/$dbName';
  }

  void closeDB() {
    database.close();
  }

  Future<bool> isDbExits() async =>
      databaseFactory.databaseExists(await getPath());
  Future<void> openDB() async {
    var path = await getPath();
    database = await openDatabase(path);
  }

  Future<void> createDB() async {
    try {
      var path = await getPath();
      print('============= createDB : $path');
      database = await openDatabase(
        path,
        onCreate: (db, int version) async {
          await db.execute('$queryCreate_InspectionDetails;');
        },
        version: 1,
      );
      // await database.close();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> insertIntoTable(String tabelName, dynamic rowData) async {
    print('database.path = ' + database.path);
    var open = await isDbExits();
    print('is open = ' + open.toString());
    try {
      int result = await database.insert(
        tabelName,
        rowData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('insertIntoTable : $tabelName -result : ' + result.toString());
    } catch (e) {
      print('insertIntoTable : $tabelName ERROR : ' + e.toString());
    }
  }

  Future<List<InspectionSummaryDay>> loadInspectionSummaryDay() async {
    print('Future<List<InspectionSummaryDay>> loadInspectionSummaryDay() ');
    List<InspectionSummaryDay> result = [];
    List<Map<String, dynamic>> maps;
    try {
      maps = await database.query(tableInspectionSummary);
      return List.generate(maps.length, (i) {
        print('maps[i] : ' + maps[i].toString());
        return InspectionSummaryDay.fromMap(maps[i]);
      });
    } catch (e) {
      print('loadInspectionSummaryDay : ' + e.toString());
    }
    return result;
  }

  Future<void> updateInspectionSummary(InspectionSummaryDay dataInput) async {
    print('SQLite updateInspectionSummary');

    int id = -1;
    try {
      List<InspectionSummaryDay> dataInDB = await loadInspectionSummaryDay();
      print('---------leght = ' + dataInDB.length.toString());
      dataInDB.forEach((element) {
        if (element.getDate == dataInput.getDate &&
            element.getLine == dataInput.getLine &&
            element.getStyleCode == dataInput.getStyleCode &&
            element.getSize == dataInput.getSize) {
          //exits data => get id to update
          id = element.getId;
        } else {}
      });
      if (id != -1) {
        print('UPDATE at id = ' + id.toString());
        await database.update(
          tableInspectionSummary,
          dataInput.toMap(),
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        print('INSERT');
        dataInput.setId =
            int.parse(DateFormat('yyyyMMddHHmmss').format(DateTime.now()));
        await insertIntoTable(tableInspectionSummary, dataInput);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final String queryCreate_T01_1st_inspection_data =
      r'''CREATE TABLE 'T01_1st_inspection_data' 
  (ID INTEGER AUTO INCREMENT PRIMARY KEY , 
   X01 INTEGER, X02 DATETIME default current_timestamp, X03 INTEGER, X04 VARCHAR(20),  X05 VARCHAR(20), X06 INTEGER,  X07 INTEGER,	X08 INTEGER,	X09 INTEGER,	X10 INTEGER,	
   A1 INTEGER, 	A2 INTEGER,	A3	INTEGER,
   B1	INTEGER, B2 INTEGER,	B3	INTEGER,C1	INTEGER,C2	INTEGER,D1	INTEGER,D2	INTEGER,D3 INTEGER,
   D4 INTEGER,	E1 INTEGER,	E2 INTEGER,	E3 INTEGER,	E4 INTEGER,	E5 INTEGER,	E6 INTEGER,	E7 INTEGER,	
   F1 INTEGER,	F2 INTEGER,	F3 INTEGER,	F4 INTEGER,	F5 INTEGER,	F6 INTEGER,	F7 INTEGER,	F8 INTEGER,	F9 INTEGER,	
   G1 INTEGER,	G2 INTEGER,	G3 INTEGER,	H INTEGER,
   XC TEXT,	'Sum A' INTEGER, 	'Sum B' INTEGER,	'Sum C' INTEGER,	'Sum D' INTEGER,	'Sum E' INTEGER,	'Sum F' INTEGER,	'Sum G' INTEGER, 	
   Total INTEGER,	X11 INTEGER,	X12 INTEGER,	'T-Month' INTEGER,	'T-Year' INTEGER,	TF INTEGER
  );''';

  final String queryCreate_InspectionDetails = r'''
 CREATE TABLE 'InspectionDetails' (id INTEGER AUTO INCREMENT PRIMARY KEY ,time INTEGER, date  DATETIME, line INTERGER, customer VARCHAR(20), style VARCHAR(20),
  styleCode INTERGER, color VARCHAR(20), size VARCHAR(20),  spectionFirstSecond INTEGER, 
  quantity INTERGER, result VARCHAR(20), groupDefect VARCHAR(20), defect VARCHAR(20)
  );
''';
}
