import 'dart:async';
import 'dart:convert';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataClass/lastSetting.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:tivn_chart/dataClass/inspectionDetail.dart';
import 'package:tivn_chart/global.dart';

class MySqLite {
  final String tableT00Trans = 'T00_Trans';
  final String tableT02Week = 'T02_Week';
  final String tableT011stInspectionData = 'T01_1st_inspection_data';
  final String table03ProductionItem = 'T03_Product_item';
  final String table04PlanProduction = 'T04_Plan_production';
  final String table05ManPowerSewingTime = 'T05_Man_power_sewing_time';
  final String table06Color = 'T06_Color';
  final String tableInspectionDetails = 'InspectionDetails';
  final String tableLastSetting = 'LastSetting';

  String dbPath = '';
  String dbName = 'Inspection.db';
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
    var lastSetting = LastSetting(line: 1);
    try {
      var path = await getPath();
      print('============= createDB : $path');
      database = await openDatabase(
        path,
        onCreate: (db, int version) async {
          await db.execute('$queryCreate_T01_1st_inspection_data;');
          await db.execute('$queryCreate_T03_Product_item;');
          await db.execute('$queryCreate_T04_Plan_production;');
          await db.execute('$queryCreate_InspectionDetails;');
          await db.execute('$queryCreate_LastSetting;');

          // await db.execute('$queryCreate_InspectionSummary;');
        },
        version: 1,
      );
      insertIntoTable(tableLastSetting, lastSetting);
      // await database.close();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteRowsInTable(String tabelName) async {
    print("deleteRowsInTable : $tabelName");
    try {
      int result = await database.rawDelete('DELETE FROM  $tabelName');
    } catch (e) {
      print('deleteRowsinTable  ERROR : ' + e.toString());
    }
  }

