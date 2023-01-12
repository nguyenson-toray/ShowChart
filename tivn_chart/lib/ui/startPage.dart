// import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tivn_chart/global.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/ui/chart.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';
import 'package:flutter/foundation.dart';

import '../dataFuntion/myFuntions.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {
  var isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          // decoration: new BoxDecoration(
          //     gradient: new LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color.fromARGB(255, 127, 215, 250),
          //     Color.fromARGB(255, 81, 117, 247)
          //   ],
          // )),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(height: 100, child: Image.asset('assets/logo.png')),
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Center(
                    child: SizedBox(
                      height: 15,
                      child:
                          isLoading ? LinearProgressIndicator() : Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    global.version = packageInfo.version;
    global.todayString = DateFormat(global.dateFormat).format(
      global.today,
    );
    var isConnected = await global.mySqlServer.checkConnection();
    if (isConnected) {
      await global.mySqlServer
          .selectAllTable01InspectionData()
          .then((value) => setState(() {
                global.t01s = value;
                if (value.length > 0) {
                  isLoading = false;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Chart()),
                  );
                }
              }));
    } else {
      print("SQL Server not available -Load offline data");
      MyFuntions.showToastNoConnection();
    }
  }
}
