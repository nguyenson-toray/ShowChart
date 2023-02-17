import 'package:const_date_time/const_date_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'package:iso_calendar/iso_calendar.dart';

class ChartProduction {
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
  num a;
  num b;
  num c;
  num d;
  num e;
  num f;
  num g;
  num h;

  num a1;
  num a2;
  num a3;

  num b1;
  num b2;
  num b3;

  num c1;
  num c2;

  num d1;
  num d2;
  num d3;
  num d4;

  num e1;
  num e2;
  num e3;
  num e4;
  num e5;
  num e6;
  num e7;

  num f1;
  num f2;
  num f3;
  num f4;
  num f5;
  num f6;
  num f7;
  num f8;
  num f9;

  num g1;
  num g2;
  num g3;
  get getCatalogue => this.catalogue;

  set setCatalogue(catalogue) => this.catalogue = catalogue;

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

  get getA => this.a;

  set setA(a) => this.a = a;

  get getB => this.b;

  set setB(b) => this.b = b;

  get getC => this.c;

  set setC(c) => this.c = c;

  get getD => this.d;

  set setD(d) => this.d = d;

  get getE => this.e;

  set setE(e) => this.e = e;

  get getF => this.f;

  set setF(f) => this.f = f;

  get getG => this.g;

  set setG(g) => this.g = g;

  get getH => this.h;

  set setH(h) => this.h = h;

  get getA1 => this.a1;

  set setA1(a1) => this.a1 = a1;

  get getA2 => this.a2;

  set setA2(a2) => this.a2 = a2;

  get getA3 => this.a3;

  set setA3(a3) => this.a3 = a3;

  get getB1 => this.b1;

  set setB1(b1) => this.b1 = b1;

  get getB2 => this.b2;

  set setB2(b2) => this.b2 = b2;

  get getB3 => this.b3;

  set setB3(b3) => this.b3 = b3;

  get getC1 => this.c1;

  set setC1(c1) => this.c1 = c1;

  get getC2 => this.c2;

  set setC2(c2) => this.c2 = c2;

  get getD1 => this.d1;

  set setD1(d1) => this.d1 = d1;

  get getD2 => this.d2;

  set setD2(d2) => this.d2 = d2;

  get getD3 => this.d3;

  set setD3(d3) => this.d3 = d3;

  get getD4 => this.d4;

  set setD4(d4) => this.d4 = d4;

  get getE1 => this.e1;

  set setE1(e1) => this.e1 = e1;

  get getE2 => this.e2;

  set setE2(e2) => this.e2 = e2;

  get getE3 => this.e3;

  set setE3(e3) => this.e3 = e3;

  get getE4 => this.e4;

  set setE4(e4) => this.e4 = e4;

  get getE5 => this.e5;

  set setE5(e5) => this.e5 = e5;

  get getE6 => this.e6;

  set setE6(e6) => this.e6 = e6;

  get getE7 => this.e7;

  set setE7(e7) => this.e7 = e7;

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

  get getG1 => this.g1;

  set setG1(g1) => this.g1 = g1;

  get getG2 => this.g2;

  set setG2(g2) => this.g2 = g2;

  get getG3 => this.g3;

  set setG3(g3) => this.g3 = g3;
  ChartProduction({
    this.catalogue = '',
    this.date = const ConstDateTime(2099, 01, 01),
    this.line = 0,
    this.qty1st = 0,
    this.qty1stOK = 0,
    this.qty1stNOK = 0,
    this.qtyAfterRepaire = 0,
    this.qtyOKAfterRepaire = 0,
    this.rationDefect1st = 0,
    this.rationDefectAfterRepaire = 0,
    this.a = 0,
    this.b = 0,
    this.c = 0,
    this.d = 0,
    this.e = 0,
    this.f = 0,
    this.g = 0,
    this.h = 0,
    this.a1 = 0,
    this.a2 = 0,
    this.a3 = 0,
    this.b1 = 0,
    this.b2 = 0,
    this.b3 = 0,
    this.c1 = 0,
    this.c2 = 0,
    this.d1 = 0,
    this.d2 = 0,
    this.d3 = 0,
    this.d4 = 0,
    this.e1 = 0,
    this.e2 = 0,
    this.e3 = 0,
    this.e4 = 0,
    this.e5 = 0,
    this.e6 = 0,
    this.e7 = 0,
    this.f1 = 0,
    this.f2 = 0,
    this.f3 = 0,
    this.f4 = 0,
    this.f5 = 0,
    this.f6 = 0,
    this.f7 = 0,
    this.f8 = 0,
    this.f9 = 0,
    this.g1 = 0,
    this.g2 = 0,
    this.g3 = 0,
  });

