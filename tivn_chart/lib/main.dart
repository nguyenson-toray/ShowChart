import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';
import 'package:tivn_chart/ui/startPage.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:ui';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  global.sharedPreferences = await SharedPreferences.getInstance();
  if (global.sharedPreferences.getInt("currentLine") == null) {
    global.sharedPreferences.setInt('currentLine', 1);
    global.currentLine = 1;
  } else
    global.currentLine = global.sharedPreferences.getInt("currentLine")!;
  if (global.sharedPreferences.getBool("showDashboard") == null) {
    global.sharedPreferences.setBool('showDashboard', false);
    global.showDashboard = false;
  } else
    global.showDashboard = global.sharedPreferences.getBool("showDashboard")!;

  if (global.sharedPreferences.getBool("autoChangeLine") == null) {
    global.sharedPreferences.setBool('autoChangeLine', false);
    global.autoChangeLine = false;
  } else
    global.autoChangeLine = global.sharedPreferences.getBool("autoChangeLine")!;

  var pixelRatio = window.devicePixelRatio;

  //Size in physical pixels
  var physicalScreenSize = window.physicalSize;
  global.screenW = physicalScreenSize.width;
  global.screenH = physicalScreenSize.height;
//Size in logical pixels
  var logicalScreenSize = window.physicalSize / pixelRatio;
  global.screenWPixel = logicalScreenSize.width;
  global.screenHPixel = logicalScreenSize.height;
  print('screenW : ' + global.screenW.toString());
  print('screenH : ' + global.screenH.toString());
  print('screenWPixel : ' + global.screenWPixel.toString());
  print('screenHPixel : ' + global.screenHPixel.toString());

  runApp(const MyApp());
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
