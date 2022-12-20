import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tivn_chart/inspectionChartData.dart';
import 'package:tivn_chart/dataClass/InspectionSummaryDay.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:path/path.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';
import 'package:tivn_chart/dataFuntion/chartFuntion.dart';
import 'package:tivn_chart/ui/chart.dart';

class global {
  static bool isLoading = true;
  static int rangeDays = 14;
  static late DateTime beginDate;
  static late SharedPreferences sharedPreferences;
  static int currentLine = 1;
  static late List<InspectionChartData> inspectionChartData;
  static ChartFuntion chartFuntion = ChartFuntion();
  static int pageIndex = 0;
  static String dbNameSQL = 'test';
  static String dbNameSQLite = 'toray.db';
  static late String dbPath;
  static var mySqlServer = MySqlServer();
  static var mySqlife = MySqLite();
  static T011stInspectionData t01 = T011stInspectionData();
  static List<T011stInspectionData> t01s = [];
  static var inspectionSummaryDay = InspectionSummaryDay();
  static List<InspectionSummaryDay> inspectionSummaryDays = [];

  static int secondsAutoGetData = 15;
  static var planToday = 9999;
  static var actualToday = 0;
  static var sumDefect = 0;

  static double ratioDefect = 0;
  static DateTime today = DateTime.now();
  static late String todayString;
  static final String dateFormat = 'yyyy-MM-dd';
  static int inspection12 = 1;
  static int selectedIndex = 0;
  static late Directory documentsDirectory;
}