  Future<void> insertIntoTable(String tabelName, dynamic rowData) async {
    print('insertIntoTable : $tabelName');
    // var open = await isDbExits();
    // print('is open = ' + open.toString());
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

  Future<void> insertIntoTable_T011stInspectionData(
      T011stInspectionData input) async {
    String defectName = '';
    if (input.getDefectName == null || input.getDefectName.length == 0)
      defectName = '';

    DateTime date_DateTime = DateFormat("yyyy-MM-dd").parse(input.getX02);
    var date_String = input.getX02;
    String queryInsert = '''INSERT INTO ${tableT011stInspectionData} 
            ([2nd],X01,X02,X03,X04,X05,X06,X07,X08,X09,X10,
            A1,A2,A3,B1,B2,B3,C1,C2,
            D1,D2,D3,D4,
            E1,E2,E3,E4,E5,E6,E7,
            F1,F2,F3,F4,F5,F6,F7,F8,F9,
            G1,G2,G3,H,XC,	
            [Sum A],[Sum B],[Sum C],[Sum D],[Sum E],[Sum F],[Sum G],
            Total,X11,X12,[T-Month],[T-Year],TF,
            time,isReCheck,defectNames,totalChecked ) 
          VALUES(${input.getInspectionType},${input.getX01}, '${global.todayString}', ${input.getX03}, '${input.getX04}', '${input.getX05}', ${input.getX06}, ${input.getX07}, ${input.getX08}, ${input.getX09}, ${input.getX10},
            ${input.getA1},	${input.getA2},	${input.getA3},	${input.getB1},	${input.getB2},	${input.getB3},	${input.getC1},	${input.getC2},	
            ${input.getD1},	${input.getD2},	${input.getD3},	${input.getD4},	
            ${input.getE1},	${input.getE2},	${input.getE3},	${input.getE4},	${input.getE5},	${input.getE6},	${input.getE7},
            ${input.getF1},	${input.getF2},	${input.getF3},	${input.getF4}, ${input.getF5},	${input.getF6},${input.getF7}, ${input.getF8}, ${input.getF9},	
            ${input.getG1},	${input.getG2},	${input.getG3},	${input.getH}, '${input.getXc}',	
            ${input.getSumA},	${input.getSumB},	${input.getSumC},	${input.getSumD},	${input.getSumE},	${input.getSumF},	${input.getSumG},	
            ${input.getTotal}, ${input.getX11},	${input.getX12}, ${input.getTMonth}, ${input.getTYear}, ${input.getTF}, 
            '${input.getTime}', ${input.getIsReCheck},'${defectName}', ${input.getTotalChecked}
          );''';
    String queryDeleteRow = '''
        DELETE FROM ${tableT011stInspectionData} 
        WHERE  (X02 ='${global.todayString}' and  X01 =${input.getX01} and X03 = ${input.getX03} and X04 = '${input.getX04}' and X05 = '${input.getX05}' 
        );''';
    // var open = await isDbExits();
    // print('is open = ' + open.toString());
    // print("insert : $queryInsert");
    try {
      // var deleteResult = await database.rawDelete(queryDeleteRow);

      // print('SQLite insertIntoTable_T011stInspectionData queryInsert : ' +
      //     queryInsert.toString());
      var insertResult = await database.rawInsert(queryInsert);
      print('insertResult : ' + insertResult.toString());
    } catch (e) {
      print('ERROR : ' + e.toString());
    }
  }

  Future<List<LastSetting>> loadLastSetting() async {
    print('loadLastSetting ');
    List<LastSetting> NoResult = [];
    List<Map<String, dynamic>> maps;
    try {
      maps = await database.query(tableLastSetting);
      return List.generate(maps.length, (i) {
        return LastSetting.fromMap(maps[i]);
      });
    } catch (e) {
      print('loadLastSetting Exception : ' + e.toString());
    }
    return NoResult;
  }

  Future<List<InspectionDetail>> loadInspectionDetails() async {
    print('loadInspectionDetails');
    List<Map<String, dynamic>> maps;
    List<InspectionDetail> NoResult = [];
    try {
      maps = await database.query(tableInspectionDetails);
      return List.generate(maps.length, (i) {
        return InspectionDetail.fromMap(maps[i]);
      });
    } catch (e) {
      print('loadInspectionDetails : ' + e.toString());
    }
    return NoResult;
  }

  Future<List<InspectionDetail>> loadInspectionDetailsByLastSetting() async {
    print('loadInspectionDetailsByLastSetting');
    List<Map<String, dynamic>> maps;
    List<InspectionDetail> result = [];
    List<InspectionDetail> allInspectionDetails = await loadInspectionDetails();

    allInspectionDetails.forEach((element) {
      final date = DateFormat(global.dateFormat).parse(element.getDate);
      final today = DateFormat(global.dateFormat).parse(global.todayString);

      if (date == today &&
          element.getLine == global.lastSetting.getLine &&
          element.getCustomer == global.lastSetting.getCustomer &&
          element.getStyle == global.lastSetting.getStyle &&
          element.getSize == global.lastSetting.getSize &&
          element.getColor == global.lastSetting.getColor) {
        result.add(element);
      }
    });
    print('RESULT length :' + result.length.toString());
    return result;
  }

  Future<T011stInspectionData> loadT01InspectionDataByLastSetting() async {
    print('loadT01InspectionDataByLastSetting');
    List<Map<String, dynamic>> maps;
    T011stInspectionData result = T011stInspectionData();
    List<T011stInspectionData> allInspectionDetails =
        await loadInspectionDataT01();

    for (final element in allInspectionDetails) {
      final date = DateFormat(global.dateFormat).parse(element.getX02);
      final today = DateFormat(global.dateFormat).parse(global.todayString);

      if (date == today &&
          element.getX01 == global.lastSetting.getLine &&
          element.getX03 == global.lastSetting.getStyleCode &&
          element.getX05 == global.lastSetting.getSize &&
          element.getX04 == global.lastSetting.getColor) {
        result = element;
        break;
      }
    }

    return result;
  }

  Future<List<T011stInspectionData>> loadInspectionDataT01() async {
    print('loadInspectionDataT01 ');
    List<T011stInspectionData> output = [];
    List<Map<String, dynamic>> maps;
    try {
      maps = await database.query(tableT011stInspectionData);

      return List.generate(maps.length, (i) {
        return T011stInspectionData.fromMap(maps[i]);
      });
    } catch (e) {
      print('loadInspectionDataT01 Exception : ' + e.toString());
      return [];
    }
  }

  final String queryCreate_T00_Month =
      r'''CREATE TABLE 'T00_Month' (ID INTEGER AUTO INCREMENT PRIMARY KEY ,  Month INTEGER   );''';
  final String queryCreate_T01_1st_inspection_data =
      r'''CREATE TABLE 'T01_1st_inspection_data' 
  (_id INTEGER PRIMARY KEY , 
   '2nd' BOOL, X01 INTEGER, X02 DATETIME default current_timestamp, X03 INTEGER, X04 VARCHAR(20),  X05 VARCHAR(20), X06 INTEGER,  X07 INTEGER,	X08 INTEGER,	X09 INTEGER,	X10 INTEGER,	
   A1 INTEGER, 	A2 INTEGER,	A3	INTEGER,
   B1	INTEGER, B2 INTEGER,	B3	INTEGER,C1	INTEGER,C2	INTEGER,D1	INTEGER,D2	INTEGER,D3 INTEGER,
   D4 INTEGER,	E1 INTEGER,	E2 INTEGER,	E3 INTEGER,	E4 INTEGER,	E5 INTEGER,	E6 INTEGER,	E7 INTEGER,	
   F1 INTEGER,	F2 INTEGER,	F3 INTEGER,	F4 INTEGER,	F5 INTEGER,	F6 INTEGER,	F7 INTEGER,	F8 INTEGER,	F9 INTEGER,	
   G1 INTEGER,	G2 INTEGER,	G3 INTEGER,	H INTEGER,
   XC TEXT,	'Sum A' INTEGER, 	'Sum B' INTEGER,	'Sum C' INTEGER,	'Sum D' INTEGER,	'Sum E' INTEGER,	'Sum F' INTEGER,	'Sum G' INTEGER, 	
   Total INTEGER,	X11 INTEGER,	X12 INTEGER,	'T-Month' INTEGER,	'T-Year' INTEGER,	TF INTEGER, 
   time VARCHAR(20),  isReCheck BOOL, defectNames VARCHAR(128), totalChecked INTEGER
  );''';
  final String queryCreate_T02_Week = r'''c''';
  final String queryCreate_T03_Product_item =
      r'''CREATE TABLE 'T03_Product_item111' (ID INTEGER AUTO INCREMENT PRIMARY KEY ,ID1 INTEGER, X151 VARCHAR(20), 
      X131 VARCHAR(20),X18 VARCHAR(20), X19 VARCHAR(50), X20 INTEGER);''';
  final String queryCreate_T04_Plan_production =
      r''' CREATE TABLE 'T04_Plan_production' (ID INTEGER AUTO INCREMENT PRIMARY KEY,	X021DATETIME default current_timestamp,	X011 INTEGER,	X13	INTEGER, 'T-Year' INTEGER, 'T-Month' INTEGER);''';
  final String queryCreate_T05_Man_power_sewing_time =
      r'''CREATE TABLE 'T05_Man_power_sewing_time' (
  ID INTEGER AUTO INCREMENT PRIMARY KEY, X01 INTERGER, X024 DATETIME default current_timestamp,	
  Mplan INTERGER,	Mact INTERGER,	Madd INTERGER,	OVT INTERGER,	X21 INTERGER, 
  'A-Month' INTERGER,	'A-Year' INTERGER);''';
  final String queryCreate_T06_Color = r'''
''';
  final String queryCreate_T07_Size = r'''
''';
  final String queryCreate_InspectionDetails = r'''
 CREATE TABLE 'InspectionDetails' (id INTEGER AUTO INCREMENT PRIMARY KEY ,time INTEGER, date  DATETIME, line INTERGER, customer VARCHAR(20), style VARCHAR(20),
  styleCode INTERGER, color VARCHAR(20), size VARCHAR(20),  spectionFirstSecond INTEGER, 
  quantity INTERGER, result VARCHAR(20), groupDefect VARCHAR(20), defect VARCHAR(20), comment VARCHAR(50)
  );
''';
  final String queryCreate_LastSetting = '''
    CREATE TABLE 'LastSetting' (secondary  BOOL, line INTERGER, customer VARCHAR(20), style VARCHAR(20),
      styleCode INTERGER, color VARCHAR(20), size VARCHAR(20) 
    );
    ''';
  final String queryCreate_InspectionSummary = r'''
CREATE TABLE 'InspectionSummary' (id INTEGER AUTO INCREMENT PRIMARY KEY ,date  DATETIME, time INTEGER, secondInspection BOOL,  line INTERGER, customer VARCHAR(20), style VARCHAR(20),
  styleCode INTERGER, color VARCHAR(20), size VARCHAR(20),  planToday  INTEGER, actual INTEGER, sumDefect REAL, rationDefect REAL
 );
''';
}
