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
  var isLoaded = false;
  var isSelected = false;
  var myTextStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    global.isTV ? logoH = 100 : logoH = 50;
    Timer(Duration(milliseconds: 500), () {
      print("initData after 1000 milliseconds");
      initData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: global.device.contains('TV')
                ? showLoading()
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
                                    isSelected = true;
                                    global.screenTypeInt = 1;
                                  });
                                  if (isLoaded && isSelected) {
                                    Loader.hide();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new Dashboard()),
                                    );
                                  } else
                                    showLoading();
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
                                    isSelected = true;
                                    // global.screenTypeInt = 0;
                                  });
                                  if (isLoaded && isSelected) {
                                    Loader.hide();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => new QcPage()),
                                    );
                                  } else
                                    showLoading();
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
                                        MaterialStateProperty.all(Colors.teal)),
                                icon: Icon(
                                  Icons.workspaces,
                                  size: 40,
                                ),
                                label: Container(
                                    width: buttonW,
                                    child: Text(
                                      'Sewing line',
                                      style: myTextStyle,
                                    )),
                                onPressed: () async {
                                  setState(() {
                                    isSelected = true;
                                    global.screenTypeInt = 0;
                                  });
                                  if (isLoaded && isSelected) {
                                    Loader.hide();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new LineChart()),
                                    );
                                  } else
                                    showLoading();
                                }),
                          ),
                        ),
                      ],
                    ),
                  )));
  }

  showLoading() {
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
            Image.asset('assets/logo.png'),
            Image.asset('assets/loading.gif')
          ])),
    );
  }

  Future<void> initData() async {
    print('initData');

    var isConnected = await global.mySqlServer.checkConnection();

    if (isConnected) {
      global.t01s = await global.mySqlServer
          .selectTable01InspectionData(global.rangeDaySQL);
      if (!global.device.contains('TV')) {
        global.t03s = await global.mySqlServer.selectAllTable03ProductionItem();
        global.t04s = await global.mySqlServer.selectAllTable04PlanProduction();
        global.t06s = await global.mySqlServer.selectAllTable06Color();
        global.t08s = await global.mySqlServer.selectAllTable08Combo();
      }

      isLoaded = true;
      Loader.hide();
      if (global.device == 'TVLine') {
        global.screenTypeInt = 0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new LineChart()),
        );
      }

      if (global.device == 'TVControl')
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new Dashboard()),
        );
      // await global.mySqlServer
      //     .selectTable01InspectionData(global.rangeDaySQL)
      //     .then((value) => setState(() {
      //           if (value.length > 0) {
      //             global.t01s = value;
      //             isLoaded = true;
      //           }
      //         }));
    } else {
      print("SQL Server not available -Load offline data");
      MyFuntions.showToastNoConnection();
    }
  }
}
