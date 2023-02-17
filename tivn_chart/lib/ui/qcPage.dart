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
  int actual = 0;
  int sumDefect = 0;
  double rationDefect = 0;
  bool buttonFinishVisible = true;

  refresh(T011stInspectionData a) {
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
      if (global.needUpdateSQL) {
        print(
            '${DateTime.now().toString()}  Update Inspection Data From Local to SQL server : ${global.t01SummaryByInspectionSetting.toString()}');
        await global.mySqlServer
            .updateInspectionDataToT01(global.t01SummaryByInspectionSetting);
        setState(() {
          global.needUpdateSQL = false;
        });
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
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                WorkSettingWiget(callback: refresh),
                createSummaryChart(),
                Divider(
                  color: global.needUpdateSQL
                      ? Colors.yellow
                      : Colors.teal.shade100,
                  thickness: 3.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                inputInspection(),

                // (global.result == 'LỖI' && global.defectTotal.length > 0)
                //     ? Container(
                //         alignment: Alignment.centerLeft,
                //         child: Text(
                //           'LỖI : ${global.defectTotal}\r\nMô tả : ${global.commentTotal}',
                //           textAlign: TextAlign.left,
                //         ),
                //       )
                //     : Container(),
                Divider(
                  color: global.needUpdateSQL
                      ? Colors.yellow
                      : Colors.teal.shade100,
                  thickness: 3.0,
                ),
                // showData()
                Container(
                    child: ListViewData(
                        data: global.t01sFilteredByInspectionSetting))
                // global.t01sFilteredByInspectionSetting.toList()))
              ],
            ),
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
        /*
    GridColumn(
        columnName: 'date',
        label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text('Date'))),
    GridColumn(
        columnName: 'line',
        width: 50,
        label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text('Line'))),
    GridColumn(
        columnName: 'customer',
        width: 150,
        label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text('Customer'))),
    */
        // GridColumn(
        //     columnName: 'style',
        //     width: 150,
        //     label: Container(
        //         padding: EdgeInsets.all(8.0),
        //         alignment: Alignment.center,
        //         child: Text(
        //           'Style',
        //           overflow: TextOverflow.ellipsis,
        //         ))),
        // GridColumn(
        //     columnName: 'color',
        //     label: Container(
        //         padding: EdgeInsets.all(8.0),
        //         alignment: Alignment.center,
        //         child: Text('Color'))),
        // GridColumn(
        //     columnName: 'size',
        //     width: 50,
        //     label: Container(
        //         padding: EdgeInsets.all(8.0),
        //         alignment: Alignment.center,
        //         child: Text('Size'))),
        /*
    GridColumn(
        columnName: 'spectionFirstSecond',
        width: 50,
        label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text('Lần KT'))),
    GridColumn(
        columnName: 'quantity',
        width: 60,
        label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text('Số lượng'))),
    */
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

  Widget createSummaryChart() {
    List<T011stInspectionData> data = [];
    data.add(global.t01SummaryByInspectionSetting);
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SfCartesianChart(
            // title: ChartTitle(text: "Kết quả kiểm hàng"),
            legend: Legend(
              isVisible: true,
            ), //ten mau
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
                  xValueMapper: (T011stInspectionData data, _) => data.getX02,
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
                  xValueMapper: (T011stInspectionData data, _) => data.getX02,
                  yValueMapper: (T011stInspectionData data, _) => data.getX06,
                  name: 'Thực tế',
                  color: Colors.orange,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      // Positioning the data label
                      labelAlignment: ChartDataLabelAlignment.auto)),
              ColumnSeries<T011stInspectionData, String>(
                  dataSource: data,
                  xValueMapper: (T011stInspectionData data, _) => data.getX02,
                  yValueMapper: (T011stInspectionData data, _) => data.getX07,
                  name: 'Đạt',
                  color: Colors.green,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      // Positioning the data label
                      labelAlignment: ChartDataLabelAlignment.auto)),
              ColumnSeries<T011stInspectionData, String>(
                  dataSource: data,
                  xValueMapper: (T011stInspectionData data, _) => data.getX02,
                  yValueMapper: (T011stInspectionData data, _) => data.getX11,
                  name: 'Lỗi',
                  color: Color.fromARGB(255, 248, 17, 13),
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.auto)),
            ],
          ),
          SizedBox(
            width: 60,
            child: CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 20.0,
              percent: global.t01SummaryByInspectionSetting.getX11 /
                  global.t01SummaryByInspectionSetting.getX06,
              header: Text("Tỉ lệ lỗi"),
              center: Text(
                global.t01SummaryByInspectionSetting.getX06 > 0
                    ? '${(global.t01SummaryByInspectionSetting.getX11 / global.t01SummaryByInspectionSetting.getX06 * 100).toStringAsFixed(2)} %'
                    : "0 %",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black12,
              progressColor: Colors.red,
            ),
          ),
          // Icon(
          //   size: 40,
          //   Icons.upload_file,
          //   color: global.needUpdateSQL ? Colors.yellow : Colors.green,
          // ),
        ],
      ),
    );
  }

  /*

  void createInspectionDataRow() {
    // var output = T011stInspectionData();
    global.t01InspectionData.setX02 = global.todayString;
    var defects = global.defectTotal.split(' - ').toList();
    var groups = global.groupDefectNameTotal.split(' - ').toList();
    switch (global.isRecheck) {
      case 1:
        {
          global.t01InspectionData.setX06 = global.t01InspectionData.getX06 + 1;
          if (global.result == 'ĐẠT') {
            global.t01InspectionData.setX07 =
                global.t01InspectionData.getX07 + 1;
          } else {
            // global.t01InspectionData.setXc=
            defects.forEach((defect) {
              print('defects.forEach((defect) :' + defect);
              switch (defect) {
                case 'Lỗi thông số':
                  global.t01InspectionData.setA1 =
                      global.t01InspectionData.getA1 + 1;
                  break;
                case 'Lệch trái phải':
                  global.t01InspectionData.setA1 =
                      global.t01InspectionData.getA2 + 1;
                  break;
                case 'Thông số  kéo căng':
                  global.t01InspectionData.setA3 =
                      global.t01InspectionData.getA3 + 1;
                  break;
                // B
                case 'Dây kéo':
                  global.t01InspectionData.setB1 =
                      global.t01InspectionData.getB1 + 1;
                  break;
                case 'Nút':
                  global.t01InspectionData.setB2 =
                      global.t01InspectionData.getB2 + 1;
                  break;
                case 'Khác':
                  global.t01InspectionData.setB3 =
                      global.t01InspectionData.getB3 + 1;
                  break;
                // C
                case 'Bavia Gờ sắc nhọn':
                  global.t01InspectionData.setC1 =
                      global.t01InspectionData.getC1 + 1;
                  break;
                case 'Dị vật':
                  global.t01InspectionData.setC2 =
                      global.t01InspectionData.getC2 + 1;
                  break;
                // D
                case 'Khác màu, nhuộm':
                  global.t01InspectionData.setD1 =
                      global.t01InspectionData.getD1 + 1;
                  break;
                case 'Sợi màu':
                  global.t01InspectionData.setD2 =
                      global.t01InspectionData.getD2 + 1;
                  break;
                case 'Vón cục, nút thắt':
                  global.t01InspectionData.setD3 =
                      global.t01InspectionData.getD3 + 1;
                  break;
                case 'Sợi màu':
                  global.t01InspectionData.setD4 =
                      global.t01InspectionData.getD4 + 1;
                  break;
                //e
                case 'May, đứt chỉ':
                  global.t01InspectionData.setE1 =
                      global.t01InspectionData.getE1 + 1;
                  break;
                case 'Bung tưa, lỏng chỉ':
                  global.t01InspectionData.setE2 =
                      global.t01InspectionData.getE2 + 1;
                  break;
                case 'Lỗ kim':
                  global.t01InspectionData.setE3 =
                      global.t01InspectionData.getE3 + 1;
                  break;
                case 'Bỏ mũi, sụp mí':
                  global.t01InspectionData.setE4 =
                      global.t01InspectionData.getE4 + 1;
                  break;

                case 'May vặn':
                  global.t01InspectionData.setE5 =
                      global.t01InspectionData.getE5 + 1;
                  break;
                case 'Xước sợi, rút sợi':
                  global.t01InspectionData.setE6 =
                      global.t01InspectionData.getE6 + 1;
                  break;
                case 'Bọ':
                  global.t01InspectionData.setE7 =
                      global.t01InspectionData.getE7 + 1;
                  break;
                //F
                case 'Chỉ lượt, sót chỉ':
                  global.t01InspectionData.setF1 =
                      global.t01InspectionData.getF1 + 1;
                  break;
                case 'Dơ':
                  global.t01InspectionData.setF2 =
                      global.t01InspectionData.getF2 + 1;
                  break;
                case 'Dấu phấn':
                  global.t01InspectionData.setF3 =
                      global.t01InspectionData.getF3 + 1;
                  break;
                case 'In, ép':
                  global.t01InspectionData.setF4 =
                      global.t01InspectionData.getF4 + 1;
                  break;
                case 'Biến dạng':
                  global.t01InspectionData.setF5 =
                      global.t01InspectionData.getF5 + 1;
                  break;
                case 'Nhăn':
                  global.t01InspectionData.setF6 =
                      global.t01InspectionData.getF6 + 1;
                  break;
                case 'Cấn bóng':
                  global.t01InspectionData.setF7 =
                      global.t01InspectionData.getF7 + 1;
                  break;
                case 'Le mí':
                  global.t01InspectionData.setF8 =
                      global.t01InspectionData.getF8 + 1;
                  break;
                case 'Seam':
                  global.t01InspectionData.setF9 =
                      global.t01InspectionData.getF9 + 1;
                  break;
                //G
                case 'Thẻ bài':
                  global.t01InspectionData.setG1 =
                      global.t01InspectionData.getG1 + 1;
                  break;
                case 'Nhãn giặt':
                  global.t01InspectionData.setG2 =
                      global.t01InspectionData.getG2 + 1;
                  break;
                case 'Nhãn khác':
                  global.t01InspectionData.setG3 =
                      global.t01InspectionData.getG3 + 1;
                  break;
                case 'Lỗi khác':
                  global.t01InspectionData.setH =
                      global.t01InspectionData.getH + 1;
                  break;
              }
            });

            // global.inspectionDetail.setGroupDefect =
            //     global.currentGroupDefectName;
          }

          global.t01InspectionData.setSumA = global.t01InspectionData.getA1 +
              global.t01InspectionData.getA2 +
              global.t01InspectionData.getA3;

          global.t01InspectionData.setSumB = global.t01InspectionData.getB1 +
              global.t01InspectionData.getB2 +
              global.t01InspectionData.getB3;

          global.t01InspectionData.setSumC =
              global.t01InspectionData.getC1 + global.t01InspectionData.getC2;

          global.t01InspectionData.setSumD = global.t01InspectionData.getD1 +
              global.t01InspectionData.getD2 +
              global.t01InspectionData.getD3 +
              global.t01InspectionData.getD4;

          global.t01InspectionData.setSumE = global.t01InspectionData.getE1 +
              global.t01InspectionData.getE2 +
              global.t01InspectionData.getE3 +
              global.t01InspectionData.getE4 +
              global.t01InspectionData.getE5 +
              global.t01InspectionData.getE6 +
              global.t01InspectionData.getE7;

          global.t01InspectionData.setSumF = global.t01InspectionData.getF1 +
              global.t01InspectionData.getF2 +
              global.t01InspectionData.getF3 +
              global.t01InspectionData.getF4 +
              global.t01InspectionData.getF5 +
              global.t01InspectionData.getF6 +
              global.t01InspectionData.getF7 +
              global.t01InspectionData.getF8 +
              global.t01InspectionData.getF9;

          global.t01InspectionData.setSumG = global.t01InspectionData.getG1 +
              global.t01InspectionData.getG2 +
              global.t01InspectionData.getG3;

          global.t01InspectionData.setTotal = global.t01InspectionData.getSumA +
              global.t01InspectionData.getSumB +
              global.t01InspectionData.getSumC +
              global.t01InspectionData.getSumD +
              global.t01InspectionData.getSumE +
              global.t01InspectionData.getSumF +
              global.t01InspectionData.getSumG;
        }
        break;
      case 2:
        {
          global.t01InspectionData.setX08 = global.t01InspectionData.getX08 + 1;
          if (global.result == 'ĐẠT') {
            print('L2 dat');
            global.t01InspectionData.setX09 =
                global.t01InspectionData.getX09 + 1;
          } else {
            print('L2 LOI - HANG C');
            global.t01InspectionData.setX10 =
                global.t01InspectionData.getX10 + 1;
          }
          break;
        }
    }
    global.t01InspectionData.setX11 =
        global.t01InspectionData.getX06 - global.t01InspectionData.getX07;
    global.t01InspectionData.setX12 =
        global.t01InspectionData.getX08 - global.t01InspectionData.getX09;
    global.t01InspectionData.setTF =
        global.t01InspectionData.getX11 + global.t01InspectionData.getX12;
    global.t01InspectionData.setTMonth = global.today.month;
    global.t01InspectionData.setTYear = global.today.year;
    // return output;
  }
*/

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
                      global.isRecheck = false;
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
                      global.isRecheck = true;
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
                      global.isRecheck = true;
                    });
                    showAlertTypeC();
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
          MyFuntions.saveData();
          global.totalChecked = 0;
          Navigator.of(context).pop();
        });
      },
      onCancelBtnTap: () {
        global.result = 'LỖI';
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/InputInspectionPage');
      },
    );
  }

  void showAlertTypeC() async {
    global.totalChecked = 1;
    return QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Nhập số lượng hàng C ?',
        cancelBtnText: 'Bỏ qua',
        confirmBtnText: 'OK',
        onCancelBtnTap: () {
          setState(() {
            global.isTypeC = false;
            global.totalChecked = 0;
          });

          Navigator.of(context).pop();
        },
        onConfirmBtnTap: () {
          setState(() {
            global.isTypeC = true;
            MyFuntions.saveData();
            global.totalChecked = 0;
            global.isTypeC = false;
          });
          Navigator.of(context).pop();
        },
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
        ));
  }
}
