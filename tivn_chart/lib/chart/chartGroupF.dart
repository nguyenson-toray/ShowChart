import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class ChartGroupF {
  DateTime date;
  int line;
  num f1;
  num f2;
  num f3;
  num f4;
  num f5;
  num f6;
  num f7;
  num f8;
  num f9;
  ChartGroupF({
    required this.date,
    this.line = 1,
    this.f1 = 0,
    this.f2 = 0,
    this.f3 = 0,
    this.f4 = 0,
    this.f5 = 0,
    this.f6 = 0,
    this.f7 = 0,
    this.f8 = 0,
    this.f9 = 0,
  });
  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getF1 => this.f1;

  set setF1(f1) => this.f1 = f1;

  get getF2 => this.f2;

  set setF2(f2) => this.f2 = f2;

  get getF3 => this.f3;

  set setF3(f3) => this.f3 = f3;

  get getF4 => this.f4;

  set setF4(f4) => this.f4 = f4;

  get getF5 => this.f5;

  set setF5(f5) => this.f5 = f5;

  get getF6 => this.f6;

  set setF6(f6) => this.f6 = f6;

  get getF7 => this.f7;

  set setF7(f7) => this.f7 = f7;

  get getF8 => this.f8;

  set setF8(f8) => this.f8 = f8;

  get getF9 => this.f9;

  set setF9(f9) => this.f9 = f9;

  Widget createChartUI(List<ChartGroupF> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(text: global.listGroupDefect[5]),
      backgroundColor: Colors.white,
      legend: Legend(
          textStyle: TextStyle(
              fontSize: 8, fontWeight: FontWeight.normal, color: Colors.black),
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        // majorGridLines: const MajorGridLines(width: 0),
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

  getSeries(List<ChartGroupF> dataInput) {
    return <ChartSeries<ChartGroupF, String>>[
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF1,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![0],
          color: Colors.blue[400],
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF2,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![1],
          color: Colors.red,
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF3,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![2],
          color: Colors.grey,
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings: MarkerSettings(
              isVisible: true, shape: DataMarkerType.invertedTriangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF4,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![3],
          color: Colors.yellow,
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF5,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![4],
          color: Colors.blue[900],
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF6,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![5],
          color: Colors.green,
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.triangle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF7,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![6],
          color: Colors.teal,
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF8,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![7],
          color: Colors.orange,
          width: 4),
      LineSeries<ChartGroupF, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupF data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupF data, _) => data.getF9,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: global.defectNames['Ngoại quan, thành phẩm']![8],
          color: Colors.amber,
          width: 4),
    ];
  }

  //create data for chart
  List<ChartGroupF> createChartData(List<T011stInspectionData> input, int line,
      int rangeDays, int inspectionType) {
    List<T011stInspectionData> t01Filtered = [];
    List<ChartGroupF> result = <ChartGroupF>[];
    List<ChartGroupF> temp = <ChartGroupF>[];
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
      ChartGroupF row = new ChartGroupF(date: day);

      row.setLine = element.getX01;
      row.setF1 = element.getF1;
      row.setF2 = element.getF2;
      row.setF3 = element.getF3;
      row.setF4 = element.getF4;
      row.setF5 = element.getF5;
      row.setF6 = element.getF6;
      row.setF7 = element.getF7;
      row.setF8 = element.getF8;
      row.setF9 = element.getF9;
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
      var rowData = ChartGroupF(date: days[i]);
      for (var j = 0; j < temp.length; j++) {
        if (days[i] == temp[j].getDate) {
          rowData.setF1 = temp[j].getF1 + rowData.getF1;
          rowData.setF2 = temp[j].getF2 + rowData.getF2;
          rowData.setF3 = temp[j].getF3 + rowData.getF3;
          rowData.setF4 = temp[j].getF4 + rowData.getF4;
          rowData.setF5 = temp[j].getF5 + rowData.getF5;
          rowData.setF6 = temp[j].getF6 + rowData.getF6;
          rowData.setF7 = temp[j].getF7 + rowData.getF7;
          rowData.setF8 = temp[j].getF8 + rowData.getF8;
          rowData.setF9 = temp[j].getF9 + rowData.getF9;
        }
      }
      result.add(rowData);
    }
    return result;
  }
}
