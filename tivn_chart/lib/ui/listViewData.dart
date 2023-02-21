import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';
import 'package:tivn_chart/ui/inputInspectionPage.dart';

class ListViewData extends StatefulWidget {
  Function(T011stInspectionData param) callback;
  ListViewData({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  @override
  _ListViewDataState createState() => _ListViewDataState();
}

class _ListViewDataState extends State<ListViewData> {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext contextQC) {
    return Container(
      height: global.screenHPixel - 60,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(3),
            child: ListTile(
                trailing: PopupMenuButton<String>(
                  onSelected: (result) async {
                    if (result != 'delete')
                      global.t01sFilteredByInspectionSetting[index].setX08 = 1;
                    switch (result) {
                      case 'delete':
                        {
                          deleteRow(index);
                        }
                        break;
                      case '2OK':
                        {
                          setState(() {
                            global.t01sFilteredByInspectionSetting[index]
                                .setCheckNo = 2;
                            global.t01sFilteredByInspectionSetting[index]
                                .setX09 = 1;
                            global.t01sFilteredByInspectionSetting[index]
                                .setLastResult = true;
                            global.t01sFilteredByInspectionSetting[index]
                                .setX09 = 1;
                          });
                        }
                        break;
                      case '2NOK':
                        {
                          setState(() {
                            global.t01sFilteredByInspectionSetting[index]
                                .setLastResult = false;
                            global.t01sFilteredByInspectionSetting[index]
                                .setCheckNo = 2;
                            global.result = 'LỖI';
                            global.currentIdT01 = global
                                .t01sFilteredByInspectionSetting[index].getId;
                            global.editT01s = true;
                          });

                          Navigator.of(context)
                              .pushNamed('/InputInspectionPage');
                        }
                        break;
                      case '3OK':
                        {
                          setState(() {
                            global.t01sFilteredByInspectionSetting[index]
                                .setCheckNo = 3;
                            global.t01sFilteredByInspectionSetting[index]
                                .setLastResult = true;
                            global.t01sFilteredByInspectionSetting[index]
                                .setX09 = 1;
                          });
                        }
                        break;
                      case '3NOK':
                        {
                          global.t01sFilteredByInspectionSetting[index]
                              .setCheckNo = 3;
                          global.t01sFilteredByInspectionSetting[index]
                              .setLastResult = false;
                          global.t01sFilteredByInspectionSetting[index].x10 = 1;
                        }
                        break;
                      default:
                        {}
                    }
                    setState(() {
                      global.t01SummaryByInspectionSetting =
                          MyFuntions.t01sSummaryByLastInspectionSetting(
                              global.t01sFilteredByInspectionSetting,
                              global.inspectionSetting);
                    });
                    global.needUpdateSQL = !await global.mySqlServer
                        .updateInspectionDataToT01(
                            global.t01SummaryByInspectionSetting);
                    if (index == 0) {
                      global.needUpdateSQL = !await global.mySqlServer
                          .deleteRow(global.inspectionSetting);
                    }
                    widget.callback(global.t01SummaryByInspectionSetting);
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        enabled: !global.t01sFilteredByInspectionSetting[index]
                                .getLastResult &
                            (global.t01sFilteredByInspectionSetting[index]
                                    .getCheckNo <
                                3),
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                              width: 150,
                              height: 60,
                              alignment: Alignment.center,
                              color: Colors.greenAccent,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Text(
                                      'Kiểm lần ${(global.t01sFilteredByInspectionSetting[index].getCheckNo + 1)} ĐẠT'),
                                ],
                              )),
                        ),
                        value:
                            '${(global.t01sFilteredByInspectionSetting[index].getCheckNo + 1)}OK',
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        enabled: !global.t01sFilteredByInspectionSetting[index]
                                .getLastResult &
                            (global.t01sFilteredByInspectionSetting[index]
                                    .getCheckNo <
                                3),
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                              width: 150,
                              height: 60,
                              alignment: Alignment.center,
                              color: Colors.yellowAccent,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Text(
                                      'Kiểm lần ${(global.t01sFilteredByInspectionSetting[index].getCheckNo + 1)} LỖI'),
                                ],
                              )),
                        ),
                        value:
                            '${(global.t01sFilteredByInspectionSetting[index].getCheckNo + 1)}NOK',
                        onTap: () {
                          setState(() {});
                        },
                      ),
                      PopupMenuItem(
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                              width: 150,
                              height: 60,
                              alignment: Alignment.center,
                              color: Colors.redAccent,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Text('XÓA'),
                                ],
                              )),
                        ),

                        // Text('XÓA')),
                        // ),
                        value: 'delete',
                      ),
                    ];
                  },
                ),

                // trailing: Text(global
                //     .t01sFilteredByInspectionSetting[index].getId
                //     .toString()),
                title: global.t01sFilteredByInspectionSetting[index].getTotal ==
                        0
                    ? Text(
                        "${global.t01sFilteredByInspectionSetting[index].getTime} - Số lượng : ${global.t01sFilteredByInspectionSetting[index].totalChecked} Pcs")
                    : Text(
                        "${global.t01sFilteredByInspectionSetting[index].getTime} - Số lượng : 1 Pcs"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(global.t01sFilteredByInspectionSetting[index]
                            .getDefectName
                            .toString()),
                      ],
                    ),
                    Text(global.t01sFilteredByInspectionSetting[index].getXc),
                  ],
                ),
                leading:
                    global.t01sFilteredByInspectionSetting[index].getX10 > 0
                        ? CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text(
                              'C',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : global.t01sFilteredByInspectionSetting[index]
                                .getLastResult
                            // ? Image.asset('asset/check1.png')
                            ? CircleAvatar(
                                backgroundColor: Colors.greenAccent,
                                child: Text(
                                  global.t01sFilteredByInspectionSetting[index]
                                      .checkNo
                                      .toString(),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.yellowAccent,
                                child: Text(
                                  global.t01sFilteredByInspectionSetting[index]
                                      .checkNo
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              )),
          );
        },
        itemCount: global.t01sFilteredByInspectionSetting.length,
      ),
    );
  }

  deleteRow(int index) {
    print('deleteRow - ListView : $index');
    var id = global.t01sFilteredByInspectionSetting[index].getId;
    setState(() {
      global.mySqlife.deleteRowInTableInspections(id);
      global.t01sFilteredByInspectionSetting.removeAt(index);
      global.t01sLocal.removeAt(index);
      global.t01SummaryByInspectionSetting =
          MyFuntions.t01sSummaryByLastInspectionSetting(
              global.t01sFilteredByInspectionSetting, global.inspectionSetting);
    });
  }
}
