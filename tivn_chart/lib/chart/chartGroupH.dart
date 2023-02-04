import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class ChartGroupH {
  DateTime date;
  int line;
  num h;
  ChartGroupH({
    required this.date,
    this.line = 1,
    this.h = 0,
  });
  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getH => this.h;

  set setH(h) => this.h = h;
  Widget createChartUI(List<ChartGroupH> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Lỗi khác'),
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

  getSeries(List<ChartGroupH> dataInput) {
    return <ChartSeries<ChartGroupH, String>>[
      LineSeries<ChartGroupH, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartGroupH data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartGroupH data, _) => data.getH,
          dataLabelSettings: DataLabelSettings(
              textStyle: TextStyle(fontSize: 15),
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto),
          name: 'Lỗi khác',
          color: Colors.blue[400],
          width: 4),
    ];
  }

  //create data for chart
  List<ChartGroupH> createChartData(List<T011stInspectionData> input, int line,
      int rangeDays, int inspectionType) {
    List<T011stInspectionData> t01Filtered = [];
    List<ChartGroupH> result = <ChartGroupH>[];
    List<ChartGroupH> temp = <ChartGroupH>[];
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
      ChartGroupH row = new ChartGroupH(date: day);

      row.setLine = element.getX01;
      row.setH = element.getH;

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
      var rowData = ChartGroupH(date: days[i]);
      for (var j = 0; j < temp.length; j++) {
        if (days[i] == temp[j].getDate) {
          rowData.setH = temp[j].getH + rowData.getH;
        }
      }
      result.add(rowData);
    }
    return result;
  }
}
