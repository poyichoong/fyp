
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/payment.dart';
import 'package:fyp/payment2.dart';
import 'package:fyp/payment3.dart';

class Payment2 extends StatefulWidget {
  Payment2({Key key}) : super(key: key);

  @override
  _Payment2State createState() => _Payment2State();
}

class _Payment2State extends State<Payment2> {
  final ScrollController controller = ScrollController();
  List data =["Maybank", "Bank Islam"];
  String _mySelection, _myChoice;

  @override
  void initState() {
    _mySelection = "Maybank";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 128, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 205, 0.5),
            elevation: 1,
            centerTitle: true,
            title: Text(
              "Housewife 01",
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
            margin: EdgeInsets.all(40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      Text(
                        "Your total payment is RM 125.",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      Text(
                        "Please select your payment method in icon below.",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon:Icon(Icons.credit_card, size: 50.0),
                        color: Colors.white,
                        onPressed: _onPayment,
                      ),
                      SizedBox(
                        width:120
                      ),
                      IconButton(
                        icon:Icon(Icons.account_balance, size: 50.0),
                        color: Colors.white,
                        onPressed: _onPayment2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height:10
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("    Credit card",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                      SizedBox(width:95),
                       Text("Online bank",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                    ]
                    
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Select your bank.",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minWidth: double.infinity,
                        height: 50,
                        child: Text(
                          'Pay',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: _onPayment3,
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _onPayment() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Payment(),
        ));
  }
  void _onPayment2() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Payment2(),
        ));
  }

  void _onPayment3() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Payment3(),
        ));
  }
}