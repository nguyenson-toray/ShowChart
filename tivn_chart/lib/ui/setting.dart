import 'package:flutter/material.dart';
import 'package:tivn_chart/global.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final lines = [1, 2, 3, 4, 5, 6, 7, 8];
  var days = new List<int>.generate(30, (i) => i + 1);

  DateTime selectedDate = DateTime.now();
  TextEditingController dateControllerFrom = TextEditingController();
  TextEditingController dateControllerTo = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    days.removeAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => {Navigator.of(context).pop},
        // ),
        title: const Text('Cài đặt'),
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Line : ",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  DropdownButton<String>(
                    // icon: Icon(Icons.arrow_circle_down),
                    value: global.currentLine.toString(),
                    items: lines.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        global.currentLine = int.parse(newValue!);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  Text('Khoảng thời gian hiển thị dữ liệu : '),
                  DropdownButton<String>(
                    // icon: Icon(Icons.arrow_circle_down),
                    value: global.rangeDays.toString(),
                    items: days.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        global.rangeDays = int.parse(newValue!);
                      });
                    },
                  ),
                  Text(' ngày')
                ],
              )

              // selectDate()
            ],
          )),
    );
  }

  selectDate() {
    return Container(
      child: Row(
        children: [
          TextField(
            controller:
                dateControllerFrom, //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Từ ngày" //label text of field
                ),
            readOnly: true, // when true user cannot edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), //get today's date
                  firstDate: DateTime(
                      2020), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2030));

              if (pickedDate != null) {
                print(
                    pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                String formattedDate = DateFormat('yyyy-MM-dd').format(
                    pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                print(
                    formattedDate); //formatted date output using intl package =>  2022-07-04
                //You can format date as per your need

                setState(() {
                  dateControllerFrom.text =
                      formattedDate; //set foratted date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          Text(' đến '),
          TextField(
            controller: dateControllerTo, //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Đến ngày" //label text of field
                ),
            readOnly: true, // when true user cannot edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), //get today's date
                  firstDate: DateTime(
                      2020), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2030));

              if (pickedDate != null) {
                print(
                    pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                String formattedDate = DateFormat('yyyy-MM-dd').format(
                    pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                print(
                    formattedDate); //formatted date output using intl package =>  2022-07-04
                //You can format date as per your need

                setState(() {
                  dateControllerTo.text =
                      formattedDate; //set foratted date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          )
        ],
      ),
    );
  }
}
