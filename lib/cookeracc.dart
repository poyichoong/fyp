import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/mamamainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customeracc extends StatefulWidget {
  Customeracc({Key key}) : super(key: key);

  @override
  _CustomeraccState createState() => _CustomeraccState();
}

class _CustomeraccState extends State<Customeracc> {
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final ScrollController controller = ScrollController();

  String infoURL = "http://192.168.43.245/fyp/cookerinfo.php";
  String updateCustomerURL = "http://192.168.43.245/fyp/updateCooker.php";
  String userType, phone;

  @override
  void initState() {
    userType = "";
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 139, 1),
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
              "Cooker Account",
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
                  Image.asset(
                    'assets/images/icon.png',
                    width: 150,
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        controller: _namecontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      controller: _passcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "State",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      controller: _addresscontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Usertype",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minWidth: 80,
                        height: 50,
                        child: Text(
                          'Customer',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                         color: (userType == "Customer")
                            ? Colors.grey
                            : Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minWidth: 100,
                        height: 50,
                        child: Text(
                          'Cooker',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        color: (userType == "Cooker")
                            ? Colors.grey
                            : Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
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
                          'Update',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: _update,
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
    http.post(infoURL, body: {
      "phone": phone,
    }).then((res) {
      print(res.body);
      var extractdata = json.decode(res.body);
      setState(() {
        _namecontroller.text = extractdata[0] ?? "";
        _passcontroller.text = extractdata[1] ?? "";
        _addresscontroller.text = extractdata[2] ?? "";
        userType = extractdata[3];
      });
    });
  }

  void _update() async {
    http.post(updateCustomerURL, body: {
      "name": _namecontroller.text,
      "password": _passcontroller.text,
      "phone": phone,
      "address": _addresscontroller.text,
      "user_type": userType,
    }).then((response) {
      if (response.body == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Update Successful"),
              content: Text("Your data have been update."),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mamamainpage(),
                          ));
                    },
                    child: Text("Done"))
              ],
            );
          },
        );
      }
    }).catchError((err) {
      print("error: " + err.toString());
    });
  }

  void _onBackPressAppBar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Mamamainpage(phone: phone,),
        ));
  }
}
