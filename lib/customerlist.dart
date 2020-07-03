import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/cookerlist.dart';
import 'package:fyp/mainPage.dart';
import 'package:fyp/mamamainpage.dart';
import 'package:fyp/customerdetail.dart';
import 'package:http/http.dart' as http;

class Customerlist extends StatefulWidget {
  final String phone;
  Customerlist({Key key, this.phone}) : super(key: key);

  @override
  _CustomerlistState createState() => _CustomerlistState();
}

class _CustomerlistState extends State<Customerlist> {
  ScrollController _scrollController = ScrollController();
  final ScrollController controller = ScrollController();
  List<Customer> customerList = [];
  List existingCustomerList = [];
  bool ready, data, customer;
  String customerListURL = "http://192.168.43.245/fyp/customerList.php";
  String existingCustomerListURL =
      "http://192.168.43.245/fyp/existingCustomerList.php";
  String actionURL = "http://192.168.43.245/fyp/action.php";

  @override
  void initState() {
    ready = false;
    data = false;
    customer = false;
    getData();
    getCustomer();
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
            title: Container(
              child: Text(
                "Customer List",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: (ready == false)
            ? Column()
            : Column(
                children: <Widget>[
                  (customerList.length == 0)
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "New customer",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                  (customerList.length == 0)
                      ? Container()
                      : Flexible(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemExtent: 80,
                            scrollDirection: Axis.vertical,
                            itemCount: customerList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                // height: 30,
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Customerdetail(),
                                            ));
                                      },
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/icon.png',
                                          //   width: 80,
                                          //   height: 80,
                                        ),
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            customerList[index].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            _action(
                                                customerList[index].name,
                                                customerList[index].phone,
                                                "existing");
                                          },
                                          child: Image.asset(
                                            'assets/images/a.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            _action(
                                                customerList[index].name,
                                                customerList[index].phone,
                                                "reject");
                                          },
                                          child: Image.asset(
                                            'assets/images/b.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  (existingCustomerList.length == 0)
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Existing customers",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                  (existingCustomerList.length == 0)
                      ? Container()
                      : Flexible(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemExtent: 80,
                            scrollDirection: Axis.vertical,
                            itemCount: existingCustomerList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                // height: 100,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Customerdetail(),
                                            ));
                                      },
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/icon.png',
                                          //   width: 80,
                                          //   height: 80,
                                        ),
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            existingCustomerList[index],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    //     Row(
                                    //       mainAxisAlignment: MainAxisAlignment.end,
                                    //       children: <Widget>[
                                    //         InkWell(
                                    //           onTap: () {
                                    //             _action("approve");
                                    //           },
                                    //           child: Image.asset(
                                    //             'assets/images/a.png',
                                    //             width: 40,
                                    //             height: 40,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       mainAxisAlignment: MainAxisAlignment.end,
                                    //       children: <Widget>[
                                    //         InkWell(
                                    //           onTap: () {
                                    //             _action("reject");
                                    //           },
                                    //           child: Image.asset(
                                    //             'assets/images/b.png',
                                    //             width: 40,
                                    //             height: 40,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  void _action(String name, String phone, String status) {
    http.post(actionURL, body: {
      "phone": phone,
      "status": status,
    }).then((res) {
      if (res.body == "success") {
        getData();
        getCustomer();
      }
    });
  }

  void _onBackPressAppBar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Mamamainpage(
            phone: widget.phone,
          ),
        ));
  }

  void getData() async {
    customerList.clear();
    http.post(customerListURL, body: {
      "phone": widget.phone,
    }).then((res) {
      print(res.body);
      if (res.body != "nodata") {
        var list = json.decode(res.body);
        for (var data in list) {
          Customer customer = Customer(
            name: data['name'],
            phone: data['phone'],
          );
          customerList.add(customer);
        }
      }
      setState(() {
        data = true;
      });
      if (data == true && customer == true) {
        setState(() {
          ready = true;
        });
      }
    });
  }

  void getCustomer() async {
    existingCustomerList.clear();
    http.post(existingCustomerListURL, body: {
      "phone": widget.phone,
    }).then((res) {
      print(res.body);
      if (res.body != "nodata") {
        var list = json.decode(res.body);
        existingCustomerList = list;
      }
      setState(() {
        customer = true;
      });
      if (data == true && customer == true) {
        setState(() {
          ready = true;
        });
      }
    });
  }
}

class Customer {
  String name, phone;
  Customer({this.name, this.phone});
}
