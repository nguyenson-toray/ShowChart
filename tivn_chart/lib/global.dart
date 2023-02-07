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
  static late ChartQtyRate chartLine;
  static late List<ChartQtyRate> chartLineData = [];

  static late ChartGroupAll chartGroupAll;
  static late List<ChartGroupAll> chartGroupAllData = [];

  static late ChartGroupF chartGroupF;
  static late List<ChartGroupF> chartGroupFData = [];

  static late ChartGroupE chartGroupE;
  static late List<ChartGroupE> chartGroupEData = [];

  static late ChartGroupH chartGroupH;
  static late List<ChartGroupH> chartGroupHData = [];

  static String catalogue = 'daily';
  // static bool showDashboard = false;
  static bool autoChangeLine = false;
  static String dashboardType = 'sewing';
  static bool showSetting = false;

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
  static String dbNameSQL = 'Production';
  static String dbNameSQLite = 'toray.db';
  static late String dbPath;
  static var mySqlServer = MySqlServer();
  static var mySqlife = MySqLite();
  static T011stInspectionData t01 = T011stInspectionData();
  static List<T011stInspectionData> t01s = [];
  static int secondsAutoGetData = 6000;
  static int secondsAutoChangeLine = 15;
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
