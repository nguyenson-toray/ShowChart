import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';

class InputInspectionPage extends StatefulWidget {
  Function(List<T011stInspectionData> param) callback;
  InputInspectionPage({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  _InputInspectionPageState createState() => _InputInspectionPageState();
}

class _InputInspectionPageState extends State<InputInspectionPage> {
  int count = 1;
  @override
  void initState() {
    // TODO: implement initState
    MyFuntions.clearDefectQtyCmt();
    count = 1;
    global.commentTotal = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          title: Text(
            'Nhập lỗi sản phẩm thứ : ${count}',
          ),
          actions: [
            InkWell(
              child: Icon(Icons.clear, size: 40),
              onTap: () => setState(() {
                MyFuntions.clearDefectQtyCmt();
              }),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              child: Icon(Icons.save, size: 40),
              onTap: () async {
                if (global.editT01s) {
                  T011stInspectionData t01CurrentFiltered = global
                      .t01sFilteredByInspectionSetting
                      .where((element) => element.getId == global.currentIdT01)
                      .first;

                  if (t01CurrentFiltered.getCheckNo >= 2) {
                    print('  if (t01CurrentFiltered.getCheckNo >= 2) {');
                    T011stInspectionData t01CurrentAllLocal = global.t01sLocal
                        .where(
                            (element) => element.getId == global.currentIdT01)
                        .first;
                    int indexInT01sLocal =
                        global.t01sLocal.indexOf(t01CurrentAllLocal);
                    int indexInT01sFiltered = global
                        .t01sFilteredByInspectionSetting
                        .indexOf(t01CurrentFiltered);

                    setState(() {
                      t01CurrentFiltered = MyFuntions.editT01AddDefects(
                          t01CurrentFiltered,
                          global.defectNames,
                          global.defectCmts,
                          global.defectQtys);

                      global.t01sLocal.removeAt(indexInT01sLocal);
                      global.t01sLocal.add(t01CurrentFiltered);
                      //
                      global.t01sFilteredByInspectionSetting
                          .removeAt(indexInT01sFiltered);
                      global.t01sFilteredByInspectionSetting
                          .add(t01CurrentFiltered);
                      //
                      global.t01SummaryByInspectionSetting =
                          MyFuntions.t01sSummaryByLastInspectionSetting(
                              global.t01sFilteredByInspectionSetting,
                              global.inspectionSetting);
                      //save to SqLite
                      global.mySqlife
                          .deleteRowInTableInspections(global.currentIdT01);
                      global.mySqlife
                        ..insertIntoTable_T011stInspectionData(
                            t01CurrentFiltered);

                      global.comment = '';
                      print(
                          '${DateTime.now().toString()}  Update Inspection Data From Local to SQL server : ${global.t01SummaryByInspectionSetting.toString()}');
                    });
                    global.mySqlServer
                        .updateInspectionDataToT01(
                            global.t01SummaryByInspectionSetting)
                        .then((value) => {global.needUpdateSQL = !value});
                  }
                } else {
                  setState(() {
                    count++;
                    MyFuntions.saveNewT01();
                  });
                }
                setState(() {
                  MyFuntions.clearDefectQtyCmt();
                  if (count > global.totalChecked || global.editT01s)
                    try {
                      global.editT01s = false;
                      widget.callback(global.t01sFilteredByInspectionSetting);
                      Navigator.of(context).pop();
                    } catch (e) {
                      print(e.toString());
                    }
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text(global.t01InspectionData.toStrings())],
            // ),
            buildGroupDefect(global.listGroupDefect[0]),
            buildGroupDefect(global.listGroupDefect[1]),
            buildGroupDefect(global.listGroupDefect[2]),
            buildGroupDefect(global.listGroupDefect[3]),
            buildGroupDefect(global.listGroupDefect[4]),
            buildGroupDefect(global.listGroupDefect[5]),
            buildGroupDefect(global.listGroupDefect[6]),
          ]),
        ),
      ),
    );
  }

  Widget buildGroupDefect(String groupName) {
    return Card(
      child: Column(children: [
        Container(
          width: double.infinity,
          decoration: new BoxDecoration(
              // color: Colors.blue[50],
              ),
          child: Text(
            groupName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            height: 85,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: (global.defectNames[groupName])!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  width: 200,
                  // alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(5),
                      subtitle: (global.defectQtys[groupName])![index] > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      (global.defectQtys[groupName])![index]--;
                                    });
                                  },
                                  child: Icon(Icons.remove,
                                      size: 40, color: Colors.redAccent),
                                ),
                                CircleAvatar(
                                  maxRadius: 12,
                                  child: Text(
                                    (global.defectQtys[groupName])![index]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      (global.defectQtys[groupName])![index]++;
                                    });
                                  },
                                  child: Icon(Icons.add,
                                      size: 40, color: Colors.greenAccent),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.custom,
                                      barrierDismissible: true,
                                      confirmBtnText: 'Lưu',
                                      widget: TextFormField(
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            hintText:
                                                'Nhập thêm thông tin mô tả',
                                            prefixIcon: Icon(
                                              Icons.edit,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          onSaved: (newValue) {
                                            setState(() {
                                              global.comment =
                                                  newValue.toString();
                                              (global.defectCmts[groupName])![
                                                  index] = newValue.toString();
                                            });
                                          },
                                          onChanged: (value) => setState(() {
                                                global.comment =
                                                    value.toString();
                                                (global.defectCmts[groupName])![
                                                    index] = value.toString();
                                              })),
                                    );
                                  },
                                  child: Icon(Icons.edit,
                                      size: 25, color: Colors.orangeAccent),
                                ),
                              ],
                            )
                          : Container(),
                      title: Text((global.defectNames[groupName])![index]),
                      onChanged: (bool? value) {
                        setState(() {
                          value == true
                              ? (global.defectQtys[groupName])![index] = 1
                              : (global.defectQtys[groupName])![index] = 0;
                        });
                      },
                      value: MyFuntions.parseBool(
                          (global.defectQtys[groupName])![index])),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 3);
              },
            )),
      ]),
    );
  }
}
