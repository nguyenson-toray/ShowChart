import 'dart:io';

import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
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
  final String dbNameSQL = 'Production';
  final user = 'production';
  final pass = 'Toray@123';
  final String instanceSql = 'MSSQLSERVER';
  final String tableT011stInspectionData = '[T01_1st inspection data]';
  Future<bool> checkConnection() async {
    var isConnected = false;
    Socket.connect('$ipLAN', port, timeout: Duration(seconds: 3))
        .then((socket) {
      // do what need to be done
      print('Connection to IP LAN : $ipLAN:$port OK');
      lanConnectionAvailable = true;
      print('socket : ' + socket.toString());
      // Don't forget to close socket
      socket.destroy();
    }).catchError((error) {
      lanConnectionAvailable = false;
      print(
          'Connection to IP LAN : $ipLAN NOT OK . Try to connect ip WAN : $ipWAN');
      print(error.toString());
    });
    try {
      isConnected = await connection.initializeConnection(
        lanConnectionAvailable ? ipLAN : ipWAN,
        dbNameSQL,
        user,
        pass,
        instance: instanceSql,
      );
      if (!isConnected) MyFuntions.showToastNoConnection();
    } catch (e) {
      print(e.toString());
      MyFuntions.showToastNoConnection();
    }
    return isConnected;
  }

  Future<List<T011stInspectionData>> getInspectionData(int rangeDays) async {
    print('getInspectionData : ' + "- rangeDays : " + rangeDays.toString());
    List<T011stInspectionData> data = [];
    List<T011stInspectionData> result = [];
    List<Map<String, dynamic>> tempResult = [];
    late DateTime beginDate;
    beginDate = global.today.subtract(Duration(days: rangeDays));
    late DateTime day;
    final String query = '''select * from $tableT011stInspectionData''';
    var isConnected = false;
    try {
      // isConnected = await connection.initializeConnection(
      //   ip,
      //   dbNameSQL,
      //   user,
      //   pass,
      //   instance: instanceSql,
      // );
      if (true) {
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
                          print(
                              'Get Inspection data from ${DateFormat(global.dateFormat).format(
                            beginDate,
                          )} to today !!!'),
                          result.add(rowData),
                        }
                    }
                }
            });
      }
    } catch (e) {
      print('getInspectionData --> Exception : ' + e.toString());
    }
    return result;
  }
}
