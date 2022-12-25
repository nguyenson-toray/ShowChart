import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';
import '../inspectionChartData.dart';
import '../dataClass/t011stInspectionData.dart';

class ChartFuntion {
  List<InspectionChartData> createChartInspectionData(
      List<T011stInspectionData> data, int line) {
    List<InspectionChartData> result = [];

    global.beginDate =
        global.today.subtract(Duration(days: global.rangeDays - 1));
    data.forEach((t01_element) {
      DateTime day = DateTime.parse(t01_element.getX02);
      try {
        global.beginDate =
            global.today.subtract(Duration(days: global.rangeDays + 1));
        if (day.isAfter(global.beginDate) &&
            t01_element.getX01 == global.currentLine) {
          InspectionChartData dataOneDay = new InspectionChartData(date: day);
          dataOneDay.setDate = day;
          dataOneDay.setQty1st = t01_element.getX06; // dat lan 1
          dataOneDay.setQty1stOK = t01_element.getX07; // dat lan 1
          dataOneDay.setQty1stNOK =
              t01_element.getX06 - t01_element.getX07; //Sl loi
          dataOneDay.setQtyAfterRepaire = t01_element.getX08;
          dataOneDay.setQtyOKAfterRepaire = t01_element.getX09;
          dataOneDay.setRationDefect1st =
              (t01_element.getX06 - t01_element.getX07) /
                  t01_element.getX06; // ti le loi l1
          dataOneDay.setRationDefectAfterRepaire =
              (t01_element.getX08 - t01_element.getX09) / t01_element.getX08;

          result.add(dataOneDay);
        }
      } catch (e) {
        print(e.toString());
      }
    });
    print(
        'createChartInspectionData of LINE ${global.currentLine.toString()} - from ${DateFormat(global.dateFormat).format(
      global.beginDate,
    )} to today !!! ==> ${result.length.toString()} records');
    List<InspectionChartData> input = result;
    List<InspectionChartData> output = [];
    List<DateTime> tempDays = [];
    List<DateTime> days = [];
    InspectionChartData dataDay = InspectionChartData(date: input[0].getDate);

    for (var k = 0; k < input.length; k++) {
      tempDays.add(input[k].getDate);
    }
    days = tempDays.toSet().toList(); // remove duplicate

    print('remove duplicate days =>:  ${days.length.toString()}');

    for (var i = 0; i < days.length; i++) {
      dataDay = InspectionChartData(date: days[i]);
      for (var j = 0; j < input.length; j++) {
        if (days[i] == input[j].getDate) {
          dataDay.setQty1st = input[j].getQty1st + dataDay.getQty1st;
          dataDay.setQty1stOK = input[j].getQty1stOK + dataDay.getQty1stOK;
          dataDay.setQty1stNOK = input[j].getQty1stNOK + dataDay.getQty1stNOK;
          dataDay.setQtyAfterRepaire =
              input[j].getQtyAfterRepaire + dataDay.getQtyAfterRepaire;
          dataDay.setQtyOKAfterRepaire =
              input[j].getQtyOKAfterRepaire + dataDay.getQtyOKAfterRepaire;
          dataDay.setRationDefect1st = dataDay.getQty1stNOK / dataDay.getQty1st;
          dataDay.setRationDefectAfterRepaire =
              dataDay.getQtyOKAfterRepaire / dataDay.getQtyAfterRepaire;
        }
      }
      output.add(dataDay);
    }

    return output;
  }
}
