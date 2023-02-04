import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class ChartGroupAll {
  DateTime date;
  int line;
  num groupA;
  num groupB;
  num groupC;
  num groupD;
  num groupE;
  num groupF;
  num groupG;
  num groupH;
  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getGroupA => this.groupA;

  set setGroupA(groupA) => this.groupA = groupA;

  get getGroupB => this.groupB;

  set setGroupB(groupB) => this.groupB = groupB;

  get getGroupC => this.groupC;

  set setGroupC(groupC) => this.groupC = groupC;

  get getGroupD => this.groupD;

  set setGroupD(groupD) => this.groupD = groupD;

  get getGroupE => this.groupE;

  set setGroupE(groupE) => this.groupE = groupE;

  get getGroupF => this.groupF;

  set setGroupF(groupF) => this.groupF = groupF;

  get getGroupG => this.groupG;

  set setGroupG(groupG) => this.groupG = groupG;

  get getGroupH => this.groupH;

  set setGroupH(groupH) => this.groupH = groupH;
  ChartGroupAll({
    required this.date,
    this.line = 1,
    this.groupA = 0,
    this.groupB = 0,
    this.groupC = 0,
    this.groupD = 0,
    this.groupE = 0,
    this.groupF = 0,
    this.groupG = 0,
    this.groupH = 0,
  });
  Widget createChartUI(List<ChartGroupAll> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Nhóm lỗi'),
      backgroundColor: Colors.white,
      legend: Legend(
          textStyle: TextStyle(
              fontSize: 8, fontWeight: FontWeight.normal, color: Colors.black),
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap), //ten m
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          opposedPosition: false,
          majorGridLines: const MajorGridLines(width: 1),
          minimum: 0,
          // maximum: 100,
          interval: 10),

      series: getSeries(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getSeries(List<ChartGroupAll> dataInput) {
    return <ChartSeries<ChartGroupAll, String>>[
      LineSeries<ChartGroupAll, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupA,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[0],
          color: Colors.blue[400],
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupB,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[1],
          color: Colors.red,
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings: MarkerSettings(
              isVisible: true, shape: DataMarkerType.invertedTriangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupC,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[2],
          color: Colors.grey,
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupD,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[3],
          color: Colors.yellow,
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupE,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[4],
          color: Colors.blue[900],
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.triangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupF,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[5],
          color: Colors.green,
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupG,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[6],
          color: Colors.teal,
          width: 4),
      LineSeries<ChartGroupAll, String>(
          markerSettings: MarkerSettings(isVisible: true),
          dataSource: dataInput,
          xValueMapper: (ChartGroupAll data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupAll data, _) => data.getGroupH,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.listGroupDefect[7],
          color: Colors.orange,
          width: 4),
    ];
  }

  //create data for chart
  List<ChartGroupAll> createChartData(List<T011stInspectionData> input,
      int line, int rangeDays, int inspectionType) {
    List<T011stInspectionData> t01Filtered = [];
    List<ChartGroupAll> result = <ChartGroupAll>[];
    List<ChartGroupAll> temp = <ChartGroupAll>[];
    late DateTime beginDate;
    beginDate = global.today.subtract(Duration(days: rangeDays));
    late DateTime day;
    if (input.length == 0) return result;
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
      ChartGroupAll row = new ChartGroupAll(date: day);
      row.setLine = element.getX01;
      row.setGroupA = element.getSumA;
      row.setGroupB = element.getSumB;
      row.setGroupC = element.getSumC;
      row.setGroupD = element.getSumD;
      row.setGroupE = element.getSumE;
      row.setGroupF = element.getSumF;
      row.setGroupG = element.getSumG;
      row.setGroupH = element.getH;
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
      var rowData = ChartGroupAll(date: days[i]);
      for (var j = 0; j < temp.length; j++) {
        if (days[i] == temp[j].getDate) {
          rowData.setGroupA = temp[j].getGroupA + rowData.getGroupA;
          rowData.setGroupB = temp[j].getGroupB + rowData.getGroupB;
          rowData.setGroupC = temp[j].getGroupC + rowData.getGroupC;
          rowData.setGroupD = temp[j].getGroupD + rowData.getGroupD;
          rowData.setGroupE = temp[j].getGroupE + rowData.getGroupE;
          rowData.setGroupF = temp[j].getGroupF + rowData.getGroupF;
          rowData.setGroupG = temp[j].getGroupG + rowData.getGroupG;
          rowData.setGroupH = temp[j].getGroupH + rowData.getGroupH;
        }
      }
      result.add(rowData);
    }
    return result;
  }
}
