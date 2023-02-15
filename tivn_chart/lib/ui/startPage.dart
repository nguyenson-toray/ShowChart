import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:tivn_chart/ui/dashboard.dart';
import 'package:tivn_chart/ui/lineChart.dart';
import 'package:tivn_chart/ui/qcPage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPagetState();
}

class _StartPagetState extends State<StartPage> {
  double logoH = 30;
  double buttonH = 80;
  double buttonW = 280;
  bool isLoaded = false;
  String functionSellected = '';
  bool loadedAll = false;
  bool loaded1 = false;
  bool loaded2 = false;
  bool loaded3 = false;
  bool loaded4 = false;
  bool loaded5 = false;
  bool loaded6 = false;
  bool loaded7 = false;
  bool loaded8 = false;
  var myTextStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    global.isTV ? logoH = 100 : logoH = 50;
    Timer(Duration(milliseconds: 500), () {
      print("initState - initData after 500 milliseconds");
      initData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: global.device.contains('TV')
                ? showloaded()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: logoH,
                        ),
                        SizedBox(
                            height: logoH,
                            child: Image.asset('assets/logo.png')),
                        SizedBox(
                          height: logoH * 3,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                            // decoration: global.myBoxDecoration,
                            height: buttonH,
                            width: buttonW,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueAccent)),
                                icon: Icon(
                                  Icons.dashboard,
                                  size: 40,
                                ),
                                label: Container(
                                    width: buttonW,
                                    child: Text(
                                      'Management',
                                      style: myTextStyle,
                                    )),
                                onPressed: () async {
                                  setState(() {
                                    functionSellected = 'Management';
                                    global.screenTypeInt = 1;
                                  });
                                  if (isLoaded) {
                                    Loader.hide();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new Dashboard()),
                                    );
                                  } else {
                                    showloaded();
                                    initData();
                                  }
                                }),
                          ),
                        ),
                        SizedBox(
                          height: logoH,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                            // decoration: global.myBoxDecoration,
                            height: buttonH,
                            width: buttonW,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.cyan)),
                                icon: Icon(
                                  Icons.bug_report,
                                  size: 40,
                                ),
                                label: Container(
                                    width: buttonW,
                                    child: Text(
                                      'QC',
                                      style: myTextStyle,
                                    )),
                                onPressed: () async {
                                  setState(() {
                                    functionSellected = 'QC';
                                    // global.screenTypeInt = 0;
                                  });
                                  if (isLoaded) {
                                    Loader.hide();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => new QcPage()),
                                    );
                                  } else {
                                    showloaded();
                                    initData();
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  )));
  }

  showloaded() {
    Loader.show(
      context,
      overlayColor: global.isTV ? Colors.white : Colors.black54,
      progressIndicator: SizedBox(
          width: 100,
          height: 200,
          // child: CircularProgressIndicator(
          //   backgroundColor: Colors.blueAccent,
          //   color: Colors.tealAccent,
          // )
          child: Column(children: [
            global.isTV ? Image.asset('assets/logo.png') : Container(),
            Image.asset('assets/loading.gif')
          ])),
    );
  }

  Future<void> initData() async {
    print('initData-global.device: ${global.device}');

    var isConnected = await global.mySqlServer.checkConnection();
    if (isConnected) {
      do {
        if (!loaded1) {
          global.mySqlServer
              .selectTable01InspectionData(global.rangeDaySQL)
              .then((value) => {
                    loaded1 = true,
                    global.t01s = value,
                    if (global.device == 'TVLine')
                      {
                        Loader.hide(),
                        global.screenTypeInt = 0,
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new LineChart()),
                        )
                      },
                    if (global.device == 'TVControl')
                      {
                        Loader.hide(),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Dashboard()),
                        )
                      }
                  });
        }
        global.mySqlServer
            .selectAllTable03ProductionItem()
            .then((value) => {global.t03s = value, loaded3 = true});
        global.mySqlServer
            .selectAllTable04PlanProduction()
            .then((value) => {global.t04s = value, loaded4 = true});
        global.mySqlServer
            .selectAllTable06Color()
            .then((value) => {global.t06s = value, loaded6 = true});
        global.mySqlServer
            .selectAllTable08Combo()
            .then((value) => {global.t08s = value, loaded8 = true});
        loadedAll = loaded1 & loaded3 & loaded4 & loaded6 & loaded8;
        if (loadedAll) {
          Loader.hide();
          if (functionSellected == 'QC') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => new QcPage()),
            );
          } else if (functionSellected == 'Management') {
            global.screenTypeInt = 1;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => new Dashboard()),
            );
          }
        }
      } while (loadedAll);
    } else {
      print("SQL Server not available -Load offline data");
      MyFuntions.showToastNoConnection();
    }
    print('initData-DONE');
  }
}
