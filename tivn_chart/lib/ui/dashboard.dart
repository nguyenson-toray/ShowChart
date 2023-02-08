import 'dart:async';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/chart/chartFuntionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:tivn_chart/ui/lineChart.dart';
import 'package:intl/intl.dart';

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
    hChart = (global.screenHPixel - 60) / 2 - 6;
    wChart = global.screenWPixel * 0.325;
    refreshChartData();
    Timer.periodic(new Duration(seconds: global.secondsAutoGetData), (timer) {
      getDataT01();
    });
    Timer.periodic(new Duration(seconds: global.secondsAutoChangeLine),
        (timer) {
      autoChangeLine();
    });

    super.initState();
  }

  getDataT01() async {
    if (!mounted) return;

    await global.mySqlServer
        .getInspectionData(global.rangeDaySQL)
        .then((value) => setState(() {
              global.t01s = value;
            }));
    refreshChartData();
  }

  refreshChartData() async {
    if (!mounted) return;
    print('refreshChartData');
    var dataInput = [...global.t01s];
    setState(() {
      global.chartQtyRateData = ChartFuntionData.createChartData(
          dataInput,
          global.currentLine,
          global.inspection12,
          global.rangeTime,
          global.catalogue);
      global.chartLineData = ChartFuntionData.createChartData([...global.t01s],
          global.currentLine, global.inspection12, global.rangeTime, 'line');
      global.chartGroupAllData = ChartFuntionData.createChartData(
          dataInput,
          global.currentLine,
          global.inspection12,
          global.rangeTime,
          global.catalogue);
      global.chartGroupEData = ChartFuntionData.createChartData(
          dataInput,
          global.currentLine,
          global.inspection12,
          global.rangeTime,
          global.catalogue);
      global.chartGroupFData = ChartFuntionData.createChartData(
          dataInput,
          global.currentLine,
          global.inspection12,
          global.rangeTime,
          global.catalogue);
    });
  }

  autoChangeLine() {
    if (!mounted || !global.autoChangeLine) return;
    if (global.autoChangeLine && global.dashboardType == 'control2') {
      setState(() {
        if (global.currentLine < 7)
          global.currentLine++;
        else
          global.currentLine = 1;
        print('autoChangeLine -> ' + global.currentLine.toString());
      });
      refreshChartData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
            color: Colors.grey[200],
            // padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                option(),
                global.dashboardType == 'control1'
                    ? buildScreen1()
                    : buildScreen2()
              ],
            )),
      ),
    );
  }

  Widget buildScreen1() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: hChart,
                  width: global.screenWPixel / 2 - 5,
                  child: global.chartQtyRate.createChartQtyRateUI(
                      global.chartQtyRateData,
                      '工場の全ラインの生産性・不良率-Sản lượng & tỉ lệ lỗi của toàn nhà máy',
                      global.catalogue),
                ),
                Container(
                  height: hChart,
                  width: global.screenWPixel / 2 - 5,
                  child: global.chartLine.createChartQtyRateUI(
                      global.chartLineData,
                      'ライン別の生産性・不良率 - Sản lượng & tỉ lệ lỗi của các chuyền ',
                      'line'),
                ),
              ],
            ),
            Divider(height: 4),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: hChart,
                    width: wChart,
                    child: global.chartGroupAll
                        .createChartGroupAllUI(global.chartGroupAllData),
                  ),
                  Container(
                    height: hChart,
                    width: wChart,
                    child: global.chartGroupF
                        .createChartGroupFUI(global.chartGroupFData),
                  ),
                  Container(
                    height: hChart,
                    width: wChart,
                    child: global.chartGroupE
                        .createChartGroupEUI(global.chartGroupEData),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  Widget buildScreen2() {
    return Container(
      child: Column(
        children: [
          Container(
            height: hChart,
            child: global.chartQtyRate.createChartQtyRateUI(
                global.chartQtyRateData, '', global.catalogue),
          ),
          Divider(height: 4),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: hChart,
                  width: wChart,
                  child: global.chartGroupAll
                      .createChartGroupAllUI(global.chartGroupAllData),
                ),
                Container(
                  height: hChart,
                  width: wChart,
                  child: global.chartGroupF
                      .createChartGroupFUI(global.chartGroupFData),
                ),
                Container(
                  height: hChart,
                  width: wChart,
                  child: global.chartGroupE
                      .createChartGroupEUI(global.chartGroupEData),
                ),
              ],
            ),
          )
        ],
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(global.dashboardType == 'control1'
              ? "Production Management System".toUpperCase()
              : ('LINE ' + global.currentLine.toString())),
        ],
      ),
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
      height: 30,
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
          indexOfDefault: ["day", "week", "month"].indexOf(global.catalogue),
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
          values: ['1st', '2nd'],
          indexOfDefault: global.inspection12 == 1 ? 0 : 1,
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
