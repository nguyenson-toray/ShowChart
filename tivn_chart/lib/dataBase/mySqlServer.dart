import 'dart:io';
import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:tivn_chart/dataClass/inspectionSetting.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataClass/t03ProductionItem.dart';
import 'package:tivn_chart/dataClass/t04PlanProduction.dart';
import 'package:tivn_chart/dataClass/t06Color.dart';
import 'package:tivn_chart/dataClass/t08Combo.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class MySqlServer {
  bool isLoading = false;
  var connection = ConnectToSqlServerDirectly();
  final String ipLAN = '192.168.1.11';
  final String ipWAN = '103.17.90.89';
  int port = 1433;
  bool lanConnectionAvailable = false;
  // final String dbNameSQL = 'test';
  // final user = 'production';
  final String dbNameSQL = 'Production';
  final user = 'app';
  final pass = 'Toray@123';
  final String instanceSql = 'MSSQLSERVER';
  final String tableT011stInspectionData = '[T01_1st inspection data]';
  final String tableT00Trans = '[T00_Trans]';
  final String tableT02Trans = '[T02_Week]';
  final String table03ProductionItem = '[T03_Product Item]';
  final String table04PlanProduction = '[T04_Plan production]';
  final String table05ManPowerSewingTime = '[T05_Man_power_sewing_time]';
  final String table06Color = '[T06_Color]';
  final String table07ReceivedOrder = '[T07 Received order]';
  final String table08Combo = '[T08_Combo]';
  final String table09Translation = '[T09_Translation]';
  final String table10OrderAssort = '[T10 Order assort]';
  Future<bool> checkConnection() async {
    var isConnected = false;
    await Socket.connect('$ipLAN', port, timeout: Duration(seconds: 3))
        .then((socket) {
      // do what need to be done
      print('Connection to IP LAN : $ipLAN:$port OK');
      lanConnectionAvailable = true;
      // Don't forget to close socket
      socket.destroy();
    }).catchError((error) {
      lanConnectionAvailable = false;
      print(
          'Connection to IP LAN : $ipLAN NOT OK . Try to connect ip WAN : $ipWAN');
      print(error.toString());
    });
    var ip = lanConnectionAvailable ? ipLAN : ipWAN;
    try {
      isConnected = await connection.initializeConnection(
        ip,
        dbNameSQL,
        user,
        pass,
        instance: instanceSql,
      );
      if (!isConnected) MyFuntions.showToastNoConnection();
    } catch (e) {
      print('initializeConnection - $ip FAILSE :' + e.toString());
      MyFuntions.showToastNoConnection();
    }
    return isConnected;
  }

  Future<void> getAllDataFromServer() async {
    print('==========getAllDataFromServer=============');

    try {
      global.t01s = await global.mySqlServer
          .selectTable01InspectionData(global.rangeDaySQL);
      global.t03s = await global.mySqlServer.selectAllTable03ProductionItem();
      global.t04s = await global.mySqlServer.selectAllTable04PlanProduction();
      global.t06s = await global.mySqlServer.selectAllTable06Color();
      global.t08s = await global.mySqlServer.selectAllTable08Combo();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<T011stInspectionData>> selectTable01InspectionData(
      int rangeDays) async {
    List<T011stInspectionData> result = [];
    List<Map<String, dynamic>> tempResult = [];
    late DateTime beginDate;
    beginDate = DateTime.now().subtract(Duration(days: rangeDays));
    late DateTime day;
    final String query = '''select * from $tableT011stInspectionData''';
    var isConnected = false;
    print(
        'select Table 01InspectionData   ( ${rangeDays.toString()} days : from ${DateFormat(global.dateFormat).format(
      beginDate,
    )} to today !!!');
    try {
      var rowData;
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('Query : $query => ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    rowData = T011stInspectionData.fromMap(element),
                    day = DateTime.parse(rowData.getX02.toString()),
                    if (day.isAfter(beginDate))
                      {
                        result.add(rowData),
                      }
                  }
              }
          });
    } catch (e) {
      print('getInspectionData --> Exception : ' + e.toString());
    }
    return result;
  }

  Future<bool> deleteRow(
    InspectionSetting input,
  ) async {
    String queryDeleteRowSQL = '';
    bool result = false;
    var date = global.todayString;
    if (date == '') return false;
    DateTime date_standard = DateFormat('yyyy-MM-dd', 'en').parse(date);
    queryDeleteRowSQL = ''' DELETE FROM $tableT011stInspectionData
        WHERE  (X02 ='${date}' and [2nd]= ${input.getInspectionType} and X01 =${input.getLine} and X03 = ${input.getStyleCode} and X04 = '${input.getColor}' and X05 = '${input.getSize}' 
      );''';

    var isConnected = false;
    try {
      result = await connection.getStatusOfQueryResult(queryDeleteRowSQL);
    } catch (e) {
      print(e.toString());
    }
    print('deleteRowSQL => ${result.toString()}');
    return result;
  }

  Future<bool> updateInspectionDataToT01(
    T011stInspectionData input,
  ) async {
    print('updateInspectionDataToT01 - input : ${input.toString()}');

    String queryInsert = '';
    String queryDeleteRow = '';
    bool result = false;
    var date = input.getX02;
    if (date == '') return false;
    DateTime date_standard = DateFormat('yyyy-MM-dd', 'en').parse(date);
    queryInsert = '''INSERT INTO ${tableT011stInspectionData} 
          ([2nd], X01,X02,X03,X04,X05,X06,X07,X08,X09,X10,
          A1,A2,A3,B1,B2,B3,C1,C2,
          D1,D2,D3,D4,
          E1,E2,E3,E4,E5,E6,E7,
          F1,F2,F3,F4,F5,F6,F7,F8,F9,
          G1,G2,G3,H,XC,	
          [Sum A],[Sum B],[Sum C],[Sum D],[Sum E],[Sum F],[Sum G],
          Total,X11,X12,[T-Month],[T-Year],TF) 
        VALUES(${input.getInspectionType}, ${input.getX01}, '${date_standard}', ${input.getX03}, '${input.getX04}', '${input.getX05}', ${input.getX06}, ${input.getX07}, ${input.getX08}, ${input.getX09}, ${input.getX10},
          ${input.getA1},	${input.getA2},	${input.getA3},	${input.getB1},	${input.getB2},	${input.getB3},	${input.getC1},	${input.getC2},	
          ${input.getD1},	${input.getD2},	${input.getD3},	${input.getD4},	
          ${input.getE1},	${input.getE2},	${input.getE3},	${input.getE4},	${input.getE5},	${input.getE6},	${input.getE7},
          ${input.getF1},	${input.getF2},	${input.getF3},	${input.getF4}, ${input.getF5},	${input.getF6},${input.getF7}, ${input.getF8}, ${input.getF9},	
          ${input.getG1},	${input.getG2},	${input.getG3},	${input.getH}, '${input.getXc}',	
          ${input.getSumA},	${input.getSumB},	${input.getSumC},	${input.getSumD},	${input.getSumE},	${input.getSumF},	${input.getSumG},	
          ${input.getTotal}, ${input.getX11},	${input.getX12}, ${input.getTMonth}, ${input.getTYear}, ${input.getTF}
        );''';
    queryDeleteRow = ''' DELETE FROM $tableT011stInspectionData
        WHERE  (X02 ='${date}' and [2nd]= ${input.getInspectionType} and X01 =${input.getX01} and X03 = ${input.getX03} and X04 = '${input.getX04}' and X05 = '${input.getX05}' 
      );''';

    var isConnected = false;
    try {
      await connection
          .getStatusOfQueryResult(queryDeleteRow)
          .then((value) => print('queryDeleteRow => ${value.toString()}'));

      result = await connection.getStatusOfQueryResult(queryInsert);
    } catch (e) {
      print(e.toString());
    }
    print('queryInsert => ${result.toString()}');
    return result;
  }

  Future<List<T03ProductionItem>> selectAllTable03ProductionItem() async {
    List<T03ProductionItem> result = [];
    final String query = 'select * from $table03ProductionItem';
    print('selectAllTable03ProductionItem : ' + query);
    // print('selectAllTable03ProductionItem : $query');
    List<Map<String, dynamic>> tempResult = [];
    var isConnected = false;
    try {
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('Query : $query => ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {
                    result.add(T03ProductionItem.fromMap(element)),
                  }
              }
          });
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<T04PlanProduction>> selectAllTable04PlanProduction() async {
    List<T04PlanProduction> result = [];
    List<Map<String, dynamic>> tempResult = [];
    final String query = '''select * from $table04PlanProduction''';
    print('selectAllTable04PlanProduction : $query');
    var isConnected = false;
    try {
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('Query : $query => ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {result.add(T04PlanProduction.fromMap(element))}
              }
          });
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<T06Color>> selectAllTable06Color() async {
    List<T06Color> result = [];
    List<Map<String, dynamic>> tempResult = [];
    final String query = '''select * from $table06Color''';
    print('selectAllTable06Color : $query');
    var isConnected = false;
    try {
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('Query : $query => ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {result.add(T06Color.fromMap(element))}
              }
          });
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<T08Combo>> selectAllTable08Combo() async {
    List<T08Combo> result = [];
    List<Map<String, dynamic>> tempResult = [];
    final String query = '''select * from $table08Combo''';
    print('selectAllTable08Combo : $query');
    var isConnected = false;
    try {
      await connection.getRowsOfQueryResult(query).then((value) => {
            if (value.runtimeType == String)
              {print('Query : $query => ERROR ')}
            else
              {
                tempResult = value.cast<Map<String, dynamic>>(),
                for (var element in tempResult)
                  {result.add(T08Combo.fromMap(element))}
              }
          });
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
