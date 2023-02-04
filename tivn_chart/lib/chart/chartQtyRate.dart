import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';

class ChartQtyRate {
  DateTime date;
  int line;
  num qty1st;
  num qty1stOK;
  num qty1stNOK;
  num qtyAfterRepaire;
  num qtyOKAfterRepaire;
  num rationDefect1st;
  num rationDefectAfterRepaire;
  get getDate => this.date;

  set setDate(date) => this.date = date;
  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getQty1st => this.qty1st;

  set setQty1st(qty1st) => this.qty1st = qty1st;

  get getQty1stOK => this.qty1stOK;

  set setQty1stOK(qty1stOK) => this.qty1stOK = qty1stOK;

  get getQty1stNOK => this.qty1stNOK;

  set setQty1stNOK(qty1stNOK) => this.qty1stNOK = qty1stNOK;

  get getQtyAfterRepaire => this.qtyAfterRepaire;

  set setQtyAfterRepaire(qtyAfterRepaire) =>
      this.qtyAfterRepaire = qtyAfterRepaire;

  get getQtyOKAfterRepaire => this.qtyOKAfterRepaire;

  set setQtyOKAfterRepaire(qtyOKAfterRepaire) =>
      this.qtyOKAfterRepaire = qtyOKAfterRepaire;

  get getRationDefect1st => this.rationDefect1st;

  set setRationDefect1st(rationDefect1st) =>
      this.rationDefect1st = rationDefect1st;

  get getRationDefectAfterRepaire => this.rationDefectAfterRepaire;

  set setRationDefectAfterRepaire(rationDefectAfterRepaire) =>
      this.rationDefectAfterRepaire = rationDefectAfterRepaire;

  ChartQtyRate({
    required this.date,
    this.line = 0,
    this.qty1st = 0,
    this.qty1stOK = 0,
    this.qty1stNOK = 0,
    this.qtyAfterRepaire = 0,
    this.qtyOKAfterRepaire = 0,
    this.rationDefect1st = 0,
    this.rationDefectAfterRepaire = 0,
  });
  Widget createChartUI(List<ChartQtyRate> dataInput) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      legend: Legend(
          textStyle: TextStyle(
              fontSize: global.showDashboard ? 8 : 15,
              fontWeight:
                  global.showDashboard ? FontWeight.normal : FontWeight.bold,
              color: Colors.black),
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap), //ten mau
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
      series: getSeries(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ChartSeries<ChartQtyRate, String>> getSeries(
      List<ChartQtyRate> dataInput) {
    return <ChartSeries<ChartQtyRate, String>>[
      StackedColumnSeries<ChartQtyRate, String>(
        dataSource: dataInput!,
        xValueMapper: (ChartQtyRate data, _) => DateFormat('dd-MM').format(
          data.getDate,
        ),
        yValueMapper: (ChartQtyRate data, _) => data.getQty1stOK,
        dataLabelSettings: DataLabelSettings(
            textStyle: TextStyle(fontSize: global.showDashboard ? 8 : 15),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: 'SL kiểm lần 1 đạt',
        color: Colors.blue,
      ),
      StackedColumnSeries<ChartQtyRate, String>(
        dataSource: dataInput!,
        xValueMapper: (ChartQtyRate data, _) => DateFormat('dd-MM').format(
          data.getDate,
        ),
        yValueMapper: (ChartQtyRate data, _) => data.getQty1stNOK,
        dataLabelSettings: DataLabelSettings(
            textStyle: TextStyle(fontSize: global.showDashboard ? 8 : 15),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: 'Sl kiểm lần 1 lỗi',
        color: Colors.orange[300],
      ),
      StackedColumnSeries<ChartQtyRate, String>(
        dataSource: dataInput!,
        xValueMapper: (ChartQtyRate data, _) => DateFormat('dd-MM').format(
          data.getDate,
        ),
        yValueMapper: (ChartQtyRate data, _) => data.getQtyAfterRepaire,
        dataLabelSettings: DataLabelSettings(
            textStyle: TextStyle(fontSize: global.showDashboard ? 8 : 15),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: 'SL sửa sau kiểm hàng',
        color: Colors.red,
      ),
      LineSeries<ChartQtyRate, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartQtyRate data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartQtyRate data, _) => data.getRationDefect1st * 100,
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true, labelAlignment: ChartDataLabelAlignment.auto),
          name: 'TL lần 1 lỗi',
          color: Colors.pink,
          width: 4),
      LineSeries<ChartQtyRate, String>(
          markerSettings: MarkerSettings(isVisible: true),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartQtyRate data, _) => DateFormat('dd-MM').format(
                data.getDate,
              ),
          yValueMapper: (ChartQtyRate data, _) =>
              data.getRationDefectAfterRepaire,
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
          name: 'TL lỗi sau sửa',
          color: Colors.green,
          width: 4)
    ];
  }

