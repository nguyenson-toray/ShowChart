import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';
import 'package:tivn_chart/ui/startPage.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
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

  var pixelRatio = window.devicePixelRatio;

  //Size in physical pixels
  var physicalScreenSize = window.physicalSize;
  global.screenW = physicalScreenSize.width;
  global.screenH = physicalScreenSize.height;
//Size in logical pixels
  var logicalScreenSize = window.physicalSize / pixelRatio;
  global.screenWPixel = logicalScreenSize.width;
  global.screenHPixel = logicalScreenSize.height;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('screenW : ' + global.screenW.toString());
  print('screenH : ' + global.screenH.toString());
  print('screenWPixel : ' + global.screenWPixel.toString());
  print('screscreenHPixelenW : ' + global.screenHPixel.toString());
  print('manufacturer   ${androidInfo.manufacturer}');
  print('model  ${androidInfo.model}');
  print('product   ${androidInfo.product}');
  print('display   ${androidInfo.display}');
  print('brand   ${androidInfo.brand}');
  print('device   ${androidInfo.device}');
  print('supportedAbis   ${androidInfo.supportedAbis.toString()}');
  global.isTV = androidInfo.manufacturer.contains('tcl') ||
      androidInfo.manufacturer.contains('TCL');

  SystemChrome.setPreferredOrientations([
    global.isTV ? DeviceOrientation.landscapeLeft : DeviceOrientation.portraitUp
  ]).then((_) {
    runApp(new MyApp());
  });
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
    WidgetsFlutterBinding.ensureInitialized();
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
        home: Start(), // Dashboard(),
      ),
    );
  }
}
