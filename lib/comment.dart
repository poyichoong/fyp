import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/cooker.dart';
import 'package:fyp/customeracc.dart';
import 'package:fyp/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/mainPage.dart';
import 'package:fyp/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Comment extends StatefulWidget {
  final String phone;
  final String shopName;
  final String address;
  final String userPhone;
  Comment({Key key, this.phone, this.shopName, this.address, this.userPhone})
      : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController _commentcontroller = TextEditingController();
  final ScrollController controller = ScrollController();
  final ScrollController _scrollController = ScrollController();
  String detailsURL = "http://192.168.43.245/fyp/detail.php";
  String checkURL = "http://192.168.43.245/fyp/checking.php";
  String menuURL = "http://192.168.43.245/fyp/menu.php";
  String feedbackURL = "http://192.168.43.245/fyp/feedback.php";
  String feedbacklistURL = "http://192.168.43.245/fyp/feedbacklist.php";
  String _ranking;
  List<CommentInfo> commentList = [];
  List food = [];
  List details = [];
  bool star1, star2, star3, ready, foodStatus, detailStatus;
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/images/1.jpeg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/mamacooklg.png',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    star1 = false;
    star2 = false;
    star3 = false;
    foodStatus = false;
    detailStatus = false;
    ready = false;
    _getData();
    _getDetails();
    _getMenu();
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
              "Mama Cook",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              popupMenuButton(),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.shopName,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.address,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(imgList, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _current == index ? Colors.redAccent : Colors.green,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Menu",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 60,
                      child: Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Column(
                            children: <Widget>[
                              for (int i = 0; i < details.length; i++)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      details[i],
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
                SizedBox(
                  height: 10,
                ),
                (ready == true && detailStatus == true && foodStatus == true)
                    ? Container(
                        height: 300,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemExtent: 100,
                          scrollDirection: Axis.vertical,
                          itemCount: commentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 100,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      'assets/images/icon.png',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      (commentList[index].ranking == "1")
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'assets/images/full.png',
                                                        width: 20),
                                                  ],
                                                )
                                              ],
                                            )
                                          : (commentList[index].ranking == "2")
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'assets/images/full.png',
                                                        width: 20),
                                                    Image.asset(
                                                        'assets/images/full.png',
                                                        width: 20),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'assets/images/full.png',
                                                        width: 20),
                                                    Image.asset(
                                                        'assets/images/full.png',
                                                        width: 20),
                                                    Image.asset(
                                                        'assets/images/full.png',
                                                        width: 20),
                                                  ],
                                                ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(commentList[index].comment)
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/images/icon.png',
                        )),
                    SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    star1 = true;
                                    star2 = false;
                                    star3 = false;
                                    _ranking = "1";
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: (star1 == false)
                                      ? Image.asset('assets/images/no.png')
                                      : Image.asset('assets/images/full.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    star1 = true;
                                    star2 = true;
                                    star3 = false;
                                    _ranking = "2";
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: (star2 == false)
                                      ? Image.asset('assets/images/no.png')
                                      : Image.asset('assets/images/full.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    star1 = true;
                                    star2 = true;
                                    star3 = true;
                                    _ranking = "3";
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: (star3 == false)
                                      ? Image.asset('assets/images/no.png')
                                      : Image.asset('assets/images/full.png'),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1, color: Colors.white),
                                right:
                                    BorderSide(width: 1, color: Colors.white),
                                bottom:
                                    BorderSide(width: 1, color: Colors.white),
                                left: BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                            child: TextField(
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              controller: _commentcontroller,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text("Send"),
                        onPressed: _send,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    'Order',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: _orderDialogShow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _orderDialogShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('phone');
    http.post(checkURL, body: {
      "phone": phone,
      "cookerphone": widget.phone,
    }).then((res) {
      if (res.body == 'yes') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Order duplicate"),
              content: Text("Your order is duplicate."),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Done"))
              ],
            );
          },
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Order(
              phone: widget.phone,
            ),
          ),
        );
      }
    });
  }

  void _send() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('phone');
    http.post(feedbackURL, body: {
      "phone": phone,
      "ranking": _ranking,
      "comment": _commentcontroller.text,
      "cooker_phone": widget.phone,
    }).then((response) {
      if (response.body == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Send Successful"),
              content: Text("Your feeback have been sent."),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                    },
                    child: Text("Ok"))
              ],
            );
          },
        );
      }
    }).catchError((err) {
      print("error: " + err.toString());
    });
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
          value: "cooker",
          child: Text(
            "Cooker",
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
        ),
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
          case "cooker":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Cooker(
                    phone: widget.userPhone,
                  ),
                ));
            break;
          case "account":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Customeracc(),
                ));
            break;
        }
      },
    );
  }

  void _getData() async {
    http.post(feedbacklistURL, body: {
      "cookerphone": widget.phone,
    }).then((res) {
      print(res.body);
      if (res.body != null) {
        var list = json.decode(res.body);
        for (var data in list) {
          CommentInfo comment = CommentInfo(
            phone: data['phone'],
            ranking: data['ranking'],
            comment: data['comment'],
          );
          commentList.add(comment);
        }
      }
      setState(() {
        ready = true;
      });
    });
  }

  void _getDetails() async {
    http.post(detailsURL, body: {
      "cookerphone": widget.phone,
    }).then((res) {
      if (res.body != "null") {
        var list = json.decode(res.body);
        details = list;
        setState(() {
          detailStatus = true;
        });
      }
    });
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

  void _onBackPressAppBar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
  }
}

class CommentInfo {
  String phone, ranking, comment;
  CommentInfo({this.phone, this.ranking, this.comment});
}
