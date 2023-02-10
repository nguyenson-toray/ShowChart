import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/chart/chartProduction.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';

class global {
  static ChartProduction chart = ChartProduction();
  static List<ChartProduction> chartData = [];
  static List<ChartProduction> chartDataCompareLine = [];
  static String catalogue = 'day';
  // static bool showDashboard = false;
  static bool autoChangeLine = false;
  // static String dashboardType = 'sewing';
  static String screenName = 'Sewing Line';
  static int screenTypeInt = 0;
  static bool showSetting = false;
  static bool isSetting = false;
  static bool isTV = true;
  static Widget currentScreen = Container();

  static int currentLine = 0;
  static double screenW = 0;
  static double screenH = 0;
  static double screenWPixel = 0;
  static double screenHPixel = 0;
  static String version = '';
  static bool isLoading = true;
  static int rangeTime = 6;
  static int rangeDaySQL = 365;
  static late DateTime beginDate;
  static late SharedPreferences sharedPreferences;
  static int pageIndex = 0;
  static late String dbPath;
  static var mySqlServer = MySqlServer();
  static var mySqlife = MySqLite();
  static T011stInspectionData t01 = T011stInspectionData();
  static List<T011stInspectionData> t01s = [];
  static int secondsAutoGetData = 600;
  static int secondsAutoChangeLine = 60;
  static var planToday = 9999;
  static var actualToday = 0;
  static var sumDefect = 0;

  static double ratioDefect = 0;
  static DateTime today = DateTime.now();
  static DateTime dayFilerBegin = DateTime.now();
  static DateTime dayFilerEnd = DateTime.now();
  static late String todayString;
  static final String dateFormat = 'yyyy-MM-dd';
  static int inspection12 = 1;
  static int selectedIndex = 0;
  static late Directory documentsDirectory;
  static BoxDecoration myBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
    color: Colors.blueGrey,
    gradient: LinearGradient(
        colors: [Colors.amber, Color.fromARGB(255, 171, 218, 241)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 176, 250, 233),
        offset: Offset(10, 20),
        blurRadius: 30,
      )
    ],
  );
  static var listGroupDefect = <String>[
    'Thông số',
    'Phụ liệu',
    'Nguy hiểm',
    'Vải',
    'Lỗi may đan',
    'Ngoại quan, thành phẩm',
    'Vật liệu',
    'Lỗi khác'
  ];
  static var listGroupDefectJP = <String>[
    '寸　法',
    '付　属',
    '危険性',
    '生　地',
    '縫製・編立',
    '外観・仕上',
    '資材/そ',
    'の他'
  ];
  static Map<String, List<String>> defectNames = {
    "Thông số": ["Lỗi thông số", "Lệch trái phải", "Thông số  kéo căng"],
    "Phụ liệu": ["Dây kéo", "Nút", "Khác"],
    "Nguy hiểm": ["Bavia Gờ sắc nhọn", "Dị vật"],
    "Vải": ["Khác màu, nhuộm", "Sợi màu", "Vón cục, nút thắt", "Lỗi vải khác"],
    "Lỗi may đan": [
      "May, đứt chỉ",
      "Bung tưa, lỏng chỉ",
      "Lỗ kim",
      "Bỏ mũi, sụp mí",
      "May vặn",
      "Xước sợi, rút sợi",
      "Bọ"
    ],
    "Ngoại quan, thành phẩm": [
      "Chỉ lượt, sót chỉ",
      "Dơ",
      "Dấu phấn",
      "In, ép",
      "Biến dạng",
      "Nhăn",
      "Cấn bóng",
      "Le mí",
      "Seam"
    ],
    "Vật liệu": ["Thẻ bài", "Nhãn giặt", "Nhãn khác"],
    "Lỗi khác": ["Lỗi khác"]
  };
  static Map<String, List<String>> defectNamesJP = {
    "Thông số": ["寸法不良", "左右違い", "機能寸法"],
    "Phụ liệu": ["ファスナー", "ボタン", "その他1"],
    "Nguy hiểm": ["バリ", "異物"],
    "Vải": ["色差染色", "異原糸混入", "異原糸混入", "その他2"],
    "Lỗi may đan": ["縫い", "ほつれ", "針孔", "目飛び目落ち", "つれ", "糸引き", "カン止"],
    "Ngoại quan, thành phẩm": [
      "糸始末",
      "汚れ",
      "チャコ跡",
      "プリント接着",
      "形状不良",
      "シワ",
      "アタリ",
      "吹き出し",
      "シームテープ"
    ],
    "Vật liệu": ["下げ札", "洗濯ネーム", "ネーム"],
    "Lỗi khác": ["その他3"]
  };
}
