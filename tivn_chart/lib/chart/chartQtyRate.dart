import 'package:const_date_time/const_date_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'package:iso_calendar/iso_calendar.dart';

class ChartQtyRate {
  String catalogue;

  DateTime date;
  int line;
  num qty1st;
  num qty1stOK;
  num qty1stNOK;
  num qtyAfterRepaire;
  num qtyOKAfterRepaire;
  num rationDefect1st;
  num rationDefectAfterRepaire;
  String get getCatalogue => this.catalogue;

  set setCatalogue(String catalogue) => this.catalogue = catalogue;
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
    this.catalogue = 'daily',
    this.date = const ConstDateTime(2099, 01, 01),
    this.line = 0,
    this.qty1st = 0,
    this.qty1stOK = 0,
    this.qty1stNOK = 0,
    this.qtyAfterRepaire = 0,
    this.qtyOKAfterRepaire = 0,
    this.rationDefect1st = 0,
    this.rationDefectAfterRepaire = 0,
  });
  Widget createChartUI(
      List<ChartQtyRate> dataInput, String title, String catalogue) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      title: ChartTitle(
        text: title,
        textStyle: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
      legend: Legend(
          textStyle: TextStyle(
              fontSize: 7, fontWeight: FontWeight.normal, color: Colors.black),
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}%',
            minimum: 0,
            maximum: 50,
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
        xValueMapper: (ChartQtyRate data, _) => data.getCatalogue,
        yValueMapper: (ChartQtyRate data, _) => data.getQty1stOK,
        dataLabelSettings: DataLabelSettings(
            textStyle:
                TextStyle(fontSize: global.dashboardType == 'sewing' ? 15 : 8),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: '''初回検品合格数-SL kiểm lần 1 đạt''',
        color: Colors.blue,
      ),
      StackedColumnSeries<ChartQtyRate, String>(
        dataSource: dataInput!,
        xValueMapper: (ChartQtyRate data, _) => data.getCatalogue,
        yValueMapper: (ChartQtyRate data, _) => data.getQty1stNOK,
        dataLabelSettings: DataLabelSettings(
            textStyle:
                TextStyle(fontSize: global.dashboardType == 'sewing' ? 15 : 8),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: '補修後検品合格数-SL kiểm lần 1 lỗi',
        color: Colors.blue[300],
      ),
      StackedColumnSeries<ChartQtyRate, String>(
        dataSource: dataInput!,
        xValueMapper: (ChartQtyRate data, _) => data.getCatalogue,
        yValueMapper: (ChartQtyRate data, _) => data.getQtyAfterRepaire,
        dataLabelSettings: DataLabelSettings(
            textStyle:
                TextStyle(fontSize: global.dashboardType == 'sewing' ? 15 : 8),
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto),
        name: '補修後検品数-SL sửa sau kiểm hàng',
        color: Colors.red,
      ),
      LineSeries<ChartQtyRate, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartQtyRate data, _) => data.getCatalogue,
          yValueMapper: (ChartQtyRate data, _) => data.getRationDefect1st * 100,
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true, labelAlignment: ChartDataLabelAlignment.auto),
          name: '初回不良率-TL lần 1 lỗi',
          color: Colors.pink,
          width: 2),
      LineSeries<ChartQtyRate, String>(
          markerSettings: MarkerSettings(isVisible: true),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartQtyRate data, _) => data.getCatalogue,
          yValueMapper: (ChartQtyRate data, _) =>
              data.getRationDefectAfterRepaire,
          // dataLabelSettings: DataLabelSettings(
          //     isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
          name: '補修後不良率-TL lỗi sau sửa',
          color: Colors.green,
          width: 2)
    ];
  }

  List<ChartQtyRate> convertT01sToChartQtyRate(
      List<T011stInspectionData> inputT01s,
      int inspectionType,
      String typeTime,
      int rangeTime) {
    print('convertT01sToChartQtyRate : INPUT T011stInspectionData lenght = ' +
        inputT01s.length.toString());
    List<ChartQtyRate> result = <ChartQtyRate>[];
    if (inputT01s.length == 0) {
      return result;
    }
    List<T011stInspectionData> t01Filtered =
        MyFuntions.filterInspectionRangeTimeLine(
            inputT01s, inspectionType, typeTime, rangeTime, global.currentLine);

    t01Filtered.forEach((element) {
      var day = DateTime.parse(element.getX02.toString());
      ChartQtyRate chartData = new ChartQtyRate(date: day);
      chartData.setLine = element.getX01;
      chartData.setDate = day;
      chartData.setQty1st = element.getX06; // dat lan 1
      chartData.setQty1stOK = element.getX07; // dat lan 1
      chartData.setQty1stNOK = element.getX06 - element.getX07; //Sl loi
      chartData.setQtyAfterRepaire = element.getX08;
      chartData.setQtyOKAfterRepaire = element.getX09;
      // chartData.setRationDefect1st =
      //     (element.getX06 - element.getX07) / element.getX06; // ti le loi l1
      // chartData.setRationDefectAfterRepaire =
      //     (element.getX08 - element.getX09) / element.getX08;

      result.add(chartData);
    });
    print(
        'filterInspectiontypeTimeT01_ConvertToChartQtyRate : removeWhere  ${inspectionType.toString()} => OUTPUT lenght = ' +
            result.length.toString());
    return result;
  }

  //create data for chart
  List<ChartQtyRate> createChartData(
    List<T011stInspectionData> t01s,
    int line,
    int inspectionType,
    int range,
    String catalogue,
  ) {
    var t01Filtered = [...t01s]; //clone list data
    List<ChartQtyRate> resultDataChart = <ChartQtyRate>[];
    t01Filtered.removeWhere((element) => element.getX01 == 9);
    t01Filtered
        .removeWhere((element) => element.getSecondary != inspectionType);
    switch (catalogue) {
      case 'day':
        {
          var data = [...t01Filtered];
          if (global.currentLine != 0)
            data.removeWhere((element) => element.getX01 != line);
          resultDataChart = summaryDaily(data, range);
        }
        break;
      case 'week':
        {
          var data = [...t01Filtered];
          if (global.currentLine != 0)
            data.removeWhere((element) => element.getX01 != line);
          resultDataChart = summaryWeekly(data, range);
        }
        break;
      case 'month':
        {
          var data = [...t01Filtered];
          if (global.currentLine != 0)
            data.removeWhere((element) => element.getX01 != line);
          resultDataChart = summaryMonthly(data, range);
        }
        break;
      case 'line':
        {
          var data = [...t01Filtered];
          resultDataChart = summaryLineCompare(data, range, catalogue);
        }
        break;
    }

    return resultDataChart;
  }

  List<ChartQtyRate> summaryDaily(
      List<T011stInspectionData> dataInput, int range) {
    print('summaryDaily -dataInput.length : ' + dataInput.length.toString());
    List<ChartQtyRate> result = [];
    List<DateTime> days = [];
    List<DateTime> daysFilter = [];
    ChartQtyRate ChartQtyRateDay;
    for (var k = 0; k < dataInput.length; k++) {
      days.add(DateTime.parse(dataInput[k].getX02));
    }
    daysFilter = days.toSet().toList(); // remove duplicate
    daysFilter.sort((a, b) {
      //sorting increase
      return a.compareTo(b);
    });
    var indexBegin = 0;
    if (daysFilter.length - range > 0) indexBegin = daysFilter.length - range;
    for (var i = indexBegin; i < daysFilter.length; i++) {
      ChartQtyRateDay = ChartQtyRate();
      ChartQtyRateDay.setCatalogue = DateFormat('dd-MM').format(daysFilter[i]);
      for (var j = 0; j < dataInput.length; j++) {
        final day = DateTime.parse(dataInput[j].getX02);
        if (daysFilter[i] == day) {
          ChartQtyRateDay.setQty1st =
              ChartQtyRateDay.getQty1st + dataInput[j].getX06;
          ChartQtyRateDay.setQty1stOK =
              ChartQtyRateDay.getQty1stOK + dataInput[j].getX07;
          ChartQtyRateDay.setQtyAfterRepaire =
              ChartQtyRateDay.getQtyAfterRepaire + dataInput[j].getX08;
          ChartQtyRateDay.setQtyOKAfterRepaire =
              ChartQtyRateDay.getQtyOKAfterRepaire + dataInput[j].getX09;
        }
      }
      ChartQtyRateDay.setQty1stNOK =
          ChartQtyRateDay.getQty1st - ChartQtyRateDay.getQty1stOK;
      ChartQtyRateDay.setRationDefect1st =
          ChartQtyRateDay.getQty1stNOK / ChartQtyRateDay.getQty1st;
      ChartQtyRateDay.setRationDefectAfterRepaire =
          (ChartQtyRateDay.getQtyAfterRepaire -
                  ChartQtyRateDay.getQtyOKAfterRepaire) /
              ChartQtyRateDay.getQtyAfterRepaire;
      result.add(ChartQtyRateDay);
    }
    print('summaryDaily -result.length : ' + result.length.toString());
    return result;
  }

  List<ChartQtyRate> summaryWeekly(
      List<T011stInspectionData> dataInput, int range) {
    print('summaryWeekly -dataInput.length : ' + dataInput.length.toString());
    List<ChartQtyRate> result = [];
    var allWeek = [];
    var filterWeek = [];
    dataInput.forEach((element) {
      allWeek.add(
          IsoCalendar.fromDateTime(DateTime.parse(element.getX02)).weekNumber);
    });

    filterWeek = allWeek.toSet().toList();
    filterWeek.sort((a, b) {
      //sorting in descending order
      return a.compareTo(b);
    });
    var indexBegin = 0;
    if (filterWeek.length - range > 0) indexBegin = filterWeek.length - range;

    for (int i = indexBegin; i < filterWeek.length; i++) {
      final weekData = ChartQtyRate();
      weekData.setLine = global.currentLine;
      for (int j = 0; j < dataInput.length; j++) {
        final week =
            IsoCalendar.fromDateTime(DateTime.parse(dataInput[j].getX02))
                .weekNumber;
        if (filterWeek[i] == week) {
          weekData.setCatalogue =
              DateTime.parse(dataInput[j].getX02).year.toString() +
                  "-" +
                  filterWeek[i].toString();
          weekData.setQty1st = weekData.getQty1st + dataInput[j].getX06;
          weekData.setQty1stOK = weekData.getQty1stOK + dataInput[j].getX07;
          weekData.setQtyAfterRepaire =
              weekData.getQtyAfterRepaire + dataInput[j].getX08;
          weekData.setQtyOKAfterRepaire =
              weekData.getQtyOKAfterRepaire + dataInput[j].getX09;
        }
      }
      weekData.setQty1stNOK = weekData.getQty1st - weekData.getQty1stOK;
      weekData.setRationDefect1st = weekData.getQty1stNOK / weekData.getQty1st;
      weekData.setRationDefectAfterRepaire =
          (weekData.getQtyAfterRepaire - weekData.getQtyOKAfterRepaire) /
              weekData.getQtyAfterRepaire;
      result.add(weekData);
    }

    return result;
  }

  List<ChartQtyRate> summaryMonthly(
      List<T011stInspectionData> dataInput, int range) {
    print('summaryMonthly -dataInput.length : ' + dataInput.length.toString());
    List<ChartQtyRate> result = [];
    ChartQtyRate month = ChartQtyRate();
    var allMonth = [];
    var filterMonth = [];
    dataInput.forEach((element) {
      allMonth.add(DateTime.parse(element.getX02).month);
    });

    filterMonth = allMonth.toSet().toList();
    filterMonth.sort((a, b) {
      //sorting in descending order
      return a.compareTo(b);
    });
    var indexBegin = 0;
    if (filterMonth.length - range > 0) indexBegin = filterMonth.length - range;

    for (int i = indexBegin; i < filterMonth.length; i++) {
      var monthData = ChartQtyRate();
      monthData.setLine = global.currentLine;
      for (int j = 0; j < dataInput.length; j++) {
        var month = DateTime.parse(dataInput[j].getX02).month;
        if (filterMonth[i] == month) {
          monthData.setCatalogue = filterMonth[i].toString() +
              '-' +
              DateTime.parse(dataInput[j].getX02).year.toString();
          monthData.setQty1st = monthData.getQty1st + dataInput[j].getX06;
          monthData.setQty1stOK = monthData.getQty1stOK + dataInput[j].getX07;
          monthData.setQtyAfterRepaire =
              monthData.getQtyAfterRepaire + dataInput[j].getX08;
          monthData.setQtyOKAfterRepaire =
              monthData.getQtyOKAfterRepaire + dataInput[j].getX09;
        }
      }
      monthData.setQty1stNOK = monthData.getQty1st - monthData.getQty1stOK;
      monthData.setRationDefect1st =
          monthData.getQty1stNOK / monthData.getQty1st;
      monthData.setRationDefectAfterRepaire =
          (monthData.getQtyAfterRepaire - monthData.getQtyOKAfterRepaire) /
              monthData.getQtyAfterRepaire;
      result.add(monthData);
    }

    return result;
  }

  List<ChartQtyRate> summaryLineCompare(
      List<T011stInspectionData> input, int range, String catalogue) {
    print('summaryLineCompare -dailyData.length : ' + input.length.toString());
    List<ChartQtyRate> result = [];
    var dataInput = [...input];
    var dataLine = ChartQtyRate();
    DateTime lastDay;
    int lastWeek;
    int lastMonth;

    print('dataLine.getCatalogue = ' + dataLine.getCatalogue);
    switch (global.catalogue) {
      case 'day':
        {
          var days = [];
          var daysFiltered = [];
          dataInput.forEach((element) {
            if (DateTime.parse(element.getX02).year == global.today.year) {
              days.add(DateTime.parse(element.getX02));
            }
          });
          daysFiltered = days.toSet().toList();
          daysFiltered.sort(
            (a, b) {
              //sorting in descending order
              return a.compareTo(b);
            },
          );
          // lastDay = daysFiltered.last;
          // print('lastDay=' + lastDay.toString());
          var indexBegin = 0;
          if (daysFiltered.length - range > 0)
            indexBegin = daysFiltered.length - range;
          daysFiltered = daysFiltered.sublist(indexBegin);
          for (int i = 1; i <= 8; i++) {
            dataLine = ChartQtyRate();
            dataLine.setCatalogue = 'Line ' + i.toString();
            for (var j = 0; j < dataInput.length; j++) {
              final day = DateTime.parse(dataInput[j].getX02);
              if (daysFiltered.contains(day) && dataInput[j].getX01 == i) {
                dataLine.setQty1st = dataLine.getQty1st + dataInput[j].getX06;
                dataLine.setQty1stOK =
                    dataLine.getQty1stOK + dataInput[j].getX07;
                dataLine.setQtyAfterRepaire =
                    dataLine.getQtyAfterRepaire + dataInput[j].getX08;
                dataLine.setQtyOKAfterRepaire =
                    dataLine.getQtyOKAfterRepaire + dataInput[j].getX09;
              }
            }

            dataLine.setQty1stNOK = dataLine.getQty1st - dataLine.getQty1stOK;
            dataLine.setRationDefect1st =
                dataLine.getQty1stNOK / dataLine.getQty1st;
            dataLine.setRationDefectAfterRepaire =
                (dataLine.getQtyAfterRepaire - dataLine.getQtyOKAfterRepaire) /
                    dataLine.getQtyAfterRepaire;
            result.add(dataLine);
          }
        }
        break;
      case 'weeek':
        {
          var weeks = [];
          var weeksFiltered = [];
          dataInput.forEach((element) {
            if (DateTime.parse(element.getX02).year == global.today.year) {
              weeks.add(IsoCalendar.fromDateTime(DateTime.parse(element.getX02))
                  .weekNumber);
            }
          });
          weeksFiltered = weeks.toSet().toList();
          weeksFiltered.sort(
            (a, b) {
              //sorting in descending order
              return a.compareTo(b);
            },
          );
          // lastWeek = weeksFiltered.last;
          // print('lastWeek=' + lastWeek.toString());
          var indexBegin = 0;
          if (weeksFiltered.length - range > 0)
            indexBegin = weeksFiltered.length - range;
          for (int i = 1; i <= 8; i++) {
            dataLine = ChartQtyRate();
            dataLine.setCatalogue = 'Line ' + i.toString();
            for (var j = 0; j < dataInput.length; j++) {
              final week =
                  IsoCalendar.fromDateTime(DateTime.parse(dataInput[j].getX02))
                      .weekNumber;
              if (weeksFiltered.contains(week) && dataInput[j].getX01 == i) {
                dataLine.setQty1st = dataLine.getQty1st + dataInput[j].getX06;
                dataLine.setQty1stOK =
                    dataLine.getQty1stOK + dataInput[j].getX07;
                dataLine.setQtyAfterRepaire =
                    dataLine.getQtyAfterRepaire + dataInput[j].getX08;
                dataLine.setQtyOKAfterRepaire =
                    dataLine.getQtyOKAfterRepaire + dataInput[j].getX09;
              }
            }

            dataLine.setQty1stNOK = dataLine.getQty1st - dataLine.getQty1stOK;
            dataLine.setRationDefect1st =
                dataLine.getQty1stNOK / dataLine.getQty1st;
            dataLine.setRationDefectAfterRepaire =
                (dataLine.getQtyAfterRepaire - dataLine.getQtyOKAfterRepaire) /
                    dataLine.getQtyAfterRepaire;
            result.add(dataLine);
          }
        }
        break;
      case 'month':
        {
          var months = [];
          var monthsFiltered = [];
          dataInput.forEach((element) {
            if (DateTime.parse(element.getX02).year == global.today.year) {
              months.add(
                  IsoCalendar.fromDateTime(DateTime.parse(element.getX02))
                      .weekNumber);
            }
          });
          monthsFiltered = months.toSet().toList();
          monthsFiltered.sort(
            (a, b) {
              //sorting in descending order
              return a.compareTo(b);
            },
          );
          // lastMonth = monthsFiltered.last;
          // print('lastMonth=' + lastMonth.toString());
          var indexBegin = 0;
          if (months.length - range > 0)
            indexBegin = monthsFiltered.length - range;
          for (int i = 1; i <= 8; i++) {
            dataLine = ChartQtyRate();
            dataLine.setCatalogue = 'Line ' + i.toString();
            for (var j = 0; j < dataInput.length; j++) {
              final month = DateTime.parse(dataInput[j].getX02).month;
              if (monthsFiltered.contains(month) && dataInput[j].getX01 == i) {
                dataLine.setQty1st = dataLine.getQty1st + dataInput[j].getX06;
                dataLine.setQty1stOK =
                    dataLine.getQty1stOK + dataInput[j].getX07;
                dataLine.setQtyAfterRepaire =
                    dataLine.getQtyAfterRepaire + dataInput[j].getX08;
                dataLine.setQtyOKAfterRepaire =
                    dataLine.getQtyOKAfterRepaire + dataInput[j].getX09;
              }
            }
          }
          dataLine.setQty1stNOK = dataLine.getQty1st - dataLine.getQty1stOK;
          dataLine.setRationDefect1st =
              dataLine.getQty1stNOK / dataLine.getQty1st;
          dataLine.setRationDefectAfterRepaire =
              (dataLine.getQtyAfterRepaire - dataLine.getQtyOKAfterRepaire) /
                  dataLine.getQtyAfterRepaire;
          result.add(dataLine);
        }
        break;
    }

    return result;
  }
}
