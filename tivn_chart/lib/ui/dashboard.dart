import 'dart:async';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
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
  ];
  RadioGroupController myController = RadioGroupController();
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
    final listDataT01 =
        await global.mySqlServer.getInspectionData(global.rangeDaySQL);
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
    // final listDataT01 =
    //     await global.mySqlServer.getInspectionData(global.rangeDaySQL);
    // if (listDataT01.length != 0)
    {
      print('refreshData');
      setState(() {
        // global.t01s = listDataT01;
        print('global.t01s-lenght = ' + global.t01s.length.toString());

        global.chartQtyRateData.clear();
        global.chartQtyRateData = global.chartQtyRate.createChartData(
            global.t01s,
            global.currentLine,
            global.inspection12,
            global.rangeTime,
            global.catalogue);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartQtyRateData.length, (i) => i + 1));
        //-
        global.chartLineData.clear();
        global.chartLineData = global.chartLine.createChartData(global.t01s,
            global.currentLine, global.inspection12, global.rangeTime, 'line');
        chartSeriesController?.updateDataSource(
            updatedDataIndexes:
                List<int>.generate(global.chartLineData.length, (i) => i + 1));
        //-
/*
        global.chartGroupAllData.clear();
        global.chartGroupAllData = global.chartGroupAll.createChartData(
            global.t01s,
            global.currentLine,
            global.rangeTime,
            global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupAllData.length, (i) => i + 1));
        //-
        global.chartGroupEData.clear();
        global.chartGroupEData = global.chartGroupE.createChartData(global.t01s,
            global.currentLine, global.rangeTime, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupEData.length, (i) => i + 1));
        //-
        global.chartGroupFData.clear();
        global.chartGroupFData = global.chartGroupF.createChartData(global.t01s,
            global.currentLine, global.rangeTime, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupFData.length, (i) => i + 1));
        //-
        global.chartGroupFData.clear();
        global.chartGroupFData = global.chartGroupF.createChartData(global.t01s,
            global.currentLine, global.rangeTime, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupFData.length, (i) => i + 1));
        //-
        global.chartGroupHData.clear();
        global.chartGroupHData = global.chartGroupH.createChartData(global.t01s,
            global.currentLine, global.rangeTime, global.inspection12);
        chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartGroupHData.length, (i) => i + 1));
                */
      });
    }
  }

  autoChangeLine() {
    if (!mounted || !global.autoChangeLine) return;
    if (global.autoChangeLine && global.dashboardType == 'control2') {
      setState(() {
        print('autoChangeLine');
        if (global.currentLine < 7)
          global.currentLine++;
        else
          global.currentLine = 1;
      });
    }
  }

  initChartDatas() {
    global.chartQtyRate = ChartQtyRate(date: global.today);
    global.chartQtyRateData = global.chartQtyRate.createChartData(
      global.t01s,
      global.currentLine,
      global.inspection12,
      global.rangeTime,
      global.catalogue,
    );
    //-
    global.chartLine = ChartQtyRate(date: global.today);
    global.chartLineData = global.chartLine.createChartData(global.t01s,
        global.currentLine, global.inspection12, global.rangeTime, 'line');

    global.chartGroupAll = ChartGroupAll(date: global.today);
    global.chartGroupAllData = global.chartGroupAll.createChartData(
        global.t01s, global.currentLine, global.rangeTime, global.inspection12);

    global.chartGroupF = ChartGroupF(date: global.today);
    global.chartGroupFData = global.chartGroupF.createChartData(
        global.t01s, global.currentLine, global.rangeTime, global.inspection12);

    global.chartGroupE = ChartGroupE(date: global.today);
    global.chartGroupEData = global.chartGroupE.createChartData(
        global.t01s, global.currentLine, global.rangeTime, global.inspection12);

    global.chartGroupH = ChartGroupH(date: global.today);
    global.chartGroupHData = global.chartGroupH.createChartData(
        global.t01s, global.currentLine, global.rangeTime, global.inspection12);
  }

  @override
  Widget build(BuildContext context) {
    print('  global.dashboardType = ' + global.dashboardType);
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
            color: Colors.grey[200],
            // padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                option(),
                global.dashboardType == 'control1'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Container(
                              height: hChart,
                              width: global.screenWPixel / 2 - 5,
                              child: global.chartQtyRate.createChartUI(
                                  global.chartQtyRateData,
                                  '工場の全ラインの生産性・不良率-Sản lượng & tỉ lệ lỗi của toàn nhà máy',
                                  global.catalogue),
                            ),
                            Container(
                              height: hChart,
                              width: global.screenWPixel / 2 - 5,
                              child: global.chartLine.createChartUI(
                                  global.chartLineData,
                                  'ライン別の生産性・不良率 - Sản lượng & tỉ lệ lỗi của các chuyền ',
                                  'line'),
                            ),
                          ])
                    : Row(
                        children: [
                          Container(
                            height: hChart,
                            width: global.screenWPixel - 5,
                            child: global.chartQtyRate.createChartUI(
                                global.chartQtyRateData,
                                '',
                                // 'ライン別の生産性・不良率 - Sản lượng & tỉ lệ lỗi của chuyền ',
                                'day'),
                          )
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: hChart,
                      width: wChart,
                      child: global.chartGroupAll
                          .createChartUI(global.chartGroupAllData),
                    ),
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
                    // Container(
                    //   height: hChart,
                    //   width: wChart,
                    //   child: global.chartGroupH
                    //       .createChartUI(global.chartGroupHData),
                    // ),
                  ],
                ),
                Container(
                  height: 4,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '''         Developed by Nguyen Thai Son , Version : ${global.version}''',
                    style: TextStyle(fontSize: 4),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 30,
      // actionsIconTheme: IconThemeData(color: Colors.tealAccent),
      backgroundColor: Colors.blue[700],
      leading: InkWell(
          onTap: () {
            global.dashboardType = 'sewing';

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LineChart()),
            );
          },
          child: Icon(Icons.close_rounded)),
      title: Text(global.dashboardType == 'control1'
          ? "Production Management System".toUpperCase()
          : ('LINE ' + global.currentLine.toString())),
      centerTitle: true,
      actions: global.dashboardType == 'control2'
          ? [
              InkWell(
                child: Icon(
                    global.autoChangeLine ? Icons.pause : Icons.play_circle),
                onTap: () {
                  setState(() {
                    global.autoChangeLine = !global.autoChangeLine;
                  });
                  global.sharedPreferences
                      .setBool('autoChangeLine', global.autoChangeLine);
                },
              ),
              InkWell(
                child: Icon(Icons.arrow_back_sharp),
                onTap: () {
                  setState(() {
                    if (global.currentLine > 1)
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
                child: Icon(Icons.arrow_forward_sharp),
                onTap: () {
                  setState(() {
                    if (global.currentLine < 8)
                      global.currentLine++;
                    else
                      global.currentLine = 1;
                  });
                  global.sharedPreferences
                      .setInt('currentLine', global.currentLine);
                  refreshChartData();
                },
              ),
            ]
          : [],
    );
  }

  Widget option() {
    return Container(
      color: Colors.blue[50],
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
      height: 28,
      width: global.screenWPixel,
      // color: Colors.blueAccent,
      child: Row(children: [
        RadioGroup(
          onChanged: (value) {
            setState(() {
              if (value.toString() == 'Screen 1') {
                global.dashboardType = 'control1';
              } else {
                global.dashboardType = 'control2';
              }
              global.sharedPreferences
                  .setString('dashboardType', global.dashboardType);
            });
            refreshChartData();
          },
          controller: myController,
          values: ["Screen 1", "Screen 2"],
          indexOfDefault: global.dashboardType == 'control1' ? 0 : 1,
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
        RadioGroup(
          onChanged: (value) {
            print('value = ' + value.toString());
            setState(() {
              global.rangeTime = int.parse(value.toString());
              global.sharedPreferences.setInt('rangeTime', global.rangeTime);
              refreshChartData();
            });
          },
          controller: myController,
          values: [1, 2, 4, 6, 8, 10, 15, 20],
          indexOfDefault: [1, 2, 4, 6, 8, 10, 15, 20].indexOf(global.rangeTime),
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        RadioGroup(
          onChanged: (value) {
            setState(() {
              global.catalogue = value.toString();
              global.sharedPreferences.setString('catalogue', global.catalogue);
              refreshChartData();
            });
          },
          controller: myController,
          values: ["day", "week", "month"],
          indexOfDefault: 0,
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('Data', style: TextStyle(color: Colors.black, fontSize: 8)),
        RadioGroup(
          onChanged: (value) {
            setState(() {
              if (value.toString() == '1st')
                global.inspection12 = 1;
              else
                global.inspection12 = 2;
              global.sharedPreferences
                  .setInt('inspection12', global.inspection12);
              refreshChartData();
            });
          },
          controller: myController,
          values: ["1st", "2nd"],
          indexOfDefault: 0,
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
      ]),
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
