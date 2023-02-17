import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tivn_chart/dataClass/inspectionSetting.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';

class WorkSettingWiget extends StatefulWidget {
  Function(T011stInspectionData param) callback;
  WorkSettingWiget({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  _WorkSettingWiget createState() => _WorkSettingWiget();
}

class _WorkSettingWiget extends State<WorkSettingWiget> {
  bool isEditing = false;
  int line = 1;
  String customer = 'KASCO';
  String color = 'LAVENDER';
  String style = 'KSRWL-002JA';
  String size = 'XS';
  List<String> customers = [];
  List<String> styles = [];
  List<String> colors = [];
  List<String> sizes = [];
  List<String> descriptions = [];
  List<String> inspectionTypeStrings = ['', 'Sơ cấp', 'Thứ cấp'];
  String inspectionTypeString = 'Sơ cấp';
  @override
  void initState() {
    line = global.inspectionSetting.getLine;
    customer = global.inspectionSetting.getCustomer;
    style = global.inspectionSetting.getStyle;
    size = global.inspectionSetting.getSize;
    customers = getCustomersName();
    styles = getStyles(customer);
    sizes = getSizes();
    colors = getColors(styles[0]);
    isEditing = false;
    inspectionTypeString =
        inspectionTypeStrings[global.inspectionSetting.getInspectionType];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Image.asset('asset/letter-l.png'),
          // Image.asset('asset/letter-i.png'),
          // Image.asset('asset/letter-n.png'),
          // Image.asset('asset/letter-e.png'),
          // const Text(
          //   "Line : ",
          //   style: TextStyle(fontSize: 14),
          // ),

          isEditing
              ? DropdownButton<String>(
                  value: line.toString(),
                  items:
                      global.lines.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      line = int.parse(newValue!);
                    });
                  },
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 70,
                    height: 30,
                    color: global.needUpdateSQL
                        ? Colors.yellowAccent
                        : Colors.greenAccent,
                    child: Text(
                      'LINE ' + line.toString().toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

          SizedBox(
            width: 5,
          ),
          isEditing
              ? DropdownButton<String>(
                  value: inspectionTypeString,
                  items: inspectionTypeStrings
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? inspectionTypeNameValue) {
                    setState(() {
                      inspectionTypeString = inspectionTypeNameValue!;
                    });
                  },
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 70,
                    height: 30,
                    color: Colors.greenAccent,
                    child: Text(
                      inspectionTypeString.toUpperCase(),
                      // style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

          SizedBox(
            width: 20,
          ),
          Image.asset('assets/customer.png'),
          // const Text("Khách hàng : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: customer,
                  items:
                      customers.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      customer = newValue.toString();
                      styles = getStyles(customer);
                      style = styles[0];
                      colors = getColors(style);
                      color = colors[0];
                    });
                  },
                )
              : Text(customer),
          SizedBox(
            width: 20,
          ),

          Image.asset('assets/style.png'),
          // const Text("Mã hàng : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: style,
                  items: styles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print('newValue =' + newValue.toString());
                    setState(() {
                      style = newValue.toString();
                      colors = getColors(style);
                      color = colors[0];
                    });
                  },
                )
              : Text(style),
          SizedBox(
            width: 20,
          ),
          Image.asset('assets/color.png'),
          // const Text("Màu : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: color,
                  items: colors.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      color = newValue.toString();
                    });
                  },
                )
              : Text(color),
          SizedBox(
            width: 20,
          ),
          Image.asset('assets/size.png'),
          // Text("Size : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: size,
                  items: sizes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      size = newValue.toString();
                    });
                  },
                )
              : Text(size),
          SizedBox(
            width: 20,
          ),

          TextButton.icon(
            icon: isEditing
                ? Icon(
                    Icons.save_sharp,
                    color: Colors.blue,
                  )
                : Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
            label: isEditing ? Text('') : Text(''),
            onPressed: () {
              setState(() {
                if (isEditing == false) {
                  isEditing = true;
                } else {
                  saveWorkSettingWiget();
                  isEditing = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  List<String> getCustomersName() {
    List<String> result;
    customers.clear();
    global.t03s.forEach((element) {
      customers.add(element.getx18);
    });
    // result = MyFuntions.removeDuplicateListString(customers);
    // print('getCustomersName -> ${result.toString()}');
    return customers.toSet().toList();
  }

  List<String> getStyles(String customerName) {
    List<String> result;
    styles.clear();
    global.t03s.forEach((element) {
      if (element.getx18 == customerName) {
        styles.add(element.getX151);
      }
    });
    return styles.toSet().toList();
  }

  int getStyleCode(String style) {
    int code = 0;
    global.t03s.forEach((element) {
      if (element.getX151 == style) {
        code = element.getID1;
      }
    });
    print('getStyleCode : style = $style => styleCode = ${code.toString()}');
    return code;
  }

  List<String> getColors(String style) {
    colors = [];
    int code = getStyleCode(style);
    print('getStyleCode : ' + code.toString());
    global.t06s.forEach((element) {
      if (element.getID2 == code) {
        colors.add(element.getX041);
        print('-ADD color : ${element.getX041}');
      }
    });
    print('colors = ${colors.toString()}');
    if (colors.length == 0)
      return ['NO COLOR'];
    else
      return colors;
  }

  List<String> getSizes() {
    global.t08s.forEach((element) {
      if (element.getCSize != null) sizes.add(element.getCSize);
    });
    return sizes.toSet().toList();
  }

  saveWorkSettingWiget() async {
    global.t04s.forEach((element) {
      var date = element.getX021;
      if (date == global.todayString &&
          element.getX011 == global.inspectionSetting.getLine) {
        global.planToday = element.getX13; //so luong ke hoach
        print(
            'Line ${global.inspectionSetting.getLine} - plan today: ${global.planToday.toString()} pcs');
      }
    });
    print('saveWorkSettingWiget');
    global.inspectionSetting = InspectionSetting(
        line: line,
        color: color,
        customer: customer,
        inspectionType: inspectionTypeStrings.indexOf(inspectionTypeString),
        size: size,
        style: style,
        styleCode: getStyleCode(style));
    print('SAVE SQL Lite: global.inspectionSetting : ' +
        global.inspectionSetting.toString());
    global.mySqlife.deleteAllRowsInTable('InspectionSetting');
    global.mySqlife
        .insertIntoTable('InspectionSetting', global.inspectionSetting);
    global.t04s.forEach((element) {
      var date = element.getX021;
      if (date == global.todayString &&
          element.getX011 == global.inspectionSetting.getLine) {
        global.plan = element.getX13; //so luong ke hoach
      }
    });
    global.t01 = T011stInspectionData();

    // global.t01sAllLocal = await global.mySqlife.loadInspectionDataT01();
    global.t01sFilteredByInspectionSetting =
        MyFuntions.t01FilterByLastInspectionSetting(
            global.t01sLocal, global.inspectionSetting);
    global.t01SummaryByInspectionSetting =
        MyFuntions.t01sSummaryByLastInspectionSetting(
            global.t01sFilteredByInspectionSetting, global.inspectionSetting);

    try {
      widget.callback(global.t01SummaryByInspectionSetting);
    } catch (e) {
      print(e.toString());
    }
  }
}
