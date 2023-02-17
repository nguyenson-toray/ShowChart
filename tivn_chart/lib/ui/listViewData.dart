import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';

class ListViewData extends StatefulWidget {
  List<T011stInspectionData> data = [];
  ListViewData({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ListViewDataState createState() => _ListViewDataState();
}

class _ListViewDataState extends State<ListViewData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () async {
              var item = global.t01sFilteredByInspectionSetting[index];
              await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  title:
                      'Bạn có chắc chắn xóa ${item.getTotalChecked.toString()} Pcs',
                  confirmBtnText: 'Có',
                  cancelBtnText: 'Không',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () {
                    setState(() {
                      Navigator.of(context).pop();
                      deleteRow(index);
                    });
                  });
            },
            child: Card(
              // margin: EdgeInsets.all(3),
              child: ListTile(
                  // trailing: Text(global
                  //     .t01sFilteredByInspectionSetting[index].getId
                  //     .toString()),
                  title: global.t01sFilteredByInspectionSetting[index]
                              .getTotal ==
                          0
                      ? Text(
                          "${global.t01sFilteredByInspectionSetting[index].getTime} - Số lượng : ${global.t01sFilteredByInspectionSetting[index].totalChecked} Pcs")
                      : Text(
                          "${global.t01sFilteredByInspectionSetting[index].getTime} - Số lượng : 1 Pcs"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(global.t01sFilteredByInspectionSetting[index]
                          .getDefectName),
                      Text(global.t01sFilteredByInspectionSetting[index].getXc),
                    ],
                  ),
                  leading: global
                              .t01sFilteredByInspectionSetting[index].getX10 >
                          0
                      ? CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            'C',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : global.t01sFilteredByInspectionSetting[index].getTF == 0
                          // ? Image.asset('asset/check1.png')
                          ? CircleAvatar(
                              backgroundColor: Colors.greenAccent,
                              child: Icon(
                                global.t01sFilteredByInspectionSetting[index]
                                        .getIsReCheck
                                    ? Icons.done_all
                                    : Icons.done,
                                color: Colors.black,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.yellowAccent,
                              child: Text(
                                global.t01sFilteredByInspectionSetting[index]
                                        .getIsReCheck
                                    ? '!!'
                                    : '!',
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
            ),
          );
        },
        itemCount: global.t01sFilteredByInspectionSetting.length,
      ),
    );
  }

  deleteRow(int index) {
    var id = global.t01sFilteredByInspectionSetting[index].getId;
    global.mySqlife.deleteRowInTableInspections(id);
    global.t01sFilteredByInspectionSetting.removeAt(index);
    global.t01sLocal.removeAt(index);
    global.t01SummaryByInspectionSetting =
        MyFuntions.t01sSummaryByLastInspectionSetting(
            global.t01sFilteredByInspectionSetting, global.inspectionSetting);
    global.needUpdateSQL = true;
  }
}
