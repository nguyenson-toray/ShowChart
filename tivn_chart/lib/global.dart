import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/chart/chartProduction.dart';
import 'package:tivn_chart/dataClass/inspectionSetting.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';
import 'package:tivn_chart/dataClass/t02Week.dart';
import 'package:tivn_chart/dataClass/t03ProductionItem.dart';
import 'package:tivn_chart/dataClass/t04PlanProduction.dart';
import 'package:tivn_chart/dataClass/t05MainPowerSewingTime.dart';
import 'package:tivn_chart/dataClass/t06Color.dart';
import 'package:tivn_chart/dataClass/t08Combo.dart';
import 'package:tivn_chart/ui/workSettingWidget.dart';

class global {
  static String currentGroupDefectName = 'Thông số';
  static String comment = '';
  static String commentTotal = '';
  static bool confirmYes = false;
  static late SharedPreferences sharedPreferences;
  static final navigatorKey = GlobalKey<NavigatorState>();
  static int plan = 0;
  static int actual = 0;
  static int sumDefect1 = 0;
  static bool isRecheck = false;
  static bool needUpdateSQL = false;
  static int totalChecked = 0;
  static int qtyInspection1 = 0;
  static int qtyInspectionOK1 = 0;
  static int qtyInspection2 = 0;
  static int qtyInspectionOK2 = 0;
  static int qtyInspectionC = 0;
  static bool isTypeC = false;
  static bool is2ndInspection = false;
  static String result = 'ĐẠT';
  static List<String> results = ['ĐẠT', 'LỖI'];
  static String otherDefect = 'Lỗi khác';
  static String currentDefect = 'Lỗi thông số';
  static String defectTotal = '';
  static var currentDefects = <String>[];
  static double ratioDefect = 0;

  //--------------------
  static ChartProduction chart = ChartProduction();
  static List<ChartProduction> chartData = [];
  static List<ChartProduction> chartDataCompareLine = [];
  static String catalogue = 'day';
  static bool autoChangeLine = false;
  static String screenName = 'Sewing Line';
  static int screenTypeInt = 1;
  static bool showSetting = false;
  static bool isSetting = false;
  static bool isTV = false;
  static bool isFisrtRun = false;
  static String device = 'smartphone';
  static Widget currentScreen = Container();
  static List<int> lines = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  static int currentLine = 1;
  static double screenW = 0;
  static double screenH = 0;
  static double screenWPixel = 0;
  static double screenHPixel = 0;
  static String version = '';
  static bool isLoading = true;
  static int rangeTime = 6;
  static int rangeDaySQL = 365;
  static late DateTime beginDate;
  static int pageIndex = 0;
  static late String dbPath;
  static var mySqlServer = MySqlServer();
  static var mySqlife = MySqLite();
  static T011stInspectionData t01 = T011stInspectionData();
  static List<T011stInspectionData> t01s = [];
  static List<T011stInspectionData> t01sLocal = <T011stInspectionData>[];
  static List<T011stInspectionData> t01sFilteredByInspectionSetting =
      <T011stInspectionData>[];
  static T011stInspectionData t01SummaryByInspectionSetting =
      T011stInspectionData();
  static List<T02Week> t02s = [];
  static List<T03ProductionItem> t03s = [];
  static List<T04PlanProduction> t04s = [];
  static List<T05MainPowerSewingTime> t05s = [];
  static List<T06Color> t06s = [];
  // static List<T07> t07s = [];

  static List<T08Combo> t08s = [];
  static late InspectionSetting inspectionSetting;
  static int secondsAutoGetData = 60;
  static int secondsAutoUpdateDataToSQL = 30;
  static int secondsAutoChangeLine = 120;
  static var planToday = 9999;
  static var actualToday = 0;
  static var sumDefect = 0;
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
      Radius.circular(7),
    ),
    color: Colors.blueGrey,
    gradient: LinearGradient(
        colors: [Colors.red, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 176, 250, 233),
        offset: Offset(10, 20),
        blurRadius: 70,
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
  static var groupDefectParameter = <String>[
    'Lỗi thông số',
    'Lệch trái phải',
    'Thông số  kéo căng',
  ];
  static var groupDefectAccessories = <String>[
    'Dây kéo',
    'Nút',
    'Khác',
  ];
  static var groupDefectDanger = <String>[
    'Bavia Gờ sắc nhọn',
    'Dị vật',
  ];
  static var groupDefectFabric = <String>[
    'Khác màu, nhuộm',
    'Sợi màu',
    'Vón cục, nút thắt',
    'Lỗi vải khác',
  ];
  static var groupDefectSewingKnitting = <String>[
    'May, đứt chỉ',
    'Bung tưa, lỏng chỉ',
    'Lỗ kim',
    'Bỏ mũi, sụp mí',
    'May vặn',
    'Xước sợi, rút sợi',
    'Bọ',
  ];
  static var groupDefectAppearenceFinished = <String>[
    'Chỉ lượt, sót chỉ',
    'Dơ',
    'Dấu phấn',
    'In, ép',
    'Biến dạng',
    'Nhăn',
    'Cấn bóng',
    'Le mí',
    'Seam',
  ];
  static var groupDefectMaterial = <String>[
    'Thẻ bài',
    'Nhãn giặt',
    'Nhãn khác',
  ];
  static var groupDefectOther = <String>['Lỗi khác'];
  static Map<String, List<int>> defectQtys = {
    "Thông số": [0, 0, 0],
    "Phụ liệu": [0, 0, 0],
    "Nguy hiểm": [0, 0],
    "Vải": [0, 0, 0, 0],
    "Lỗi may đan": [0, 0, 0, 0, 0, 0, 0],
    "Ngoại quan, thành phẩm": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "Vật liệu": [0, 0, 0],
    "Lỗi khác": [0]
  };
  static Map<String, List<String>> defectCmts = {
    "Thông số": ['', '', ''],
    "Phụ liệu": ['', '', ''],
    "Nguy hiểm": ['', ''],
    "Vải": ['', '', '', ''],
    "Lỗi may đan": ['', '', '', '', '', '', ''],
    "Ngoại quan, thành phẩm": ['', '', '', '', '', '', '', '', ''],
    "Vật liệu": ['', '', ''],
    "Lỗi khác": ['']
  };

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

  static List<String> ipsTVSewingLine = [
    '192.168.1.71',
    '192.168.1.72',
    '192.168.1.73',
    '192.168.1.74',
    '192.168.1.75',
    '192.168.1.76',
    '192.168.1.77',
    '192.168.1.78',
    '192.168.1.79'
  ];
}
