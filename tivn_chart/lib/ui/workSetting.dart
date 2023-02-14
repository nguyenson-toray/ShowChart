import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tivn_chart/dataClass/lastSetting.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/dataFuntion/myFuntions.dart';
import 'package:tivn_chart/global.dart';

class WorkSetting extends StatefulWidget {
  Function(T011stInspectionData param) callback;
  WorkSetting({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  _WorkSetting createState() => _WorkSetting();
}

class _WorkSetting extends State<WorkSetting> {
  bool isEditing = false;

  List<String> customers = [];
  List<String> styles = [];
  List<String> colors = [];
  List<String> sizes = [];
  List<String> descriptions = [];
  List<int> lines = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<String> inspectionTypes = ['Sơ cấp', 'Thứ cấp'];
  String inspectionType = 'Sơ cấp';
  @override
  void initState() {
    customers = getCustomersName();
    styles = getStyles(global.customer);
    sizes = getSizes();
    colors = getColors(styles[0]);
    isEditing = false;
    inspectionType = global.lastSetting.getSecondary ? 'Thứ cấp' : 'Sơ cấp';
    // TODO: implement initState

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
                  value: global.line.toString(),
                  items: lines.map<DropdownMenuItem<String>>((int value) {
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
                      global.line = int.parse(newValue!);
                    });
                  },
                )
              : CircleAvatar(
                  maxRadius: 25, child: Text('Line ' + global.line.toString())),
          SizedBox(
            width: 5,
          ),
          isEditing
              ? DropdownButton<String>(
                  value: inspectionType,
                  items: inspectionTypes
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
                      print('inspectionTypeNameValue = ' +
                          inspectionTypeNameValue!);
                      global.inspectionTypeName = inspectionTypeNameValue!;
                      inspectionType = inspectionTypeNameValue!;
                    });
                  },
                )
              : Text(inspectionType),

          SizedBox(
            width: 20,
          ),
          Image.asset('asset/customer.png'),
          // const Text("Khách hàng : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: global.customer,
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
                      global.customer = newValue.toString();
                      styles = getStyles(global.customer);
                      global.style = styles[0];
                      colors = getColors(global.style);
                      global.color = colors[0];
                    });
                  },
                )
              : Text(global.customer),
          SizedBox(
            width: 20,
          ),

          Image.asset('asset/style.png'),
          // const Text("Mã hàng : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: global.style,
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
                    setState(() {
                      global.style = newValue.toString();
                      colors = getColors(global.style);
                      global.color = colors[0];
                    });
                  },
                )
              : Text(global.style),
          SizedBox(
            width: 20,
          ),
          Image.asset('asset/color.png'),
          // const Text("Màu : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: global.color,
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
                      global.color = newValue.toString();
                    });
                  },
                )
              : Text(global.color),
          SizedBox(
            width: 20,
          ),
          Image.asset('asset/size.png'),
          // Text("Size : ", style: TextStyle(fontSize: 14)),
          isEditing
              ? DropdownButton<String>(
                  value: global.size,
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
                      global.size = newValue.toString();
                    });
                  },
                )
              : Text(global.size),
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
                  saveWorkSetting();
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
    // result = MyFuntions.removeDuplicateListString(styles);
    // print(
    //     'getStyles of customerName : ${customerName} -> ${result.toString()}');
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
    // return MyFuntions.removeDuplicateListString(sizes);
    return sizes.toSet().toList();
  }

  saveWorkSetting() async {
    var plan;
    // global.sharedPreferences.setInt('line', global.line);
    global.t04s.forEach((element) {
      var date = element.getX021;
      if (date == global.todayString && element.getX011 == global.line) {
        global.plan = element.getX13; //so luong ke hoach
      }
    });
    global.t01 = T011stInspectionData();
    // global.t01InspectionData.setX01 = global.line;
    // global.t01InspectionData.setX02 = global.todayString;
    // global.t01InspectionData.setX03 = global.styleCode;
    // global.t01InspectionData.setX04 = global.color;
    // global.t01InspectionData.setX05 = global.size;
    // global.t01InspectionData.setTMonth = DateTime.now().month;
    // global.t01InspectionData.setTYear = DateTime.now().year;
    print('global.inspectionTypeName = ' + global.inspectionTypeName);
    global.lastSetting = LastSetting(
        secondary: global.inspectionTypeName == 'Sơ cấp' ? false : true,
        line: global.line,
        color: global.color,
        customer: global.customer,
        size: global.size,
        style: global.style,
        styleCode: global.styleCode);
    global.mySqlife.deleteRowsInTable('LastSetting');
    global.mySqlife.insertIntoTable('LastSetting', global.lastSetting);
    print('global.lastSetting : ' + global.lastSetting.toString());
    // global.t01sAllLocal = await global.mySqlife.loadInspectionDataT01();
    global.t01sByCurrentSetting =
        MyFuntions.t01FilterByLastSetting(global.t01sLocal, global.lastSetting);
    global.t01SummaryByCurrentSetting = MyFuntions.t01sSummaryByLastSetting(
        global.t01sByCurrentSetting, global.lastSetting);

    try {
      widget.callback(global.t01SummaryByCurrentSetting);
    } catch (e) {
      print(e.toString());
    }
  }
}
