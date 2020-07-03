import 'package:flutter/material.dart';
import 'package:fyp/comment.dart';
import 'package:fyp/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/payment.dart';

class Approve extends StatefulWidget {
  Approve({Key key}) : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  ScrollController _scrollController = ScrollController();
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
              "Approve",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              itemExtent: 150,
              scrollDirection: Axis.vertical,
              itemCount: 2,
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
                                builder: (context) => Comment(),
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
                          children: <Widget>[
                            Text(
                              "name",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                            "Waiting to be approve",
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              minWidth: double.infinity,
              height: 50,
              child: Text(
                'Payment',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ));
              }),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }

  void _onBackPressAppBar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Order(),
        ));
  }
}
