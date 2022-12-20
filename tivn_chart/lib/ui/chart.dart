import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tivn_chart/inspectionChartData.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';
import 'package:tivn_chart/ui/Setting.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  ChartSeriesController? _chartSeriesController;
  final lines = [1, 2, 3, 4, 5, 6, 7, 8];
  var days = new List<int>.generate(30, (i) => i + 1);
  @override
  changeSetting() async {
    // TODO: implement initState
    global.sharedPreferences.setInt('currentLine', global.currentLine);

    setState(() {
      global.inspectionChartData.clear();
      global.inspectionChartData = global.chartFuntion
          .createChartInspectionData(global.t01s, global.currentLine);
      _chartSeriesController?.updateDataSource(
          updatedDataIndex: global.inspectionChartData.length - 1);
    });

    print('------------refresh');
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
            updatedDataIndex: global.inspectionChartData.length - 1);
      });
    }
  }

  bool isSetting = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: isSetting
                  ? buildSetting()
                  : Text(
                      'Sản lượng sản xuất & tỉ lệ lỗi - LINE ${global.currentLine.toString()}'),
            ),
            actions: [
              InkWell(
                onTap: () {
                  print('tapppppppppppppp');
                  setState(() {
                    if (isSetting) {
                      isSetting = false;
                      changeSetting();
                    } else {
                      isSetting = true;
                    }
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Setting()),
                  // );
                },
                child: Icon(
                  isSetting ? Icons.save : Icons.settings,
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SfCartesianChart(
                legend: Legend(
                  position: LegendPosition.bottom,
                  isVisible: true,
                ), //ten mau
                // Enable tooltip
                // tooltipBehavior: TooltipBehavior(enable: true),
                borderWidth: 2,
                primaryXAxis: CategoryAxis(labelRotation: 0),
                primaryYAxis: NumericAxis(
                  minimum: 0, //maximum: 250,
                  // interval: 10
                ),
                series: <ChartSeries<InspectionChartData, String>>[
                  StackedColumnSeries<InspectionChartData, String>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      color: Colors.blue,
                      name: 'SL kiểm lần 1 đạt',
                      dataSource: global.inspectionChartData,
                      xValueMapper: (InspectionChartData data, _) =>
                          DateFormat('dd-MM').format(
                            data.getDate,
                          ),
                      yValueMapper: (InspectionChartData data, _) =>
                          data.getQty1stOK,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.top)),

                  StackedColumnSeries<InspectionChartData, String>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      color: Colors.orange[300],
                      dataSource: global.inspectionChartData,
                      name: 'SL kiểm lần 1 lỗi',
                      xValueMapper: (InspectionChartData data, _) =>
                          DateFormat('dd-MM').format(
                            data.getDate,
                          ),
                      yValueMapper: (InspectionChartData data, _) =>
                          data.getQty1stNOK,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.top)),
                  StackedColumnSeries<InspectionChartData, String>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      color: Colors.red,
                      dataSource: global.inspectionChartData,
                      name: 'SL kiểm sau khi sửa hàng ',
                      xValueMapper: (InspectionChartData data, _) =>
                          DateFormat('dd-MM').format(
                            data.getDate,
                          ),
                      yValueMapper: (InspectionChartData data, _) =>
                          data.getQtyAfterRepaire,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.top)),
                  // StackedColumnSeries<InspectionChartData, String>(
                  //     dataSource: global.inspectionChartData,
                  //     xValueMapper: (InspectionChartData data, _) =>
                  //         DateFormat('dd-MM').format(
                  //           data.getDate,
                  //         ),
                  //     yValueMapper: (InspectionChartData data, _) =>
                  //         data.getRationDefect1st.toStringAsFixed(2)),
                  // StackedColumnSeries<InspectionChartData, String>(
                  //     dataSource: global.inspectionChartData,
                  //     xValueMapper: (InspectionChartData data, _) =>
                  //         DateFormat('dd-MM').format(
                  //           data.getDate,
                  //         ),
                  //     yValueMapper: (InspectionChartData data, _) =>
                  //         data.getRationDefectAfterRepaire.toStringAsFixed(2))
                ]),
          )),
    );
  }

  buildSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Line : ",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          width: 50,
        ),
        DropdownButton<String>(
          // icon: Icon(Icons.arrow_circle_down),
          value: global.currentLine.toString(),
          items: lines.map<DropdownMenuItem<String>>((int value) {
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
              global.currentLine = int.parse(newValue!);
            });
          },
        ),
        SizedBox(
          width: 50,
        ),
        Row(
          children: [
            Text('Khoảng thời gian hiển thị dữ liệu : '),
            DropdownButton<String>(
              // icon: Icon(Icons.arrow_circle_down),
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
                });
              },
            ),
            Text(' ngày')
          ],
        ),
      ],
    );
  }
}
