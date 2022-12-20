import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  static removeDuplicateListString(List<String> inputListString) {
    // remove duplicate item in list String
    var seen = Set<String>();
    List<String> listUniqueString =
        inputListString.where((item) => seen.add(item)).toList();

    return listUniqueString;
  }

  static removeDuplicateListInt(List<int> inputListInt) {
    // remove duplicate item in list int
    var seen = Set<String>();
    var seenint = Set<String>();
    List<int> listUniqueInt =
        inputListInt.where((item) => seen.add(item.toString())).toList();
    return listUniqueInt;
  }
}