  //create data for chart
  List<ChartQtyRate> createChartData(List<T011stInspectionData> input, int line,
      int rangeDays, int inspectionType) {
    List<T011stInspectionData> t01Filtered = [];
    List<ChartQtyRate> result = <ChartQtyRate>[];
    var temp = [];
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
    print(
        't01Filtered removeWhere((element) => element.getSecondary != inspectionType) -lenght =' +
            t01Filtered.length.toString());
    t01Filtered.forEach((element) {
      day = DateTime.parse(element.getX02.toString());
      ChartQtyRate dataOneDay = new ChartQtyRate(date: day);
      dataOneDay.setDate = day;
      dataOneDay.setQty1st = element.getX06; // dat lan 1
      dataOneDay.setQty1stOK = element.getX07; // dat lan 1
      dataOneDay.setQty1stNOK = element.getX06 - element.getX07; //Sl loi
      dataOneDay.setQtyAfterRepaire = element.getX08;
      dataOneDay.setQtyOKAfterRepaire = element.getX09;
      dataOneDay.setRationDefect1st =
          (element.getX06 - element.getX07) / element.getX06; // ti le loi l1
      dataOneDay.setRationDefectAfterRepaire =
          (element.getX08 - element.getX09) / element.getX08;

      temp.add(dataOneDay);
    });

    List<DateTime> days = [];
    ChartQtyRate ChartQtyRateDay =
        ChartQtyRate(date: temp.length > 0 ? temp[0].getDate : global.today);

    for (var k = 0; k < temp.length; k++) {
      days.add(temp[k].getDate);
    }
    days.toSet().toList(); // remove duplicate
    days.sort((a, b) {
      //sorting in descending order
      return a.compareTo(b);
    });

    for (var i = 0; i < days.length; i++) {
      ChartQtyRateDay = ChartQtyRate(date: days[i]);
      for (var j = 0; j < temp.length; j++) {
        if (days[i] == temp[j].getDate) {
          ChartQtyRateDay.setQty1st =
              temp[j].getQty1st + ChartQtyRateDay.getQty1st;
          ChartQtyRateDay.setQty1stOK =
              temp[j].getQty1stOK + ChartQtyRateDay.getQty1stOK;
          ChartQtyRateDay.setQty1stNOK =
              temp[j].getQty1stNOK + ChartQtyRateDay.getQty1stNOK;
          ChartQtyRateDay.setQtyAfterRepaire =
              temp[j].getQtyAfterRepaire + ChartQtyRateDay.getQtyAfterRepaire;
          ChartQtyRateDay.setQtyOKAfterRepaire = temp[j].getQtyOKAfterRepaire +
              ChartQtyRateDay.getQtyOKAfterRepaire;
          ChartQtyRateDay.setRationDefect1st =
              ChartQtyRateDay.getQty1stNOK / ChartQtyRateDay.getQty1st;
          ChartQtyRateDay.setRationDefectAfterRepaire =
              ChartQtyRateDay.getQtyOKAfterRepaire /
                  ChartQtyRateDay.getQtyAfterRepaire;
        }
      }
      result.add(ChartQtyRateDay);
    }
    return result;
  }
}
