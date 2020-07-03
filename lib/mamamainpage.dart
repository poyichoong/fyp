import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/customerlist.dart';
import 'package:fyp/main.dart';
import 'package:fyp/menu.dart';
import 'package:fyp/cookeracc.dart';
import 'package:http/http.dart' as http;

class Mamamainpage extends StatefulWidget {
  final String phone;
  Mamamainpage({Key key, this.phone}) : super(key: key);

  @override
  _MamamainpageState createState() => _MamamainpageState();
}

class _MamamainpageState extends State<Mamamainpage> {
  ScrollController _scrollController = ScrollController();
  String menuURL = "http://192.168.43.245/fyp/menu.php";
  String detailURL = "http://192.168.43.245/fyp/detail.php";
  String addressURL = "http://192.168.43.245/fyp/address.php";
  CarouselSlider carouselSlider;
  int _current = 0;
  String name, address;
  bool foodStatus, detailStatus;
  List imgList = [
    'assets/images/1.jpeg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/mamacooklg.png',
  ];
  List food = [];
  List detail = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    name = "";
    address = "";
    foodStatus = false;
    detailStatus = false;
    _getAddress();
    _getMenu();
    _getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Mama Cook",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              popupMenuButton(),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
            carouselSlider = CarouselSlider(
              height: 200.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(seconds: 5),
              // pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      address,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Menu",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: 180,
                  height: 60,
                  child: 
                  (food.length == 0)
                      ? Column()
                      : Column(
                          children: <Widget>[
                            for (int i = 0; i < food.length; i++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    food[i],
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                          ],
                        ),
                ),
                // SizedBox(
                //   width: 90,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 120,
                      child: 
                      (detail.length == 0)
                          ? Column()
                          : Column(
                              children: <Widget>[
                                for (int i = 0; i < detail.length; i++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        detail[i],
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                              ],
                            ),
                    ),
                  ],
                )
              ],
            ),
          ])),
        ));
  }

  Widget popupMenuButton() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        size: 20,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "account",
          child: Text(
            "Account",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: "edit",
          child: Text(
            "Edit",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: "customer",
          child: Text(
            "Customer",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: "logout",
          child: Text(
            "Log Out",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        )
      ],
      onSelected: (selectedItem) {
        switch (selectedItem) {
          case "logout":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ));
            break;
          case "account":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Customeracc(),
                ));
            break;
          case "edit":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Menu(
                    phone: widget.phone,
                    food: food,
                    detail: detail,
                  ),
                ));
            break;
          case "customer":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Customerlist(phone: widget.phone),
                ));
            break;
        }
      },
    );
  }

  void _getMenu() async {
    http.post(menuURL, body: {
      "cookerphone": widget.phone,
    }).then((res) {
      if (res.body != "null") {
        var list = json.decode(res.body);
        food = list;
        setState(() {
          foodStatus = true;
        });
      }
    });
  }

  void _getAddress() async {
    http.post(addressURL, body: {
      "cookerphone": widget.phone,
    }).then((res) {
      var list = json.decode(res.body);
      setState(() {
        name = list[0];
        address = list[1];
      });
    });
  }

  void _getDetail() async {
    http.post(detailURL, body: {
      "cookerphone": widget.phone,
    }).then((res) {
      if (res.body != "null") {
        var list = json.decode(res.body);
        detail = list;
        setState(() {
          detailStatus = true;
        });
      }
    });
  }

  void _account() {
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register(),));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Customeracc(),
        ));
  }
}

// class DetailInfo {
//   String price, delivery, date;
//   DetailInfo({this.price,  this.delivery, this.date});
// }
