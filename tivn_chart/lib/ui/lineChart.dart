import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:sendkeyboardevent/sendkeyboardevent.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tivn_chart/chart/chartQtyRate.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/inspectionChartData.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';
import 'package:cron/cron.dart';
import 'package:tivn_chart/ui/dashboard.dart';

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
    global.sharedPreferences.setString('dashboardType', global.dashboardType);

    setState(() {
      global.chartQtyRateData.clear();
      global.chartQtyRateData = global.chartQtyRate.createChartData(
          global.t01s,
          global.currentLine,
          global.rangeTime,
          global.inspection12,
          global.catalogue);
      _chartSeriesController?.updateDataSource(
          updatedDataIndexes:
              List<int>.generate(global.chartQtyRateData.length, (i) => i + 1));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    global.chartQtyRate = ChartQtyRate(date: global.today);
    global.chartQtyRateData = global.chartQtyRate.createChartData(
        global.t01s,
        global.currentLine,
        global.rangeTime,
        global.inspection12,
        global.catalogue);
    Timer.periodic(new Duration(seconds: global.secondsAutoGetData), (timer) {
      intervalRefresh();
    });
    Timer.periodic(new Duration(seconds: global.secondsAutoChangeLine),
        (timer) {
      autoChangeLine();
    });

    super.initState();
  }

  autoChangeLine() {
    if (!mounted) return;
    setState(() {
      if (global.currentLine < 8)
        global.currentLine++;
      else
        global.currentLine = 1;
    });
  }

  intervalRefresh() async {
    final listDataT01 =
        await global.mySqlServer.getInspectionData(global.rangeDaySQL);
    if (listDataT01.length != 0) {
      if (!mounted) return;
      setState(() {
        global.chartQtyRateData.clear();
        global.chartQtyRateData = global.chartQtyRate.createChartData(
            global.t01s,
            global.currentLine,
            global.rangeDaySQL,
            global.inspection12,
            global.catalogue);
        _chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.chartQtyRateData.length, (i) => i + 1));
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
            SizedBox(
              width: 15,
            ),
            InkWell(
                onTap: () {
                  global.dashboardType = 'control1';
                  global.sharedPreferences
                      .setString('dashboardType', global.dashboardType);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.teal,
                ))
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
                  child: global.chartQtyRate
                      .createChartUI(global.chartQtyRateData, '', 'daily'),
                ),
              ),
              Container(
                child: Text(
                  '''Developed by Nguyen Thai Son , Version : ${global.version}''',
                  style: TextStyle(fontSize: 4),
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
        Text('Tự động chuyển line'),
        Checkbox(
          onChanged: (bool? value) {
            setState(() {
              global.autoChangeLine = value!;
            });
          },
          value: global.autoChangeLine,
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

  // List<ChartSeries<InspectionChartData, String>> getMultipleAxisLineSeries() {
  //   return <ChartSeries<InspectionChartData, String>>[
  //     StackedColumnSeries<InspectionChartData, String>(
  //       dataSource: global.inspectionChartData!,
  //       xValueMapper: (InspectionChartData data, _) =>
  //           DateFormat('dd-MM').format(
  //         data.getDate,
  //       ),
  //       yValueMapper: (InspectionChartData data, _) => data.getQty1stOK,
  //       dataLabelSettings: DataLabelSettings(
  //           textStyle: TextStyle(fontSize: 15),
  //           isVisible: true,
  //           labelAlignment: ChartDataLabelAlignment.auto),
  //       name: 'SL kiểm lần 1 đạt',
  //       color: Colors.blue,
  //     ),
  //     StackedColumnSeries<InspectionChartData, String>(
  //       dataSource: global.inspectionChartData!,
  //       xValueMapper: (InspectionChartData data, _) =>
  //           DateFormat('dd-MM').format(
  //         data.getDate,
  //       ),
  //       yValueMapper: (InspectionChartData data, _) => data.getQty1stNOK,
  //       dataLabelSettings: DataLabelSettings(
  //           textStyle: TextStyle(fontSize: 15),
  //           isVisible: true,
  //           labelAlignment: ChartDataLabelAlignment.auto),
  //       name: 'SL kiểm lần 1 lỗi',
  //       color: Colors.orange[300],
  //     ),
  //     StackedColumnSeries<InspectionChartData, String>(
  //       dataSource: global.inspectionChartData!,
  //       xValueMapper: (InspectionChartData data, _) =>
  //           DateFormat('dd-MM').format(
  //         data.getDate,
  //       ),
  //       yValueMapper: (InspectionChartData data, _) => data.getQtyAfterRepaire,
  //       dataLabelSettings: DataLabelSettings(
  //           textStyle: TextStyle(fontSize: 15),
  //           isVisible: true,
  //           labelAlignment: ChartDataLabelAlignment.auto),
  //       name: 'SL sửa sau kiểm hàng',
  //       color: Colors.red,
  //     ),
  //     LineSeries<InspectionChartData, String>(
  //         markerSettings: MarkerSettings(isVisible: true),
  //         dataSource: global.inspectionChartData,
  //         yAxisName: 'yAxis1',
  //         xValueMapper: (InspectionChartData data, _) =>
  //             DateFormat('dd-MM').format(
  //               data.getDate,
  //             ),
  //         yValueMapper: (InspectionChartData data, _) =>
  //             data.getRationDefect1st * 100,
  //         // dataLabelSettings: DataLabelSettings(
  //         //     isVisible: true, labelAlignment: ChartDataLabelAlignment.auto),
  //         name: 'TL kiểm lần 1 lỗi',
  //         color: Colors.pink,
  //         width: 4),
  //     LineSeries<InspectionChartData, String>(
  //         markerSettings: MarkerSettings(isVisible: true),
  //         dataSource: global.inspectionChartData,
  //         yAxisName: 'yAxis1',
  //         xValueMapper: (InspectionChartData data, _) =>
  //             DateFormat('dd-MM').format(
  //               data.getDate,
  //             ),
  //         yValueMapper: (InspectionChartData data, _) =>
  //             data.getRationDefectAfterRepaire,
  //         // dataLabelSettings: DataLabelSettings(
  //         //     isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
  //         name: 'TL kiểm lỗi sau sửa',
  //         color: Colors.green,
  //         width: 4)
  //   ];
  // }
}
