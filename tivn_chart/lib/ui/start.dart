import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'package:tivn_chart/ui/dashboard.dart';
import 'package:tivn_chart/ui/lineChart.dart';
import 'package:tivn_chart/ui/qcPage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double logoH = 30;
  double buttonH = 80;
  double buttonW = 280;
  bool isLoaded = false;
  String functionSellected = '';
  var myTextStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState

    global.isTV ? logoH = 100 : logoH = 50;
    Timer(Duration(milliseconds: 500), () async {
      initData().then((value) => (value) {
            setState(() {
              isLoaded = value;
            });
          });
    });

    Timer.periodic(new Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (isLoaded) {
        Loader.hide();
        if (functionSellected == 'Management') {
          setState(() {
            global.screenTypeInt = 1;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => new Dashboard()),
          );
        }
        if (functionSellected == 'QC') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => new QcPage()),
          );
        }
      }
    });
    super.initState();
  }

  Future<bool> initData() async {
    if (!global.isTV) {
      setState(() {
        global.screenWPixel = MediaQuery.of(context).size.width;
        global.screenHPixel = MediaQuery.of(context).size.height;
        print('-initData-Start--- screenWPixel : ${global.screenWPixel}');
        print('-initData-Start--- screenHPixel : ${global.screenHPixel}');
      });
    }

    print('initData-global.device: ${global.device}');
    var isConnected = await global.mySqlServer.checkConnection();
    if (isConnected) {
      global.t01s = await global.mySqlServer
          .selectTable01InspectionData(global.rangeDaySQL);
      global.t03s = await global.mySqlServer.selectAllTable03ProductionItem();
      global.t04s = await global.mySqlServer.selectAllTable04PlanProduction();
      global.t06s = await global.mySqlServer.selectAllTable06Color();
      global.t08s = await global.mySqlServer.selectAllTable08Combo();
      if (global.device == 'TVLine') {
        Loader.hide();
        global.screenTypeInt = 0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new LineChart()),
        );
      }
      if (global.device == 'TVControl') {
        Loader.hide();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new Dashboard()),
        );
      }
    } else {
      print("SQL Server not available -Load offline data");
      MyFuntions.showToastNoConnection();
    }
    print('initData-DONE');
    setState(() {
      isLoaded = true;
    });
    return true;
  }

  showLoading() {
    if (isLoaded) {
      Loader.hide();
    } else {
      Loader.show(
        context,
        overlayColor: global.isTV ? Colors.white : Colors.black54,
        progressIndicator: SizedBox(
            width: 100,
            height: 200,
            child: Column(children: [
              global.isTV ? Image.asset('assets/logo.png') : Container(),
              Image.asset('assets/loading.gif')
            ])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('isLoaded : ' + isLoaded.toString());
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //     elevation: 10,
            //     backgroundColor: Colors.indigoAccent,
            //     actions: [
            //       InkWell(
            //         child: Image.asset('assets/vietnam.png'),
            //       ),
            //       InkWell(
            //         child: Image.asset('assets/japan.png'),
            //       )
            //     ]),
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
                                  print(' Touch Management - isLoaded : ' +
                                      isLoaded.toString());
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
                                    showLoading();
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
                                  print(' Touch QC - isLoaded : ' +
                                      isLoaded.toString());
                                  setState(() {
                                    functionSellected = 'QC';
                                  });
                                  if (isLoaded) {
                                    Loader.hide();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => new QcPage()),
                                    );
                                  } else {
                                    showLoading();
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  )));
  }
}
