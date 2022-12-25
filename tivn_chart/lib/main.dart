import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';
import 'package:tivn_chart/ui/startPage.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  global.sharedPreferences = await SharedPreferences.getInstance();
  if (global.sharedPreferences.getInt("currentLine") == null) {
    global.sharedPreferences.setInt('currentLine', 1);
    global.currentLine = 1;
  }

  global.currentLine = global.sharedPreferences.getInt("currentLine")!;
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
        home: Start(), //Display splash screen when Start app
      ),
    );
  }
}
