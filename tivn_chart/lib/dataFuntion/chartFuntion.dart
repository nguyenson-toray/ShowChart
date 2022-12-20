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
        if (day.isAfter(global.beginDate)) {
          InspectionChartData dataOneDay = new InspectionChartData();
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
              ((t01_element.getX08 - t01_element.getX09) / t01_element.getX08);
          result.add(dataOneDay);
        }
      } catch (e) {
        print(e.toString());
      }
    });
    print(
        'createChartInspectionData of LINE ${global.currentLine.toString()} - from ${DateFormat(global.dateFormat).format(
      global.beginDate,
    )} to today !!! ==> ${result.length.toString()}');
    List<InspectionChartData> input = result;
    List<InspectionChartData> output = [];
    output.add(input[0]);
    int j = 0;
    for (var i = 1; i < input.length; i++) {
      if (input[i].getDate == output[j].getDate) {
        output[j].setDate = input[i].getDate;
        output[j].setQty1st = input[i].getQty1st + output[j].getQty1st;
        output[j].setQty1stOK = input[i].getQty1stOK + output[j].getQty1stOK;
        output[j].setQty1stNOK = input[i].getQty1stNOK + output[j].getQty1stNOK;
        output[j].setQtyAfterRepaire =
            input[i].getQtyAfterRepaire + output[j].getQtyAfterRepaire;
        output[j].setQtyOKAfterRepaire =
            input[i].getQtyOKAfterRepaire + output[j].getQtyOKAfterRepaire;
        output[j].setRationDefect1st =
            output[j].getQty1stNOK / output[j].getQty1st;
        output[j].setRationDefectAfterRepaire =
            output[j].getQtyOKAfterRepaire / output[j].getQtyAfterRepaire;
      } else {
        output.add(input[i]);
        j++;
      }
    }
    return output;
  }
}
