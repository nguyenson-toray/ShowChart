import 'dart:async';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tivn_chart/chart/chartFuntionData.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  ChartSeriesController? chartSeriesController;
  double hSetting = 0;
  double wSetting = 0;
  double hChart = 0;
  double wChart = 0;
  double hChartPhone = 0;
  double wChartPhone = 0;
  int padding = 10;
  List<String> lines = [
    'All',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  RadioGroupController myController = RadioGroupController();
  @override
  void initState() {
    // TODO: implement initState
    hSetting = global.screenHPixel - 50;
    wSetting = global.screenWPixel * 0.1;
    hChart = ((global.screenHPixel - 60) * 0.5) - 6;
    wChart = global.screenWPixel * 0.325;
    hChartPhone = global.screenHPixel * 0.6;
    wChartPhone = global.screenWPixel;
    getCurrentScreenName();
    refreshChartData();
    Timer.periodic(new Duration(seconds: global.secondsAutoGetData), (timer) {
      getDataT01();
    });
    Timer.periodic(new Duration(seconds: global.secondsAutoChangeLine),
        (timer) {
      autoChangeLine();
    });

    super.initState();
  }

  getDataT01() async {
    if (!mounted) return;

    await global.mySqlServer
        .getInspectionData(global.rangeDaySQL)
        .then((value) => setState(() {
              global.t01s = value;
            }));
    refreshChartData();
  }

  refreshChartData() async {
    if (!mounted) return;

    var dataInput = [...global.t01s];
    setState(() {
      print(
          'refreshChartData : screenTypeInt = ${global.screenTypeInt.toString()}     currentLine = ${global.currentLine.toString()}');
      global.chartData.clear();
      global.chartData = ChartFuntionData.createChartData(
        dataInput,
        global.currentLine,
        global.inspection12,
        global.rangeTime,
        global.catalogue,
      );
      chartSeriesController?.updateDataSource(
          updatedDataIndexes:
              List<int>.generate(global.chartData.length, (i) => i + 1));
      //global.chartData.clear();
      global.chartDataCompareLine = ChartFuntionData.createChartData(
        dataInput,
        global.currentLine,
        global.inspection12,
        global.rangeTime,
        'line',
      );
      chartSeriesController?.updateDataSource(
          updatedDataIndexes: List<int>.generate(
              global.chartDataCompareLine.length, (i) => i + 1));
    });
  }

  autoChangeLine() {
    if (!mounted ||
        !global.autoChangeLine ||
        global.screenTypeInt == 0 ||
        !global.isTV) return;
    if (global.autoChangeLine && global.screenTypeInt == 2) {
      setState(() {
        if (global.currentLine < 7)
          global.currentLine++;
        else
          global.currentLine = 1;
        print('autoChangeLine -> ' + global.currentLine.toString());
      });
      refreshChartData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: buildAppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                global.screenTypeInt != 0 ? option() : Container(),
                buildScreen(global.screenTypeInt)
              ],
            )),
      ),
    );
  }

  Widget buildScreen(int screenTypeInt) {
    var screen;
    switch (screenTypeInt) {
      case 1:
        {
          global.screenName = 'General';
          screen = global.isTV ? buildScreen1() : buildScreen1_Phone();
        }
        break;
      case 2:
        {
          global.screenName = 'Detail';
          screen = global.isTV ? buildScreen2() : buildScreen2_Phone();
        }
        break;
      case 0:
        {
          global.screenName = 'Sewing Line';
          screen = buildScreen0_sewingLine();
        }
        break;
    }
    return screen;
  }

  Widget buildScreen1() {
    print('*********buildScreen 1 ');
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: hChart - 40,
                  width: global.screenWPixel / 2 - 5,
                  child: global.chart.createChartQtyRateUI(
                      global.chartData,
                      '工場の全ラインの生産性・不良率-Sản lượng & tỉ lệ lỗi của toàn nhà máy',
                      global.catalogue,
                      global.currentLine),
                ),
                Container(
                  height: hChart - 40,
                  width: global.screenWPixel / 2 - 5,
                  child: global.chart.createChartQtyRateUI(
                      global.chartDataCompareLine,
                      'ライン別の生産性・不良率 - Sản lượng & tỉ lệ lỗi của các chuyền ',
                      global.catalogue,
                      global.currentLine),
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: hChart + 40,
                    width: wChart,
                    child: global.chart.createChartGroupAllUI(global.chartData),
                  ),
                  Container(
                    height: hChart + 40,
                    width: wChart,
                    child: global.chart.createChartGroupFUI(global.chartData),
                  ),
                  Container(
                    height: hChart + 40,
                    width: wChart,
                    child: global.chart.createChartGroupEUI(global.chartData),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  Widget buildScreen2() {
    print('*********buildScreen 2 ');
    return Container(
      child: Column(
        children: [
          Container(
            height: hChart - 80,
            child: global.chart.createChartQtyRateUI(
                global.chartData, '', global.catalogue, global.currentLine),
          ),
          SizedBox(height: 5),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: hChart + 80,
                  width: wChart,
                  child: global.chart.createChartGroupAllUI(global.chartData),
                ),
                Container(
                  height: hChart + 80,
                  width: wChart,
                  child: global.chart.createChartGroupFUI(global.chartData),
                ),
                Container(
                  height: hChart + 80,
                  width: wChart,
                  child: global.chart.createChartGroupEUI(global.chartData),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildScreen0_sewingLine() {
    print('*********  buildScreen 3  sewingLine   ');
    return Container(
      height: global.screenHPixel - 30,
      width: global.screenWPixel,
      child: global.chart.createChartQtyRateUI(
          global.chartData, '', global.catalogue, global.currentLine),
    );
  }

  Widget buildScreen1_Phone() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              decoration: global.myBoxDecoration,
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartQtyRateUI(
                  global.chartData,
                  '工場の全ラインの生産性・不良率-Sản lượng & tỉ lệ lỗi của toàn nhà máy',
                  global.catalogue,
                  global.currentLine),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              decoration: global.myBoxDecoration,
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartQtyRateUI(
                  global.chartDataCompareLine,
                  'ライン別の生産性・不良率 - Sản lượng & tỉ lệ lỗi của các chuyền ',
                  global.catalogue,
                  global.currentLine),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              decoration: global.myBoxDecoration,
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartGroupAllUI(global.chartData),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              decoration: global.myBoxDecoration,
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartGroupFUI(global.chartData),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              decoration: global.myBoxDecoration,
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartGroupEUI(global.chartData),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScreen2_Phone() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartQtyRateUI(
                  global.chartData, '', global.catalogue, global.currentLine),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartGroupAllUI(global.chartData),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartGroupFUI(global.chartData),
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              height: hChartPhone,
              width: wChartPhone,
              child: global.chart.createChartGroupEUI(global.chartData),
            ),
          )
        ]));
  }

  // Widget bbuildScreen3_sewingLinePhone() {}
  changescreenTypeInt() {
    setState(() {
      global.screenTypeInt++;

      if (global.screenTypeInt > 2 && !global.isTV)
        global.screenTypeInt = 1;
      else if (global.screenTypeInt > 2 && global.isTV)
        global.screenTypeInt = 0;
      print('global.screenTypeInt = ' + global.screenTypeInt.toString());
      print('global.global.isTV = ' + global.isTV.toString());
    });
  }

  getCurrentScreenName() {
    switch (global.screenTypeInt) {
      case 1:
        {
          global.screenName = 'General';
        }
        break;
      case 2:
        {
          global.screenName = 'Detail';
        }
        break;
      case 0:
        {
          global.screenName = 'Sewing Line';
        }
        break;
    }
  }

  Widget setting() {
    return Container(
      child: Row(
        children: [
          rangeDay(),
          //-------

          playPauseChange()
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 30,
      // actionsIconTheme: IconThemeData(color: Colors.tealAccent),
      backgroundColor: Colors.blue[700],
      leading: InkWell(
          onTap: () {
            setState(() {
              changescreenTypeInt();
              global.sharedPreferences
                  .setInt('screenTypeInt', global.screenTypeInt);
              buildScreen(global.screenTypeInt);
            });
          },
          child: Row(
            children: [Icon(Icons.dashboard), Text(global.screenName)],
          )),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          global.screenTypeInt != 1
              ? Text(('LINE ' + global.currentLine.toString()))
              : SizedBox(height: 20, child: Image.asset('assets/logo.png')),
        ],
      ),
      centerTitle: true,
      actions: [getAppBarActionWidget()],
    );
  }

  Widget getAppBarActionWidget() {
    Widget result = Row();
    switch (global.screenTypeInt) {
      case 1:
        {
          result = SizedBox(width: 45);
        }
        break;
      case 2:
        {
          result = Row(
            children: [
              // rangeDay(),
              playPauseChange()
            ],
          );
        }
        break;
      case 3:
        {}
        break;
    }
    return result;
  }

  Widget playPauseChange() {
    return Container(
      child: Row(
        children: [
          global.autoChangeLine
              ? InkWell(
                  child: Icon(
                    global.autoChangeLine ? Icons.pause : Icons.play_circle,
                  ),
                  onTap: () {
                    setState(() {
                      global.autoChangeLine = !global.autoChangeLine;
                      global.sharedPreferences
                          .setBool('autoChangeLine', global.autoChangeLine);
                      refreshChartData();
                    });
                  },
                )
              : Container(),
          InkWell(
            child: Icon(Icons.arrow_back_sharp),
            onTap: () {
              setState(() {
                if (global.currentLine > 1)
                  global.currentLine--;
                else
                  global.currentLine = 8;
                global.sharedPreferences
                    .setInt('currentLine', global.currentLine);
                refreshChartData();
              });
            },
          ),
          InkWell(
            child: Icon(Icons.arrow_forward_sharp),
            onTap: () {
              setState(() {
                if (global.currentLine < 8)
                  global.currentLine++;
                else
                  global.currentLine = 1;
                global.sharedPreferences
                    .setInt('currentLine', global.currentLine);
                refreshChartData();
              });
            },
          ),
          //
        ],
      ),
    );
  }

  Widget rangeDay() {
    return Container(
      child: Text(
          style: TextStyle(fontSize: 12),
          DateFormat('dd/MM/yyyy').format(global.dayFilerBegin) +
              ' - ' +
              DateFormat('dd/MM/yyyy').format(
                global.dayFilerEnd,
              )),
    );
  }

  Widget option() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // color: Colors.blue[50],
      // alignment: Alignment.center,
      // padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
      // height: 30,
      // width: global.screenWPixel,
      child: Row(children: [
        rangeDay(),
        SizedBox(
          width: 25,
        ),
        RadioGroup(
          onChanged: (value) {
            setState(() {
              global.rangeTime = int.parse(value.toString());
              global.sharedPreferences.setInt('rangeTime', global.rangeTime);
              refreshChartData();
            });
          },
          controller: myController,
          values: [1, 2, 4, 6, 10, 14],
          indexOfDefault: [1, 2, 4, 6, 10, 14].indexOf(global.rangeTime),
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        RadioGroup(
          onChanged: (value) {
            setState(() {
              global.catalogue = value.toString();
              global.sharedPreferences.setString('catalogue', global.catalogue);
              refreshChartData();
            });
          },
          controller: myController,
          values: ["day", "week", "month"],
          indexOfDefault: ["day", "week", "month"].indexOf(global.catalogue),
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        // Text('Data', style: TextStyle(color: Colors.black, fontSize: 8)),
        RadioGroup(
          onChanged: (value) {
            setState(() {
              if (value.toString() == '1st')
                global.inspection12 = 1;
              else
                global.inspection12 = 2;
              global.sharedPreferences
                  .setInt('inspection12', global.inspection12);
              refreshChartData();
            });
          },
          controller: myController,
          values: ['1st', '2nd'],
          indexOfDefault: global.inspection12 == 1 ? 0 : 1,
          orientation: RadioGroupOrientation.Horizontal,
          decoration: RadioGroupDecoration(
            spacing: 2.0,
            labelStyle: TextStyle(color: Colors.black, fontSize: 8),
            activeColor: Colors.amber,
          ),
        ),
      ]),
    );
  }
}
