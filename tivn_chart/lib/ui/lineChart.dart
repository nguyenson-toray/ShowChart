import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/chart/chartFuntionData.dart';
import 'package:tivn_chart/chart/chartProduction.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  ChartSeriesController? _chartSeriesController;
  final lines = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var days = new List<int>.generate(30, (i) => i + 1);
  bool isSetting = false;
  changeSetting() async {
    // TODO: implement initState
    global.sharedPreferences.setInt('currentLine', global.currentLine);
    global.sharedPreferences.setBool('autoChangeLine', global.autoChangeLine);
    global.sharedPreferences.setInt('dashboardType', global.screenTypeInt);

    setState(() {
      global.chartData.clear();
      global.chartData = ChartFuntionData.createChartData(
        global.t01s,
        global.currentLine,
        global.inspection12,
        global.rangeTime,
        'day',
      );
      _chartSeriesController?.updateDataSource(
          updatedDataIndexes:
              List<int>.generate(global.chartData.length, (i) => i + 1));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    global.screenTypeInt == 0;
    global.chart = ChartProduction();
    global.chartData.clear();
    global.chartData = ChartFuntionData.createChartData(
      global.t01s,
      global.currentLine,
      global.inspection12,
      global.rangeTime,
      global.catalogue,
    );
    _chartSeriesController?.updateDataSource(
        updatedDataIndexes:
            List<int>.generate(global.chartData.length, (i) => i + 1));
    Timer.periodic(new Duration(seconds: global.secondsAutoGetData), (timer) {
      intervalRefresh();
    });
    super.initState();
  }

  intervalRefresh() async {
    final listDataT01 = await global.mySqlServer
        .selectTable01InspectionData(global.rangeDaySQL);
    if (listDataT01.length != 0) {
      if (!mounted) return;
      setState(() {
        global.chartData.clear();
        global.chartData = ChartFuntionData.createChartData(
          global.t01s,
          global.currentLine,
          global.inspection12,
          global.rangeTime,
          'day',
        );
        _chartSeriesController?.updateDataSource(
            updatedDataIndexes:
                List<int>.generate(global.chartData.length, (i) => i + 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleTextStyle: TextStyle(color: Colors.black),
          // toolbarHeight: 65,
          leading: Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/logo.png')),

          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
              child: isSetting
                  ? buildSetting()
                  : CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      maxRadius: 27,
                      child: Text(
                        textAlign: TextAlign.center,
                        global.currentLine.toString(),
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
          actions: [
            InkWell(
                onTap: () {
                  setState(() {
                    if (isSetting) {
                      isSetting = false;
                      changeSetting();
                    } else {
                      isSetting = true;
                    }
                  });
                },
                child: Icon(
                  color: Colors.teal,
                  isSetting ? Icons.save : Icons.settings,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    width: global.screenWPixel,
                    child: global.chart.createChartQtyRateUI(
                        global.chartData, '', 'day', global.currentLine)),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Version : ${global.version}',
                  style: TextStyle(fontSize: 5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Line : ",
          style: TextStyle(
              // fontSize: 14,
              color: Colors.black),
        ),
        DropdownButton<String>(
          value: global.currentLine.toString(),
          items: lines.map<DropdownMenuItem<String>>((int value) {
            return DropdownMenuItem<String>(
              value: value.toString(),
              child: Text(
                value.toString(),
                // style: TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              global.currentLine = int.parse(newValue!);
              changeSetting();
            });
          },
        ),
        SizedBox(
          width: 50,
        ),
        Row(
          children: [
            Text(
              'Thời gian hiển thị dữ liệu : ',
            ),
            DropdownButton<String>(
              value: global.rangeTime.toString(),
              items: days.map<DropdownMenuItem<String>>((int value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(
                    value.toString(),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  global.rangeTime = int.parse(newValue!);
                  changeSetting();
                });
              },
            ),
            Text(
              ' ngày',
            )
          ],
        ),
        SizedBox(
          width: 50,
        ),
      ],
    );
  }
}