  ChartProduction convertFromT01s(List<T011stInspectionData> dataInput) {
    List<T011stInspectionData> input = [...dataInput];
    ChartProduction result = ChartProduction();
    input.forEach((element) {
      result.setQty1st = result.getQty1st + element.getX06;
      result.setQty1stOK = result.getQty1stOK + element.getX07;

      result.setQtyAfterRepaire = result.getQtyAfterRepaire + element.getX08;
      result.setQtyOKAfterRepaire =
          result.getQtyOKAfterRepaire + element.getX09;

      result.setA1 = result.getA1 + element.getA1;
      result.setA2 = result.getA2 + element.getA2;
      result.setA3 = result.getA3 + element.getA3;
      result.setA = result.getA + element.getSumA;
      //
      result.setB1 = result.getB1 + element.getB1;
      result.setB2 = result.getB2 + element.getB2;
      result.setB3 = result.getB3 + element.getB3;
      result.setB = result.getB + element.getSumB;
      //
      result.setC1 = result.getC1 + element.getC1;
      result.setC2 = result.getC2 + element.getC2;
      result.setC = result.getC + element.getSumC;
      //
      result.setD1 = result.getD1 + element.getD1;
      result.setD2 = result.getD2 + element.getD2;
      result.setD3 = result.getD3 + element.getD3;
      result.setD4 = result.getD4 + element.getD4;
      result.setD = result.getD + element.getSumD;
      //
      result.setE1 = result.getE1 + element.getE1;
      result.setE2 = result.getE2 + element.getE2;
      result.setE3 = result.getE3 + element.getE3;
      result.setE4 = result.getE4 + element.getE4;
      result.setE5 = result.getE5 + element.getE5;
      result.setE6 = result.getE6 + element.getE6;
      result.setE7 = result.getE7 + element.getE7;
      result.setE = result.getE + element.getSumE;
      //
      result.setF1 = result.getF1 + element.getF1;
      result.setF2 = result.getF2 + element.getF2;
      result.setF3 = result.getF3 + element.getF3;
      result.setF4 = result.getF4 + element.getF4;
      result.setF5 = result.getF5 + element.getF5;
      result.setF6 = result.getF6 + element.getF6;
      result.setF7 = result.getF7 + element.getF7;
      result.setF8 = result.getF8 + element.getF8;
      result.setF9 = result.getF9 + element.getF9;
      result.setF = result.getF + element.getSumF;
      //
      result.setG1 = result.getG1 + element.getG1;
      result.setG2 = result.getG2 + element.getG2;
      result.setG3 = result.getG3 + element.getG3;
      result.setG = result.getG + element.getSumG;
      result.setH = result.getH + element.getH;
    });
    result.setQty1stNOK = result.getQty1st - result.getQty1stOK;
    result.setRationDefect1st = double.parse(
        (result.getQty1stNOK / result.getQty1st).toStringAsFixed(4));
    //
    result.setRationDefectAfterRepaire = double.parse(
        ((result.getQtyAfterRepaire - result.getQtyOKAfterRepaire) /
                result.getQtyAfterRepaire)
            .toStringAsFixed(4));

    return result;
  }

