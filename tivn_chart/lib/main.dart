import 'dart:io';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:tivn_chart/ui/inputInspectionPage.dart';
import 'package:tivn_chart/ui/qcPage.dart';
import 'package:tivn_chart/ui/start.dart';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('en');
  await getsharedPreferences();
  await detectDeviceInfo();

  if (!global.isTV) await initDataSqLite();
  // -------------for test in debug mode
  if (kDebugMode) {
    global.isTV = true;
    // global.rangeTime = 14;
    global.device = 'TVControl';
    // if (androidInfo.model == 'AOSP TV on x86') {
    // global.device = 'TVLine';
    // global.isTV = true;
    // global.rangeTime = 14;
    // global.sharedPreferences.setInt('rangeTime', global.rangeTime);
    // global.autoChangeLine = false;
    // }
  }

  //-----------
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  global.version = packageInfo.version;
  global.todayString = DateFormat(global.dateFormat).format(
    global.today,
  );
  runApp(new MyApp());
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft // DeviceOrientation.portraitUp
  // ]).then((_) async {
  //   runApp(new MyApp());
  // });
}

initDataSqLite() async {
  global.todayString = DateFormat(global.dateFormat).format(
    global.today,
  );
  global.mySqlife = MySqLite();
  const String firstRun = 'firstRun';
  global.sharedPreferences = await SharedPreferences.getInstance();
  if (global.sharedPreferences.getBool(firstRun) == null) {
    global.sharedPreferences.setBool(firstRun, true);
    global.isFisrtRun = true;
  }
  global.isFisrtRun
      ? await global.mySqlife.createDB()
      : await global.mySqlife.openDB();
  var inspectionSettings = await global.mySqlife.LoadInspectionSetting();
  inspectionSettings.forEach((element) {
    print('inspectionSetting : ' + inspectionSettings.toString());
  });
  if (inspectionSettings.length > 0) {
    global.inspectionSetting = inspectionSettings.last;
  }
  global.t01sLocal = await global.mySqlife.loadInspectionDataT01();
}

Future<void> getsharedPreferences() async {
  global.sharedPreferences = await SharedPreferences.getInstance();
  if (global.sharedPreferences.getInt("currentLine") == null) {
    global.sharedPreferences.setInt('currentLine', 1);
    global.currentLine = 1;
  } else
    global.currentLine = global.sharedPreferences.getInt("currentLine")!;

  if (global.sharedPreferences.getInt("screenTypeInt") == null) {
    global.sharedPreferences.setInt('screenTypeInt', 1);
    global.screenTypeInt = 1;
  } else
    global.screenTypeInt = global.sharedPreferences.getInt("screenTypeInt")!;
  // global.screenTypeInt = 0;
  if (global.sharedPreferences.getBool("autoChangeLine") == null) {
    global.sharedPreferences.setBool('autoChangeLine', false);
    global.autoChangeLine = false;
  } else
    global.autoChangeLine = global.sharedPreferences.getBool("autoChangeLine")!;

  if (global.sharedPreferences.getString('catalogue') == null) {
    global.sharedPreferences.setString('catalogue', 'day');
    global.catalogue = 'day';
  } else
    global.catalogue = global.sharedPreferences.getString('catalogue')!;

  if (global.sharedPreferences.getInt("rangeTime") == null) {
    global.sharedPreferences.setInt('rangeTime', 6);
    global.rangeTime = 6;
  } else
    global.rangeTime = global.sharedPreferences.getInt("rangeTime")!;

  if (global.sharedPreferences.getInt("inspection12") == null) {
    global.sharedPreferences.setInt('inspection12', 1);
    global.inspection12 = 1;
  } else
    global.inspection12 = global.sharedPreferences.getInt("inspection12")!;
}

Future<void> detectDeviceInfo() async {
  var pixelRatio = window.devicePixelRatio;
  //Size in physical pixels
  var physicalScreenSize = window.physicalSize;
  global.screenW = physicalScreenSize.width;
  global.screenH = physicalScreenSize.height;
//Size in logical pixels
  var logicalScreenSize = window.physicalSize / pixelRatio;
  global.screenWPixel = logicalScreenSize.width;
  // global.screenWPixel = MediaQuery.of(context).size.width;
  global.screenHPixel = logicalScreenSize.height;
  // global.screenHPixel = MediaQuery.of(context).size.height;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('screenW : ' + global.screenW.toString());
  print('screenH : ' + global.screenH.toString());
  print('screenWPixel : ' + global.screenWPixel.toString());
  print('screenHPixel : ' + global.screenHPixel.toString());
  print('manufacturer   ${androidInfo.manufacturer}');
  print('model  ${androidInfo.model}');
  print('product   ${androidInfo.product}');
  print('sizeInches   ${androidInfo.displayMetrics.sizeInches}');
  print('heightInches   ${androidInfo.displayMetrics.heightInches}');
  print('widthInches   ${androidInfo.displayMetrics.widthInches}');
  print('supportedAbis   ${androidInfo.supportedAbis.toString()}');

  final wifiIP = await NetworkInfo().getWifiIP();

  if (androidInfo.displayMetrics.sizeInches > 49) {
    global.isTV = true;
    if (global.ipsTVSewingLine.contains(wifiIP)) {
      global.device = 'TVLine';
      global.rangeTime = 14;
      global.sharedPreferences.setInt('rangeTime', global.rangeTime);
      global.autoChangeLine = false;
    } else
      global.device = 'TVControl';
  } else {
    global.isTV = false;
    global.device = 'smartphone';
  }
  print('wifiIP : ' + wifiIP!);
  print('device : ' + global.device);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void dispose() {
    global.mySqlife.closeDB();
    super.dispose();
  }

  @override
  initState() {
    //do some thing
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: MaterialApp(
          title: 'TIVN-QN',
          // onGenerateRoute: initialSlideRoutes,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StartPage(),
          navigatorKey: global.navigatorKey,
          initialRoute: '/',
          routes: {
            '': (context) => const StartPage(),
            '/QcPage': (context) => QcPage(),
            '/InputInspectionPage': (context) =>
                InputInspectionPage(callback: refresh),
            // '/ErrorPage': (context) => const ErrorPage(), // Dashboard(),
          }),
    );
  }

  refresh(List<T011stInspectionData> param) {
    setState(() {});
  }
}
