import 'dart:async';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataClass/inspectionDetail.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/ui/listViewData.dart';
import 'package:tivn_chart/ui/workSettingWidget.dart';
import 'package:tivn_chart/ui/inspectionDataSource.dart';
import 'package:tivn_chart/global.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickalert/quickalert.dart';

class QcPage extends StatefulWidget {
  const QcPage({super.key});

  @override
  State<QcPage> createState() => QcPageState();
}

class QcPageState extends State<QcPage> {
  int wChart = 300;
  int actual = 0;
  int sumDefect = 0;
  double rationDefect = 0;
  bool buttonFinishVisible = true;
  ChartSeriesController? chartSeriesController;

  refreshT01(T011stInspectionData a) {
    setState(() {});
  }

  refreshListT01(List<T011stInspectionData> a) {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showAlertOKorDefect();
    // });
    global.t04s.forEach((element) {
      var date = element.getX021;
      if (date == global.todayString &&
          element.getX011 == global.inspectionSetting.getLine) {
        global.planToday = element.getX13; //so luong ke hoach
        print(
            'Line ${global.inspectionSetting.getLine} - plan today: ${global.planToday.toString()} pcs');
      }
    });
    Timer.periodic(new Duration(seconds: global.secondsAutoUpdateDataToSQL),
        (timer) async {
      if (global.needUpdateSQL &&
          global.t01SummaryByInspectionSetting.getX01 != '') {
        global.needUpdateSQL = !await global.mySqlServer
            .updateInspectionDataToT01(global.t01SummaryByInspectionSetting);
      }
    });
    global.t01sFilteredByInspectionSetting =
        MyFuntions.t01FilterByLastInspectionSetting(
            global.t01sLocal, global.inspectionSetting);
    global.t01SummaryByInspectionSetting =
        MyFuntions.t01sSummaryByLastInspectionSetting(
            global.t01sFilteredByInspectionSetting, global.inspectionSetting);

    print(
        'initState-t01SummaryByInspectionSetting : ${global.t01SummaryByInspectionSetting.toString()}');

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return await showExitAppAlert();
        },
        child: Scaffold(
          backgroundColor: Colors.tealAccent[50],
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WorkSettingWiget(callback: refreshT01),
                global.needUpdateSQL
                    ? SizedBox(
                        height: 3,
                        child: LinearProgressIndicator(),
                      )
                    : Divider(
                        color: Colors.teal,
                        thickness: 3.0,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: wChart.toDouble(),
                        height: global.screenHPixel - 100,
                        child: createSummaryChart(
                            global.t01SummaryByInspectionSetting)),
                    SizedBox(
                      width: global.screenWPixel - wChart - 20,
                      height: global.screenHPixel - 100,
                      child: ListViewData(callback: refreshT01),
                    )
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(
              Icons.add,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                global.checkNo = 1;
                showAlertOKorDefect();
              });
            },
          ),
        ),
      ),
    );
  }

  dynamic selectGroupDefect(String groupDefectName) {
    late var defects = <String>[];
    String defect = '';
    if (groupDefectName == global.listGroupDefect[0]) {
      defects = global.groupDefectParameter;
    } else if (groupDefectName == global.listGroupDefect[1]) {
      defects = global.groupDefectAccessories;
    } else if (groupDefectName == global.listGroupDefect[2]) {
      defects = global.groupDefectDanger;
    } else if (groupDefectName == global.listGroupDefect[3]) {
      defects = global.groupDefectFabric;
    } else if (groupDefectName == global.listGroupDefect[4]) {
      defects = global.groupDefectSewingKnitting;
    } else if (groupDefectName == global.listGroupDefect[5]) {
      defects = global.groupDefectAppearenceFinished;
    } else if (groupDefectName == global.listGroupDefect[6]) {
      defects = global.groupDefectMaterial;
    } else
      defects = global.groupDefectOther;

    defect = defects[0];
    return defects;
  }

  showDefect() {
    global.currentDefects = selectGroupDefect(global.currentGroupDefectName);
    return Row(
      children: [
        Text("Nhóm lỗi : "),
        DropdownButton<String>(
          value: global.currentGroupDefectName,
          items: global.listGroupDefect
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            print('Group Onchange');
            setState(() {
              global.currentGroupDefectName = newValue.toString();
              global.currentDefects =
                  selectGroupDefect(global.currentGroupDefectName);
              global.currentDefect = global.currentDefects[0];
            });
          },
        ),
        SizedBox(
          width: 20,
        ),
        Text("Lỗi : "),
        DropdownButton<String>(
          value: global.currentDefect,
          items: global.currentDefects
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              global.currentDefect = newValue.toString();
            });
          },
        )
      ],
    );
  }

  Widget showData() {
    return SfDataGrid(
      columns: <GridColumn>[
        GridColumn(
            columnName: 'time',
            width: 140,
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'Thời gian',
                ))),
        GridColumn(
            columnName: '1or2',
            width: 80,
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'Lần KT',
                ))),
        GridColumn(
            columnName: 'result',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('Kết quả'))),
        GridColumn(
            columnName: 'groupDefect',
            width: 180,
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('Nhóm lỗi'))),
        GridColumn(
            columnName: 'defect',
            width: 180,
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('Lỗi'))),
      ],
      source: inspectionDataSource(
          inspectionData: global.t01sFilteredByInspectionSetting),
    );
  }

  Widget createSummaryChart(T011stInspectionData dataInput) {
    print('createSummaryChart ');
    List<T011stInspectionData> data = [];
    data.add(global.t01SummaryByInspectionSetting);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: global.screenHPixel - 210,
              child: SfCartesianChart(
                // title: ChartTitle(text: "Kết quả kiểm hàng"),
                legend: Legend(
                    height: '45%',
                    position: LegendPosition.bottom,
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap), //ten mau
                // Enable tooltip
                // tooltipBehavior: TooltipBehavior(enable: true),
                // borderWidth: 2,
                primaryXAxis: CategoryAxis(labelRotation: 0),
                primaryYAxis: NumericAxis(
                    minimum: 0, //maximum: 250,
                    interval: 10),
                series: <ChartSeries<T011stInspectionData, String>>[
                  ColumnSeries<T011stInspectionData, String>(
                      dataSource: data,
                      xValueMapper: (T011stInspectionData data, _) =>
                          data.getX02,
                      yValueMapper: (T011stInspectionData data, _) =>
                          global.planToday,
                      name: 'Kế hoạch',
                      color: Colors.blue,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.auto)),
                  ColumnSeries<T011stInspectionData, String>(
                      dataSource: data,
                      xValueMapper: (T011stInspectionData data, _) =>
                          data.getX02,
                      yValueMapper: (T011stInspectionData data, _) =>
                          data.getX06,
                      name: 'Thực tế',
                      color: Colors.orange,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.auto)),
                  ColumnSeries<T011stInspectionData, String>(
                      dataSource: data,
                      xValueMapper: (T011stInspectionData data, _) =>
                          data.getX02,
                      yValueMapper: (T011stInspectionData data, _) =>
                          data.getX07,
                      name: 'Đạt lần 1',
                      color: Colors.green,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.auto)),
                  ColumnSeries<T011stInspectionData, String>(
                      dataSource: data,
                      xValueMapper: (T011stInspectionData data, _) =>
                          data.getX02,
                      yValueMapper: (T011stInspectionData data, _) =>
                          data.getX11,
                      name: 'Lỗi lần 1',
                      color: Colors.red,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.auto)),
                  ColumnSeries<T011stInspectionData, String>(
                      dataSource: data,
                      xValueMapper: (T011stInspectionData data, _) =>
                          data.getX02,
                      yValueMapper: (T011stInspectionData data, _) =>
                          data.getX08,
                      name: 'Kiểm lần 2',
                      color: Colors.tealAccent,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.auto)),
                  ColumnSeries<T011stInspectionData, String>(
                      dataSource: data,
                      xValueMapper: (T011stInspectionData data, _) =>
                          data.getX02,
                      yValueMapper: (T011stInspectionData data, _) =>
                          data.getX09,
                      name: 'Đạt sau sửa hàng',
                      color: Colors.amber,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.auto)),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(5),
          width: global.screenWPixel * 0.3,
          height: 110,
          child: CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 20.0,
            percent: global.t01SummaryByInspectionSetting.getX11 /
                global.t01SummaryByInspectionSetting.getX06,
            header: Text("Tỉ lệ % lỗi"),
            center: Text(
              global.t01SummaryByInspectionSetting.getX06 > 0
                  ? '${(global.t01SummaryByInspectionSetting.getX11 / global.t01SummaryByInspectionSetting.getX06 * 100).toStringAsFixed(2)}'
                  : "0",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black12,
            progressColor: Colors.red,
          ),
        ),
      ],
    );
  }

  showExitAppAlert() async {
    await QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Bạn có muốn thoát ứng dụng',
        // text: 'Bạn có muốn thoát ứng dụng',
        confirmBtnText: 'Có',
        cancelBtnText: 'Không',
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () => SystemNavigator.pop());
  }

  inputInspection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[300])),
                  icon: Icon(Icons.add_circle),
                  label: Container(
                      width: 115,
                      child: Text("Kiểm tra lần 1",
                          style: TextStyle(fontSize: 18))),
                  onPressed: () async {
                    setState(() {
                      global.checkNo = 1;
                    });
                    showAlertOKorDefect();
                  }),
              SizedBox(
                width: 50,
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[400])),
                  icon: Icon(Icons.add_circle),
                  label: Container(
                      width: 115,
                      child: Text("Tái kiểm", style: TextStyle(fontSize: 18))),
                  onPressed: () async {
                    setState(() {
                      global.checkNo = 2;
                    });
                    showAlertOKorDefect();
                  }),
              SizedBox(
                width: 50,
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  icon: Icon(Icons.bug_report),
                  label: Container(
                      width: 80,
                      child: Text("Hàng C", style: TextStyle(fontSize: 18))),
                  onPressed: () async {
                    setState(() {
                      global.checkNo = 2;
                    });
                    // showAlertTypeC();
                  }),
            ],
          ),
        ],
      ),
    );
  }

  showAlertOKorDefect() async {
    global.totalChecked = 1;
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      widget: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (global.totalChecked > 1) global.totalChecked--;
                  });
                },
                child: Icon(Icons.remove, size: 40, color: Colors.redAccent),
              ),
              CircleAvatar(
                maxRadius: 14,
                child: Text(
                  global.totalChecked.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    global.totalChecked++;
                  });
                },
                child: Icon(Icons.add, size: 40, color: Colors.greenAccent),
              ),
            ],
          );
        },
      ),
      title: 'ĐẠT hay LỖI ?',
      cancelBtnText: 'LỖI',
      confirmBtnText: 'ĐẠT',
      onConfirmBtnTap: () {
        setState(() {
          // global.confirmYes = true;

          global.defectTotal = '';
          // global.groupDefectNameTotal = '';
          // global.currentDefect = 'Lỗi thông số';
          // global.currentGroupDefectName = 'Thông số';
          global.result = 'ĐẠT';
          MyFuntions.saveNewT01();
          global.totalChecked = 0;
          Navigator.of(context).pop();
        });
      },
      onCancelBtnTap: () {
        global.result = 'LỖI';
        Navigator.of(context).popAndPushNamed('/InputInspectionPage');
      },
    );
  }
}
