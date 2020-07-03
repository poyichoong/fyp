import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/comment.dart';
import 'package:fyp/cookerlist.dart';
import 'package:fyp/mainPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Cooker extends StatefulWidget {
  final String phone;
  Cooker({Key key, this.phone}) : super(key: key);

  @override
  _CookerState createState() => _CookerState();
}

class _CookerState extends State<Cooker> {
  ScrollController _scrollController = ScrollController();
  bool order, approve, ready;
  String phone;

  List<OrderList> orderList = [];
  List<OrderList> approveList = [];
  String orderListURL = "http://192.168.43.245/fyp/getOrder.php";
  String approveListURL = "http://192.168.43.245/fyp/approveList.php";

  @override
  void initState() {
    initial();
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
                "Cooker",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your Order List",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              (orderList.length == 0)
                  ? Container(
                      height: 100,
                    )
                  : Flexible(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemExtent: 150,
                        scrollDirection: Axis.vertical,
                        itemCount: orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Cookerlist(
                                            phone: widget.phone,
                                            cookerphone: orderList[index].phone,
                                            cookername: orderList[index].name,
                                          ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        orderList[index].name,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              (approveList.length == 0)
                  ? Container()
                  : Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Your Approved List",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
              (approveList.length == 0)
                  ? Container()
                  : Flexible(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemExtent: 150,
                        scrollDirection: Axis.vertical,
                        itemCount: approveList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Cookerlist(
                                            phone: widget.phone,
                                            cookerphone: approveList[index].phone,
                                            cookername: approveList[index].name,
                                          ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        approveList[index].name,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ]),
      ),
    );
  }

  void _onBackPressAppBar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
  }

  void initial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
    _getOrder();
    _getApprove();
  }

  void _getOrder() {
    http.post(orderListURL, body: {
      "phone": widget.phone,
    }).then((res) {
      print(res.body);
      if (res.body != 'nodata') {
        var list = json.decode(res.body);
        for (var data in list) {
          OrderList list = OrderList(
            phone: data['phone'],
            name: data['name'],
          );
          orderList.add(list);
        }
      }
      setState(() {
        order = true;
      });
      if (approve == true && order == true) {
        setState(() {
          ready = true;
        });
      }
    });
  }

  void _getApprove() {
    http.post(approveListURL, body: {
      "phone": widget.phone,
    }).then((res) {
      if (res.body != null) {
        print(res.body);
        var list = json.decode(res.body);
        for (var data in list) {
          OrderList list = OrderList(
            phone: data['phone'],
            name: data['name'],
          );
          approveList.add(list);
        }
      }
      setState(() {
        approve = true;
      });
      if (approve == true && order == true) {
        setState(() {
          ready = true;
        });
      }
    });
  }
}

class OrderList {
  String phone, name;
  OrderList({this.phone, this.name});
}

class ApproveList {
  String phone, name;
  ApproveList({this.phone, this.name});
}
