import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/comment.dart';
import 'package:fyp/cooker.dart';
import 'package:fyp/customeracc.dart';
import 'package:fyp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  ScrollController _scrollController = ScrollController();
  String cookerURL = "http://192.168.43.245/fyp/cooker.php";
  CarouselSlider carouselSlider;
  int _current = 0;
  bool ready;
  String phone = "";
  List imgList = [
    'assets/images/1.jpeg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/mamacooklg.png',
  ];
  List<CookerInfo> cookerList = [];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    ready = false;
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 205, 0.5),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                "Propolar Cooker",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          (ready == false)
              ? Container()
              : Flexible(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemExtent: 100,
                    scrollDirection: Axis.vertical,
                    itemCount: cookerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Comment(phone: cookerList[index].phone,
                                  shopName: cookerList[index].name,
                                  address:  cookerList[index].address,
                                  userPhone: phone,
                                  ),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/images/icon.png',
                                ),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      cookerList[index].name,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
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
                                  Text(
                                    cookerList[index].address,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      // ),
    );
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
            "Logout",
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
          case "cooker":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Cooker(phone: phone,),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs.get('phone');
    });
    
    http.post(cookerURL, body: {}).then((res) {
      var list = json.decode(res.body);
      for (var data in list) {
        CookerInfo cooker = CookerInfo(
          name: data['name'],
          address: data['address'],
          phone: data['phone'],
        );
        cookerList.add(cooker);
      }
      setState(() {
        ready = true;
      });
    });
  }

  goToPrevious() {
    carouselSlider.previousPage(
        duration: Duration(seconds: 5), curve: Curves.ease);
  }

  goToNext() {
    carouselSlider.nextPage(
        duration: Duration(seconds: 5), curve: Curves.decelerate);
  }
}

class CookerInfo {
  String name, address, phone;
  CookerInfo({this.name, this.address, this.phone});
}
