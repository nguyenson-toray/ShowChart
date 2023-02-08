import 'package:iso_calendar/iso_calendar.dart';
import 'package:tivn_chart/chart/chartProduction.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class ChartFuntionData {
  //create data for chart
  static List<ChartProduction> createChartData(
    List<T011stInspectionData> t01s,
    int line,
    int inspectionType,
    int range,
    String catalogue,
  ) {
    print('createChartQtyRateUI-t01s : ' + t01s.length.toString());
    print('catalogue : ' + catalogue.toString());
    var t01Filtered = [...t01s]; //clone list data
    List<ChartProduction> resultDataChart = <ChartProduction>[];

    t01Filtered.removeWhere((element) => element.getX01 == 9);
    t01Filtered.removeWhere((e) => e.getSecondary != inspectionType);

    switch (catalogue) {
      case 'day':
        {
          var data = [...t01Filtered];
          if (global.dashboardType != 'control1')
            data.removeWhere((element) => element.getX01 != line);

          resultDataChart = summaryDaily(data, range);

          resultDataChart.forEach((element) {});
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

  static List<ChartProduction> summaryDaily(
      List<T011stInspectionData> input, int range) {
    print('summaryDaily -input.length : ' + input.length.toString());
    List<ChartProduction> result = [];
    List<DateTime> days = [];
    List<DateTime> daysFilter = [];
    var dataInput = [...input];
    for (var k = 0; k < dataInput.length; k++) {
      days.add(DateTime.parse(dataInput[k].getX02));
    }
    daysFilter = days.toSet().toList(); // remove duplicate
    daysFilter.sort((a, b) {
      return a.compareTo(b); //sorting increase
    });

    var indexBegin = 0;
    if (daysFilter.length - range > 0) indexBegin = daysFilter.length - range;
    global.dayFilerBegin = daysFilter[indexBegin];
    global.dayFilerEnd = daysFilter.last;
    for (var index = indexBegin; index < daysFilter.length; index++) {
      var chartData = ChartProduction();
      var t01sOneDayData = dataInput.where(
          (element) => DateTime.parse(element.getX02) == daysFilter[index]);
      chartData = chartData.convertFromT01s(t01sOneDayData.toList());
      chartData.setCatalogue = DateFormat('dd-MM').format(daysFilter[index]);
      result.add(chartData);
    }

    return result;
  }

  static List<ChartProduction> summaryWeekly(
      List<T011stInspectionData> dataInput, int range) {
    print('summaryWeekly -range: ${range.toString()}');
    List<ChartProduction> result = [];
    var allWeek = [];
    var filterWeek = [];
    dataInput.forEach((element) {
      allWeek.add(MyFuntions.dateTimeToWeek(element.getX02));
    });

    filterWeek = allWeek.toSet().toList();
    filterWeek.sort((a, b) {
      return a.compareTo(b); //sorting in descending order
    });
    var indexBegin = 0;
    if (filterWeek.length - range > 0) indexBegin = filterWeek.length - range;
    for (var index = indexBegin; index < filterWeek.length; index++) {
      var chartData = ChartProduction();
      var t01sOneWeekData = dataInput.where((element) =>
          MyFuntions.dateTimeToWeek(element.getX02) == filterWeek[index]);
      chartData = chartData.convertFromT01s(t01sOneWeekData.toList());
      chartData.setCatalogue = filterWeek[index];
      result.add(chartData);
    }

    return result;
  }

  static List<ChartProduction> summaryMonthly(
      List<T011stInspectionData> dataInput, int range) {
    print('summaryMonthly -range: ${range.toString()}');
    List<ChartProduction> result = [];
    ChartProduction month = ChartProduction();
    var allMonth = [];
    var filterMonth = [];
    dataInput.forEach((element) {
      allMonth.add(MyFuntions.dateTimeToMonth(element.getX02));
    });
    filterMonth = allMonth.toSet().toList(); // remove duplicate
    filterMonth.sort((a, b) {
      return a.compareTo(b); //sorting in descending order
    });
    var indexBegin = 0;
    if (filterMonth.length - range > 0) indexBegin = filterMonth.length - range;
    print('filterMonth = ' + filterMonth.toString());
    for (var index = indexBegin; index < filterMonth.length; index++) {
      var chartData = ChartProduction();
      var t01sOneMonthData = dataInput.where((element) =>
          MyFuntions.dateTimeToMonth(element.getX02) == filterMonth[index]);
      chartData = chartData.convertFromT01s(t01sOneMonthData.toList());
      chartData.setCatalogue = filterMonth[index];
      result.add(chartData);
    }
    return result;
  }

  static List<ChartProduction> summaryLineCompare(
      List<T011stInspectionData> dataInput, int range, String catalogue) {
    print('summaryLineCompare -range: ${range.toString()}');
    List<ChartProduction> result = [];
    var dataLine = ChartProduction();
    switch (global.catalogue) {
      case 'day':
        {
          List<DateTime> days = [];
          List<DateTime> daysFilter = [];
          for (var k = 0; k < dataInput.length; k++) {
            days.add(DateTime.parse(dataInput[k].getX02));
          }
          daysFilter = days.toSet().toList(); // remove duplicate
          daysFilter.sort((a, b) {
            return a.compareTo(b); //sorting increase
          });
          var indexBegin = 0;
          if (daysFilter.length - range > 0)
            indexBegin = daysFilter.length - range;
          for (int line = 1; line <= 8; line++) {
            final lineString = 'Line ' + line.toString();
            List<T011stInspectionData> t01sDataLine = [];
            var chartDataLine = ChartProduction();
            for (var index = indexBegin; index < daysFilter.length; index++) {
              var t01sDataLineOneDay = dataInput.where((element) =>
                  line == element.getX01 &&
                  DateTime.parse(element.getX02) == daysFilter[index]);
              t01sDataLine.addAll(t01sDataLineOneDay.toList());
            }
            chartDataLine = chartDataLine.convertFromT01s(t01sDataLine);
            chartDataLine.setCatalogue = lineString;
            result.add(chartDataLine);
          }
        }
        break;
      case 'week':
        {
          var allWeek = [];
          var filterWeek = [];
          dataInput.forEach((element) {
            allWeek.add(MyFuntions.dateTimeToWeek(element.getX02));
          });

          filterWeek = allWeek.toSet().toList();
          filterWeek.sort((a, b) {
            return a.compareTo(b); //sorting in descending order
          });

          var indexBegin = 0;
          if (filterWeek.length - range > 0)
            indexBegin = filterWeek.length - range;
          //
          for (int line = 1; line <= 8; line++) {
            final lineString = 'Line ' + line.toString();
            List<T011stInspectionData> t01sDataLine = [];
            var chartDataLine = ChartProduction();
            for (var index = indexBegin; index < filterWeek.length; index++) {
              var t01sDataLineOneDay = dataInput.where((element) =>
                  line == element.getX01 &&
                  MyFuntions.dateTimeToWeek(element.getX02) ==
                      filterWeek[index]);
              t01sDataLine.addAll(t01sDataLineOneDay.toList());
            }
            chartDataLine = chartDataLine.convertFromT01s(t01sDataLine);
            chartDataLine.setCatalogue = lineString;
            result.add(chartDataLine);
          }
        }
        break;
      case 'month':
        {
          ChartProduction month = ChartProduction();
          var allMonth = [];
          var filterMonth = [];
          dataInput.forEach((element) {
            allMonth.add(MyFuntions.dateTimeToMonth(element.getX02));
          });
          filterMonth = allMonth.toSet().toList(); // remove duplicate
          filterMonth.sort((a, b) {
            return a.compareTo(b); //sorting in descending order
          });
          var indexBegin = 0;
          if (filterMonth.length - range > 0)
            indexBegin = filterMonth.length - range;
          ;
          for (int line = 1; line <= 8; line++) {
            final lineString = 'Line ' + line.toString();
            var chartDataLine = ChartProduction(catalogue: lineString);
            for (int line = 1; line <= 8; line++) {
              final lineString = 'Line ' + line.toString();
              List<T011stInspectionData> t01sDataLine = [];
              var chartDataLine = ChartProduction();
              for (var index = indexBegin;
                  index < filterMonth.length;
                  index++) {
                var t01sDataLineOneDay = dataInput.where((element) =>
                    line == element.getX01 &&
                    MyFuntions.dateTimeToMonth(element.getX02) ==
                        filterMonth[index]);
                t01sDataLine.addAll(t01sDataLineOneDay.toList());
              }
              chartDataLine = chartDataLine.convertFromT01s(t01sDataLine);
              chartDataLine.setCatalogue = lineString;
              result.add(chartDataLine);
            }
          }
        }
        break;
    }
    return result;
  }
}
