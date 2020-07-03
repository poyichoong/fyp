import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/approve.dart';
import 'package:fyp/comment.dart';
import 'package:fyp/cooker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Order extends StatefulWidget {
  final String phone;
  Order({Key key, this.phone}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController _daycontroller = TextEditingController();
  final ScrollController controller = ScrollController();
  String orderURL = "http://192.168.43.245/fyp/order.php";
  List data = ["1", "2", "3", "4", "5", "6"];
  String _mySelection, _myChoice, date;

  @override
  void initState() {
    date = "start Date";
    _mySelection = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios, size: 20),
              onPressed: _onBackPressAppBar,
            ),
            backgroundColor: Color.fromRGBO(0, 0, 205, 0.5),
            elevation: 1,
            centerTitle: true,
            title: Text(
              "Order",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Start from",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "The delivery will start for 3 days later after the order date.",
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _showBottomSheet();
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Person",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.black, style: BorderStyle.solid),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: false,
                        isDense: true,
                        items: data.map((item) {
                          return DropdownMenuItem(
                            child: Text(
                              item.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            value: item.toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _mySelection = newVal;
                          });
                        },
                        value: _mySelection,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Day",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.white),
                        right: BorderSide(width: 1, color: Colors.white),
                        bottom: BorderSide(width: 1, color: Colors.white),
                        left: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      controller: _daycontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: double.infinity,
                        height: 50,
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('phone');
    http.post(orderURL, body: {
      "startdate": date,
      "person": _mySelection,
      "day": _daycontroller.text,
      "phone": phone,
      "cooker_phone": widget.phone,
    }).then((response) {
      if (response.body == "success") {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Cooker(
        //         phone: widget.phone,
        //       ),
        //     ));
        Navigator.of(context).pop();
      }
    }).catchError((err) {
      print("error: " + err.toString());
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(
                            10,
                          ),
                          child: Text(
                            "Start Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.all(
                              10,
                            ),
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                      10,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            // minimumDate:
                            //     DateFormat("yyyy-MM-dd").parse(minimumDate),
                            maximumDate: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            backgroundColor: Colors.transparent,
                            initialDateTime:
                                DateFormat("yyyy-MM-dd").parse("2019-01-01"),
                            onDateTimeChanged: (startDate) {
                              setState(() {
                                date = startDate.toString().substring(0, 10);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onBackPressAppBar() {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Comment(
    //         phone: widget.phone,
    //       ),
    //     ));
    Navigator.of(context).pop();
  }
}
