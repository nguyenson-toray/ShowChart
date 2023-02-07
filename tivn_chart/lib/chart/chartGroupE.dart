import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class ChartGroupE {
  DateTime date;
  int line;
  num f1;
  num f2;
  num f3;
  num f4;
  num f5;
  num f6;
  num f7;

  ChartGroupE({
    required this.date,
    this.line = 1,
    this.f1 = 0,
    this.f2 = 0,
    this.f3 = 0,
    this.f4 = 0,
    this.f5 = 0,
    this.f6 = 0,
    this.f7 = 0,
  });
  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getE1 => this.f1;

  set setE1(f1) => this.f1 = f1;

  get getE2 => this.f2;

  set setE2(f2) => this.f2 = f2;

  get getE3 => this.f3;

  set setE3(f3) => this.f3 = f3;

  get getE4 => this.f4;

  set setE4(f4) => this.f4 = f4;

  get getE5 => this.f5;

  set setE5(f5) => this.f5 = f5;

  get getE6 => this.f6;

  set setE6(f6) => this.f6 = f6;

  get getE7 => this.f7;

  set setE7(f7) => this.f7 = f7;

  Widget createChartUI(List<ChartGroupE> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(
        text: global.listGroupDefectJP[4] + '-' + global.listGroupDefect[4],
        textStyle: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
      backgroundColor: Colors.white,
      legend: Legend(
          textStyle: TextStyle(
              fontSize: 7, fontWeight: FontWeight.normal, color: Colors.black),
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 1),
        opposedPosition: false,
        minimum: 0,
        // maximum: 50,
        interval: 10,
        // labelFormat: '{value}Pcs',
      ),
      series: getSeries(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getSeries(List<ChartGroupE> dataInput) {
    return <ChartSeries<ChartGroupE, String>>[
      LineSeries<ChartGroupE, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE1,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![0] +
              '-' +
              global.defectNames['Lỗi may đan']![0],
          color: Colors.blue[400],
          width: 2),
      LineSeries<ChartGroupE, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE2,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![1] +
              '-' +
              global.defectNames['Lỗi may đan']![1],
          color: Colors.red,
          width: 2),
      LineSeries<ChartGroupE, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE3,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![2] +
              '-' +
              global.defectNames['Lỗi may đan']![2],
          color: Colors.grey,
          width: 2),
      LineSeries<ChartGroupE, String>(
          markerSettings: MarkerSettings(
              isVisible: true, shape: DataMarkerType.invertedTriangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE4,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![3] +
              '-' +
              global.defectNames['Lỗi may đan']![3],
          color: Colors.yellow,
          width: 2),
      LineSeries<ChartGroupE, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE5,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![4] +
              '-' +
              global.defectNames['Lỗi may đan']![4],
          color: Colors.blue[900],
          width: 2),
      LineSeries<ChartGroupE, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE6,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![5] +
              '-' +
              global.defectNames['Lỗi may đan']![5],
          color: Colors.green,
          width: 2),
      LineSeries<ChartGroupE, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.triangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupE data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupE data, _) => data.getE7,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNamesJP['Lỗi may đan']![6] +
              '-' +
              global.defectNames['Lỗi may đan']![6],
          color: Colors.teal,
          width: 2),
    ];
  }

  //create data for chart
  List<ChartGroupE> createChartData(List<T011stInspectionData> input, int line,
      int rangeDays, int inspectionType) {
    List<T011stInspectionData> t01Filtered = [];
    List<ChartGroupE> result = <ChartGroupE>[];
    List<ChartGroupE> temp = <ChartGroupE>[];
    late DateTime beginDate;
    beginDate = global.today.subtract(Duration(days: rangeDays));
    late DateTime day;
    if (rangeDays == 0) //all days
      t01Filtered = input;
    else {
      // filer range day
      input.forEach((element) {
        day = DateTime.parse(element.getX02.toString());
        if (day.isAfter(beginDate)) {
          t01Filtered.add(element);
        }
      });
    }
    //filter line
    if (line != 0) t01Filtered.removeWhere((element) => element.getX01 != line);
    //filter inspection type
    t01Filtered
        .removeWhere((element) => element.getSecondary != inspectionType);
    t01Filtered.forEach((element) {
      day = DateTime.parse(element.getX02.toString());
      ChartGroupE row = new ChartGroupE(date: day);

      row.setLine = element.getX01;
      row.setE1 = element.getE1;
      row.setE2 = element.getE2;
      row.setE3 = element.getE3;
      row.setE4 = element.getE4;
      row.setE5 = element.getE5;
      row.setE6 = element.getE6;
      row.setE7 = element.getE7;

      temp.add(row);
    });
    List<DateTime> days = [];
    for (var k = 0; k < temp.length; k++) {
      days.add(temp[k].getDate);
    }
    days.toSet().toList(); // remove duplicate
    days.sort((a, b) {
      //sorting in descending order
      return a.compareTo(b);
    });

    for (var i = 0; i < days.length; i++) {
      var rowData = ChartGroupE(date: days[i]);
      for (var j = 0; j < temp.length; j++) {
        if (days[i] == temp[j].getDate) {
          rowData.setE1 = temp[j].getE1 + rowData.getE1;
          rowData.setE2 = temp[j].getE2 + rowData.getE2;
          rowData.setE3 = temp[j].getE3 + rowData.getE3;
          rowData.setE4 = temp[j].getE4 + rowData.getE4;
          rowData.setE5 = temp[j].getE5 + rowData.getE5;
          rowData.setE6 = temp[j].getE6 + rowData.getE6;
          rowData.setE7 = temp[j].getE7 + rowData.getE7;
        }
      }
      result.add(rowData);
    }
    return result;
  }
}