  Widget createChartQtyRateUI(List<ChartProduction> dataInput, String title,
      String catalogue, int currentLine) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      title: ChartTitle(
        text: title,
        textStyle: TextStyle(
            fontSize: !global.isTV ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: Colors.orange),
      ),
      legend: Legend(
        textStyle: TextStyle(
            fontSize: !global.isTV ? 11 : (global.device == 'TVLine' ? 15 : 7),
            fontWeight: FontWeight.normal,
            color: Colors.black),
        position: LegendPosition.bottom,
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}%',
            minimum: 0,
            maximum: 35,
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
      series: getSeriesQtyRate(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getSeriesQtyRate(List<ChartProduction> dataInput) {
    var myDataLabelSettings = DataLabelSettings(
        textStyle: TextStyle(
            fontSize: !global.isTV ? 12 : (global.screenTypeInt == 0 ? 15 : 8)),
        isVisible: true,
        labelAlignment: ChartDataLabelAlignment.auto);
    return <ChartSeries<ChartProduction, String>>[
      StackedColumnSeries<ChartProduction, String>(
        dataSource: dataInput,
        xValueMapper: (ChartProduction data, _) => data.getCatalogue,
        yValueMapper: (ChartProduction data, _) => data.getQty1stOK,
        dataLabelSettings: myDataLabelSettings,
        name: '''初回検品合格数-SL kiểm lần 1 đạt''',
        color: Colors.blueAccent,
      ),
      StackedColumnSeries<ChartProduction, String>(
        dataSource: dataInput,
        xValueMapper: (ChartProduction data, _) => data.getCatalogue,
        yValueMapper: (ChartProduction data, _) => data.getQty1stNOK,
        dataLabelSettings: myDataLabelSettings,
        name: '補修後検品合格数-SL kiểm lần 1 lỗi',
        color: Colors.orangeAccent,
      ),
      StackedColumnSeries<ChartProduction, String>(
        dataSource: dataInput,
        xValueMapper: (ChartProduction data, _) => data.getCatalogue,
        yValueMapper: (ChartProduction data, _) => data.getQtyAfterRepaire,
        dataLabelSettings: myDataLabelSettings,
        name: '補修後検品数-SL sửa sau kiểm hàng',
        color: Colors.redAccent,
      ),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) =>
              data.getRationDefect1st * 100,
          dataLabelSettings: myDataLabelSettings,
          name: '初回不良率-TL lần 1 lỗi',
          color: Colors.pink,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings: MarkerSettings(isVisible: true),
          dataSource: dataInput,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) =>
              data.getRationDefectAfterRepaire,
          dataLabelSettings: myDataLabelSettings,
          name: '補修後不良率-TL lỗi sau sửa',
          color: Colors.green,
          width: 2)
    ];
  }

  //--------------
  Widget createChartGroupAllUI(List<ChartProduction> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'エラーグループ-Nhóm lỗi',
        textStyle: TextStyle(
            fontSize: !global.isTV ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: Colors.orange),
      ),
      backgroundColor: Colors.white,
      legend: Legend(
          height: '40%',
          textStyle: TextStyle(
              fontSize: !global.isTV ? 12 : 7,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis:
          CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          opposedPosition: false,
          majorGridLines: const MajorGridLines(width: 1),
          minimum: 0,
          // maximum: 100,
          interval: 10),
      series: getSeriesChartGroupAll(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getSeriesChartGroupAll(List<ChartProduction> dataInput) {
    var myDataLabelSettings = DataLabelSettings(
        textStyle: TextStyle(fontSize: !global.isTV ? 12 : 10),
        isVisible: true,
        labelAlignment: ChartDataLabelAlignment.auto);
    return <ChartSeries<ChartProduction, String>>[
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getA,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[0] + '-' + global.listGroupDefect[0],
          color: Colors.blue[800],
          width: 4),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getB,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[1] + '-' + global.listGroupDefect[1],
          color: Colors.red,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings: MarkerSettings(
              isVisible: false, shape: DataMarkerType.invertedTriangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getC,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[2] + '-' + global.listGroupDefect[2],
          color: Colors.grey,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getD,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[3] + '-' + global.listGroupDefect[3],
          color: Colors.yellow,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[4] + '-' + global.listGroupDefect[4],
          color: Colors.blue[900],
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings: MarkerSettings(
              // textStyle: TextStyle(fontSize: 12),
              isVisible: false,
              shape: DataMarkerType.triangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[5] + '-' + global.listGroupDefect[5],
          color: Colors.green,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getG,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[6] + '-' + global.listGroupDefect[6],
          color: Colors.teal,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: false, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getH,
          dataLabelSettings: myDataLabelSettings,
          name: global.listGroupDefectJP[7] + '-' + global.listGroupDefect[7],
          color: Colors.orange,
          width: 2),
    ];
  }

  Widget createChartGroupEUI(List<ChartProduction> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(
        text: global.listGroupDefectJP[4] + '-' + global.listGroupDefect[4],
        textStyle: TextStyle(
            fontSize: !global.isTV ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: Colors.orange),
      ),
      backgroundColor: Colors.white,
      legend: Legend(
          height: '40%',
          shouldAlwaysShowScrollbar: false,
          textStyle: TextStyle(
              fontSize: !global.isTV ? 12 : 7,
              fontWeight: FontWeight.normal,
              color: Colors.black),
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
      series: getSeriesChartGroupE(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getSeriesChartGroupE(List<ChartProduction> dataInput) {
    var myDataLabelSettings = DataLabelSettings(
        textStyle: TextStyle(fontSize: !global.isTV ? 12 : 10),
        isVisible: true,
        labelAlignment: ChartDataLabelAlignment.auto);
    return <ChartSeries<ChartProduction, String>>[
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE1,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![0] +
              '-' +
              global.defectNames['Lỗi may đan']![0],
          color: Colors.blue[400],
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE2,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![1] +
              '-' +
              global.defectNames['Lỗi may đan']![1],
          color: Colors.red,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE3,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![2] +
              '-' +
              global.defectNames['Lỗi may đan']![2],
          color: Colors.grey,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings: MarkerSettings(
              isVisible: true, shape: DataMarkerType.invertedTriangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE4,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![3] +
              '-' +
              global.defectNames['Lỗi may đan']![3],
          color: Colors.yellow,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE5,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![4] +
              '-' +
              global.defectNames['Lỗi may đan']![4],
          color: Colors.blue[900],
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE6,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![5] +
              '-' +
              global.defectNames['Lỗi may đan']![5],
          color: Colors.green,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.triangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getE7,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Lỗi may đan']![6] +
              '-' +
              global.defectNames['Lỗi may đan']![6],
          color: Colors.teal,
          width: 2),
    ];
  }

  Widget createChartGroupFUI(List<ChartProduction> dataInput) {
    return SfCartesianChart(
      title: ChartTitle(
        text: global.listGroupDefectJP[5] + '-' + global.listGroupDefect[5],
        textStyle: TextStyle(
            fontSize: !global.isTV ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: Colors.orange),
      ),
      backgroundColor: Colors.white,
      legend: Legend(
          height: '40%',
          textStyle: TextStyle(
              fontSize: !global.isTV ? 12 : 7,
              fontWeight: FontWeight.normal,
              color: Colors.black),
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
      series: getSeriesChartGroupF(dataInput),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  getSeriesChartGroupF(List<ChartProduction> dataInput) {
    var myDataLabelSettings = DataLabelSettings(
        textStyle: TextStyle(fontSize: !global.isTV ? 12 : 10),
        isVisible: true,
        labelAlignment: ChartDataLabelAlignment.auto);
    return <ChartSeries<ChartProduction, String>>[
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF1,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![0] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![0],
          color: Colors.blue[400],
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF2,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![1] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![1],
          color: Colors.red,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF3,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![2] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![2],
          color: Colors.grey,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings: MarkerSettings(
              isVisible: true, shape: DataMarkerType.invertedTriangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF4,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![3] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![3],
          color: Colors.yellow,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.pentagon),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF5,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![4] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![4],
          color: Colors.blue[900],
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.rectangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF6,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![5] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![5],
          color: Colors.green,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.triangle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF7,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![6] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![6],
          color: Colors.teal,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF8,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![7] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![7],
          color: Colors.orange,
          width: 2),
      LineSeries<ChartProduction, String>(
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
          dataSource: dataInput,
          xValueMapper: (ChartProduction data, _) => data.getCatalogue,
          yValueMapper: (ChartProduction data, _) => data.getF9,
          dataLabelSettings: myDataLabelSettings,
          name: global.defectNamesJP['Ngoại quan, thành phẩm']![8] +
              '-' +
              global.defectNames['Ngoại quan, thành phẩm']![8],
          color: Colors.amber,
          width: 2),
    ];
  }
}
