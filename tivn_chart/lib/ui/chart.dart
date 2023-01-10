import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:sendkeyboardevent/sendkeyboardevent.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tivn_chart/inspectionChartData.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  ChartSeriesController? _chartSeriesController;
  final lines = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var days = new List<int>.generate(30, (i) => i + 1);
  bool isSetting = false;
  final FocusNode focusNode = FocusNode();
  changeSetting() async {
    // TODO: implement initState
    global.sharedPreferences.setInt('currentLine', global.currentLine);

    setState(() {
      global.inspectionChartData.clear();
      global.inspectionChartData = global.chartFuntion
          .createChartInspectionData(global.t01s, global.currentLine);
      _chartSeriesController?.updateDataSource(
          updatedDataIndexes: List<int>.generate(
              global.inspectionChartData.length, (i) => i + 1));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    global.inspectionChartData = global.chartFuntion
        .createChartInspectionData(global.t01s, global.currentLine);
    Timer.periodic(new Duration(seconds: global.secondsAutoGetData), (timer) {
      intervalGetData();
    });

    super.initState();
  }

  intervalGetData() async {
    final listDataT01 =
        await global.mySqlServer.selectAllTable01InspectionData();
    if (listDataT01.length != 0) {
      setState(() {
        global.inspectionChartData.clear();
        global.inspectionChartData = global.chartFuntion
            .createChartInspectionData(listDataT01, global.currentLine);
        _chartSeriesController?.updateDataSource(
            updatedDataIndexes: List<int>.generate(
                global.inspectionChartData.length, (i) => i + 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // elevation: 5,
          title: Center(
              child: isSetting
                  ? buildSetting()
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 26,
                      child: Text(
                        global.currentLine.toString(),
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ))
              // : Text(
              //     'Sản lượng sản xuất & tỉ lệ lỗi - LINE ${global.currentLine.toString()}'),
              ),
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
                  isSetting ? Icons.save : Icons.settings,
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
                child: buidChart(),
              ),
              Container(
                child: Text(
                  '''Developed by Nguyen Thai Son , Version : ${global.version}''',
                  style: TextStyle(fontSize: 5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buidChart() {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      legend: Legend(
        textStyle: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        position: LegendPosition.bottom,
        isVisible: true,
      ), //ten mau
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}%',
            minimum: 0,
            maximum: 100,
            interval: 10)
      ],
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        // maximum: 50,
        interval: 20,
        // labelFormat: '{value}Pcs',
      ),
      series: getMultipleAxisLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  buildSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Line : ",
          // style: TextStyle(fontSize: 14),
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
            Text('Thời gian hiển thị dữ liệu : '),
            DropdownButton<String>(
              value: global.rangeDays.toString(),
              items: days.map<DropdownMenuItem<String>>((int value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(
                    value.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  global.rangeDays = int.parse(newValue!);
                  changeSetting();
                });
              },
            ),
            Text(' ngày')
          ],
        ),
      ],
    );
  }

  List<ChartSeries<InspectionChartData, String>> getMultipleAxisLineSeries() {
    return <ChartSeries<InspectionChartData, String>>[
      StackedColumnSeries<InspectionChartData, String>(
        dataSource: global.inspectionChartData!,
        xValueMapper: (InspectionChartData data, _) =>
            DateFormat('dd-MM').format(
          data.getDate,
        ),
        yValueMapper: (InspectionChartData data, _) => data.getQty1stOK,
        dataLabelSettings: DataLabelSettings(
            textStyle: TextStyle(fontSize: 15),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: 'SL kiểm lần 1 đạt',
        color: Colors.blue,
      ),
      StackedColumnSeries<InspectionChartData, String>(
        dataSource: global.inspectionChartData!,
        xValueMapper: (InspectionChartData data, _) =>
            DateFormat('dd-MM').format(
          data.getDate,
        ),
        yValueMapper: (InspectionChartData data, _) => data.getQty1stNOK,
        dataLabelSettings: DataLabelSettings(
            textStyle: TextStyle(fontSize: 15),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: 'SL kiểm lần 1 lỗi',
        color: Colors.orange[300],
      ),
      StackedColumnSeries<InspectionChartData, String>(
        dataSource: global.inspectionChartData!,
        xValueMapper: (InspectionChartData data, _) =>
            DateFormat('dd-MM').format(
          data.getDate,
        ),
        yValueMapper: (InspectionChartData data, _) => data.getQtyAfterRepaire,
        dataLabelSettings: DataLabelSettings(
            textStyle: TextStyle(fontSize: 15),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: 'SL sửa sau kiểm hàng',
        color: Colors.red,
      ),
      LineSeries<InspectionChartData, String>(
          markerSettings: MarkerSettings(isVisible: true),
          dataSource: global.inspectionChartData,
          yAxisName: 'yAxis1',
          xValueMapper: (InspectionChartData data, _) =>
              DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (InspectionChartData data, _) =>
              data.getRationDefect1st * 100,
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true, labelAlignment: ChartDataLabelAlignment.auto),
          name: 'TL kiểm lần 1 lỗi',
          color: Colors.pink,
          width: 4),
      LineSeries<InspectionChartData, String>(
          markerSettings: MarkerSettings(isVisible: true),
          dataSource: global.inspectionChartData,
          yAxisName: 'yAxis1',
          xValueMapper: (InspectionChartData data, _) =>
              DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (InspectionChartData data, _) =>
              data.getRationDefectAfterRepaire,
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
          name: 'TL kiểm lỗi sau sửa',
          color: Colors.green,
          width: 4)
    ];
  }
}
