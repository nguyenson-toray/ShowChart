import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/chart/chartGroupAll.dart';
import 'package:tivn_chart/chart/chartGroupE.dart';
import 'package:tivn_chart/chart/chartGroupF.dart';
import 'package:tivn_chart/chart/chartGroupH.dart';
import 'package:tivn_chart/chart/chartQtyRate.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';

class global {
  static late ChartQtyRate chartQtyRate;
  static late List<ChartQtyRate> chartQtyRateData = [];

  static late ChartGroupAll chartGroupAll;
  static late List<ChartGroupAll> chartGroupAllData = [];

  static late ChartGroupF chartGroupF;
  static late List<ChartGroupF> chartGroupFData = [];

  static late ChartGroupE chartGroupE;
  static late List<ChartGroupE> chartGroupEData = [];

  static late ChartGroupH chartGroupH;
  static late List<ChartGroupH> chartGroupHData = [];

  static String periodType = 'daily';
  static bool showDashboard = false;
  static bool autoChangeLine = false;
  static int currentLine = 1;
  static double screenW = 0;
  static double screenH = 0;
  static double screenWPixel = 0;
  static double screenHPixel = 0;
  static String version = '';
  static bool isLoading = true;
  static int rangeDays = 14;
  static late DateTime beginDate;
  static late SharedPreferences sharedPreferences;
  // static late List<InspectionChartData> inspectionChartData;
  static int pageIndex = 0;
  static String dbNameSQL = 'Production';
  static String dbNameSQLite = 'toray.db';
  static late String dbPath;
  static var mySqlServer = MySqlServer();
  static var mySqlife = MySqLite();
  static T011stInspectionData t01 = T011stInspectionData();
  static List<T011stInspectionData> t01s = [];
  // static var inspectionSummaryDay = InspectionSummaryDay();
  // static List<InspectionSummaryDay> inspectionSummaryDays = [];

  static int secondsAutoGetData = 60;
  static int secondsAutoChangeLine = 60;
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
}
