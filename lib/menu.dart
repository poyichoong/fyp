import 'package:flutter/material.dart';
import 'package:fyp/customeracc.dart';
import 'package:fyp/customerlist.dart';
import 'package:fyp/main.dart';
import 'package:fyp/mamamainpage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  final String phone;
  final List food;
  final List detail;
  Menu({Key key, this.phone, this.food, this.detail}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String editURL = "http://192.168.43.245/fyp/edit.php";
  final TextEditingController _foodcontroller1 = TextEditingController();
  final TextEditingController _foodcontroller2 = TextEditingController();
  final TextEditingController _foodcontroller3 = TextEditingController();
  final TextEditingController _foodcontroller4 = TextEditingController();
  final TextEditingController _foodcontroller5 = TextEditingController();
  final TextEditingController _detailcontroller1 = TextEditingController();
  final TextEditingController _detailcontroller2 = TextEditingController();
  final TextEditingController _detailcontroller3 = TextEditingController();
  ScrollController _scrollController = ScrollController();
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
    for (int i = 0; i < widget.food.length; i++) {
      _controller(i + 1).text = widget.food[i];
    }
    for (int i = 0; i < widget.detail.length; i++) {
      _detailController(i + 1).text = widget.detail[i];
    }
    super.initState();
  }

  TextEditingController _controller(int i) {
    TextEditingController controller;
    switch (i) {
      case 1:
        controller = _foodcontroller1;
        break;
      case 2:
        controller = _foodcontroller2;
        break;
      case 3:
        controller = _foodcontroller3;
        break;
      case 4:
        controller = _foodcontroller4;
        break;
      default:
        controller = _foodcontroller5;
        break;
    }
    return controller;
  }

  TextEditingController _detailController(int i) {
    TextEditingController controller;
    switch (i) {
      case 1:
        controller = _detailcontroller1;
        break;
      case 2:
        controller = _detailcontroller2;
        break;
      default:
        controller = _detailcontroller3;
        break;
    }
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios, size: 20),
            onPressed: _onBackPressAppBar,
          ),
          centerTitle: true,
          title: Text(
            "Mama Cook",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // carouselSlider = CarouselSlider(
              //   height: 200.0,
              //   initialPage: 0,
              //   enlargeCenterPage: true,
              //   autoPlay: true,
              //   reverse: false,
              //   enableInfiniteScroll: true,
              //   autoPlayInterval: Duration(seconds: 5),
              //   autoPlayAnimationDuration: Duration(seconds: 5),
              //   // pauseAutoPlayOnTouch: Duration(seconds: 10),
              //   scrollDirection: Axis.horizontal,
              //   onPageChanged: (index) {
              //     setState(() {
              //       _current = index;
              //     });
              //   },
              //   items: imgList.map((imgUrl) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //           width: MediaQuery.of(context).size.width,
              //           margin: EdgeInsets.symmetric(horizontal: 10.0),
              //           decoration: BoxDecoration(
              //             color: Colors.green,
              //           ),
              //           child: Image.asset(
              //             imgUrl,
              //             fit: BoxFit.fill,
              //           ),
              //         );
              //       },
              //     );
              //   }).toList(),
              // ),
              // SizedBox(
              //   height: 1,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: map<Widget>(imgList, (index, url) {
              //     return Container(
              //       width: 10.0,
              //       height: 10.0,
              //       margin:
              //           EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color:
              //             _current == index ? Colors.redAccent : Colors.green,
              //       ),
              //     );
              //   }),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       "Name",
              //       style: TextStyle(fontSize: 30, color: Colors.black),
              //     ),
              //   ],
              // ),
              // Container(
              //   height: 100,
              //   width: 250,
              //   decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(width: 1, color: Colors.white),
              //       right: BorderSide(width: 1, color: Colors.white),
              //       bottom: BorderSide(width: 1, color: Colors.white),
              //       left: BorderSide(width: 1, color: Colors.white),
              //     ),
              //   ),
              //   child: TextField(
              //     style: TextStyle(fontSize: 20, color: Colors.white),
              //     controller: _foodcontroller,
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.white)),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //     Text(
              //       "Food Detail",
              //       style: TextStyle(fontSize: 20, color: Colors.black),
              //     ),
              //   ],
              // ),
              // Container(
              //   height: 100,
              //   width: 250,
              //   decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(width: 1, color: Colors.white),
              //       right: BorderSide(width: 1, color: Colors.white),
              //       bottom: BorderSide(width: 1, color: Colors.white),
              //       left: BorderSide(width: 1, color: Colors.white),
              //     ),
              //   ),
              //   child: TextField(
              //     style: TextStyle(fontSize: 20, color: Colors.white),
              //     controller: _foodcontroller,
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.white)),
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       "Address",
              //       style: TextStyle(fontSize: 20, color: Colors.black),
              //     ),
              //   ],
              // ),
              //  SizedBox(
              //   height: 50,
              // ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Recipe",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _foodcontroller1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _foodcontroller2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _foodcontroller3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _foodcontroller4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _foodcontroller5,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Food Detail",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _detailcontroller1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Price per meal",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _detailcontroller2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Delivery fee",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 250,
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
                  controller: _detailcontroller3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Operation days",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),

              SizedBox(
                height: 100,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: double.infinity,
                height: 50,
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: _updateDialogShow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDialogShow() async {
    http.post(editURL, body: {
      "phone": widget.phone,
      "food1": _foodcontroller1.text,
      "food2": _foodcontroller2.text,
      "food3": _foodcontroller3.text,
      "food4": _foodcontroller4.text,
      "food5": _foodcontroller5.text,
      "detail1": _detailcontroller1.text,
      "detail2": _detailcontroller2.text,
      "detail3": _detailcontroller3.text,
    }).then((res) {
      if (res.body == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Update Successful"),
              content: Text("Your account has been updated."),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mamamainpage(
                              phone: widget.phone,
                            ),
                          ));
                    },
                    child: Text("Done"))
              ],
            );
          },
        );
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
    // Navigator.pop(context);
  }
}
