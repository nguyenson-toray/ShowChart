import 'dart:async';

import 'package:crea_radio_button/crea_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/chart/chartGroupAll.dart';
import 'package:tivn_chart/chart/chartGroupE.dart';
import 'package:tivn_chart/chart/chartGroupF.dart';
import 'package:tivn_chart/chart/chartGroupH.dart';
import 'package:tivn_chart/chart/chartQtyRate.dart';
import 'package:tivn_chart/global.dart';
import 'package:tivn_chart/ui/lineChart.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  ChartSeriesController? chartSeriesController;
  double hSetting = 0;
  double wSetting = 0;
  double hChart = 0;
  double wChart = 0;
  int padding = 10;
  List<String> lines = [
    'All',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  @override
  void initState() {
    // TODO: implement initState
    hSetting = global.screenHPixel - 50;
    wSetting = global.screenWPixel * 0.1;
    hChart = (global.screenHPixel - 70) / 2 - 5;
    wChart = global.screenWPixel * 0.32;
    initChartDatas();
    Timer.periodic(new Duration(seconds: global.secondsAutoGetData), (timer) {
      refreshData();
    });
    Timer.periodic(new Duration(seconds: global.secondsAutoChangeLine),
        (timer) {
      autoChangeLine();
    });
    super.initState();
  }

  refreshData() async {
    if (!mounted) return;
    final listDataT01 = await global.mySqlServer
        .getInspectionData(global.rangeDays, global.inspection12);
    if (listDataT01.length != 0) {
      print('refreshData');
      setState(() {
        global.t01s = listDataT01;
      });
      refreshChartData();
    }
  }

  refreshChartData() async {
    if (!mounted) return;
    final listDataT01 = await global.mySqlServer
        .getInspectionData(global.rangeDays, global.inspection12);
    if (listDataT01.length != 0) {
      print('refreshData');
      setState(() {
        global.t01s = listDataT01;
        global.chartQtyRateData.clear();
        global.chartQtyRateData = global.chartQtyRate.createChartData(
            global.t01s,
            global.currentLine,
            global.rangeDays,
            global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartQtyRateData.length, (i) => i + 1));
        //-
        global.chartGroupAllData.clear();
        global.chartGroupAllData = global.chartGroupAll.createChartData(
            global.t01s,
            global.currentLine,
            global.rangeDays,
            global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupAllData.length, (i) => i + 1));
        //-
        global.chartGroupEData.clear();
        global.chartGroupEData = global.chartGroupE.createChartData(global.t01s,
            global.currentLine, global.rangeDays, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupEData.length, (i) => i + 1));
        //-
        global.chartGroupFData.clear();
        global.chartGroupFData = global.chartGroupF.createChartData(global.t01s,
            global.currentLine, global.rangeDays, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupFData.length, (i) => i + 1));
        //-
        global.chartGroupFData.clear();
        global.chartGroupFData = global.chartGroupF.createChartData(global.t01s,
            global.currentLine, global.rangeDays, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupFData.length, (i) => i + 1));
        //-
        global.chartGroupHData.clear();
        global.chartGroupHData = global.chartGroupH.createChartData(global.t01s,
            global.currentLine, global.rangeDays, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupHData.length, (i) => i + 1));
      });
    }
  }

  autoChangeLine() {
    if (!mounted || !global.autoChangeLine) return;
    setState(() {
      print('autoChangeLine');
      if (global.currentLine < 8)
        global.currentLine++;
      else
        global.currentLine = 0;
    });
  }

  initChartDatas() {
    global.chartQtyRate = ChartQtyRate(date: global.today);
    global.chartQtyRateData = global.chartQtyRate.createChartData(
        global.t01s, global.currentLine, global.rangeDays, global.inspection12);

    global.chartGroupAll = ChartGroupAll(date: global.today);
    global.chartGroupAllData = global.chartGroupAll.createChartData(
        global.t01s, global.currentLine, global.rangeDays, global.inspection12);

    global.chartGroupF = ChartGroupF(date: global.today);
    global.chartGroupFData = global.chartGroupF.createChartData(
        global.t01s, global.currentLine, global.rangeDays, global.inspection12);

    global.chartGroupE = ChartGroupE(date: global.today);
    global.chartGroupEData = global.chartGroupE.createChartData(
        global.t01s, global.currentLine, global.rangeDays, global.inspection12);

    global.chartGroupH = ChartGroupH(date: global.today);
    global.chartGroupHData = global.chartGroupH.createChartData(
        global.t01s, global.currentLine, global.rangeDays, global.inspection12);
  }

  @override
  Widget build(BuildContext context) {
    print('global.autoChangeLine :' + global.autoChangeLine.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // actionsIconTheme: IconThemeData(color: Colors.tealAccent),
          backgroundColor: Colors.blueAccent,
          leading: setting(),
          title: Column(
            children: [
              Text("Production Management System".toUpperCase()),
              global.currentLine > 0
                  ? Text(
                      'Line : ' + global.currentLine.toString(),
                    )
                  : Text('Line : All'),
            ],
          ),
          centerTitle: true,
          actions: [
            InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                setState(() {
                  if (global.currentLine > 0)
                    global.currentLine--;
                  else
                    global.currentLine = 8;
                });
                global.sharedPreferences
                    .setInt('currentLine', global.currentLine);
                refreshChartData();
              },
            ),
            InkWell(
              child:
                  Icon(global.autoChangeLine ? Icons.pause : Icons.play_circle),
              onTap: () {
                setState(() {
                  global.autoChangeLine = !global.autoChangeLine;
                });
                global.sharedPreferences
                    .setBool('autoChangeLine', global.autoChangeLine);
              },
            ),
            InkWell(
              child: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {
                  if (global.currentLine < 9)
                    global.currentLine++;
                  else
                    global.currentLine = 0;
                });
                global.sharedPreferences
                    .setInt('currentLine', global.currentLine);
                refreshChartData();
              },
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
                onTap: () {
                  global.showDashboard = false;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LineChart()),
                  );
                },
                child: Icon(Icons.exit_to_app))
          ],
        ),
        body: Container(
            color: Colors.grey[200],
            // padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // setting(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: hChart,
                        width: global.screenWPixel / 2 - 10,
                        child: global.chartQtyRate
                            .createChartUI(global.chartQtyRateData),
                      ),
                      Container(
                        height: hChart,
                        width: global.screenWPixel / 2 - 10,
                        child: global.chartGroupAll
                            .createChartUI(global.chartGroupAllData),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: hChart,
                      width: wChart,
                      child: global.chartGroupF
                          .createChartUI(global.chartGroupFData),
                    ),
                    Container(
                      height: hChart,
                      width: wChart,
                      child: global.chartGroupE
                          .createChartUI(global.chartGroupEData),
                    ),
                    Container(
                      height: hChart,
                      width: wChart,
                      child: global.chartGroupH
                          .createChartUI(global.chartGroupHData),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '''Developed by Nguyen Thai Son , Version : ${global.version}''',
                    style: TextStyle(fontSize: 4),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget setting() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(2),
      height: 35,
      width: global.screenWPixel,
      // color: Colors.blueAccent,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonGroup(
                  preSelectedIdx: global.inspection12 - 1,
                  textStyle: TextStyle(fontSize: 9, color: Colors.black),
                  selectedBorderSide: BorderSide(color: Colors.white, width: 1),
                  selectedColor: Colors.orange,
                  mainColor: Colors.white,
                  vertical: false,
                  options: [
                    RadioOption(1, "1st"),
                    RadioOption(2, "2nd"),
                  ],
                  buttonHeight: 15,
                  buttonWidth: 65,
                  callback: (RadioOption val) {
                    print('val : ' + val.value.toString());
                    setState(() {
                      global.inspection12 = val.value;
                    });
                    refreshChartData();
                  }),
              RadioButtonGroup(
                  preSelectedIdx: 0,
                  textStyle: TextStyle(fontSize: 9, color: Colors.black),
                  selectedBorderSide: BorderSide(color: Colors.white, width: 1),
                  selectedColor: Colors.orange,
                  mainColor: Colors.white,
                  vertical: false,
                  options: [
                    RadioOption("daily", "Daily"),
                    RadioOption("weekly", "Weekly"),
                    RadioOption("monthly", "Monthly"),
                  ],
                  buttonHeight: 15,
                  buttonWidth: 65,
                  callback: (RadioOption val) {
                    setState(() {
                      global.periodType = val.value;
                    });
                    refreshChartData();
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget alarm() {
    return Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        padding: EdgeInsets.all(10),
        height: hChart,
        width: wChart,
        child: Text('alarm'));
  }
}
