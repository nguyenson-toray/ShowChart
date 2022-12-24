import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tivn_chart/dataBase/MySQLite.dart';
import 'package:tivn_chart/dataClass/InspectionSummaryDay.dart';
import 'package:tivn_chart/global.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';
import 'dart:convert';

class MyFuntions {
  static Future<bool> loginInitData() async {
    var isConnected = await global.mySqlServer.checkConnection();
    if (isConnected)
      await global.mySqlServer.getTable01InspectionData();
    else {
      print("SQL Server not available -Load offline data");
    }

    global.inspectionSummaryDays =
        await global.mySqlife.loadInspectionSummaryDay();

    return true;
  }

  static showToastNoConnection() {
    Fluttertoast.showToast(
        msg: "Không có kết nối tới máy chủ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
