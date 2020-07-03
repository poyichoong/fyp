import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final ScrollController controller = ScrollController();
  String registerURL = "http://192.168.43.245/fyp/register.php";
  String userType = "";

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
              "Register",
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
                  SizedBox(
                    height: 30,
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
                        "Phone",
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
                      controller: _phonecontroller,
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
                        "Address",
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
                        onPressed: () {
                          setState(() {
                            userType = "Customer";
                          });
                        },
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
                        onPressed: () {
                          setState(() {
                            userType = "Cooker";
                          });
                        },
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
                          'Submit',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _submit() async {
    http.post(registerURL, body: {
      "name": _namecontroller.text,
      "password": _passcontroller.text,
      "phone": _phonecontroller.text,
      "address": _addresscontroller.text,
      "user_type": userType,
    }).then((response) {
      if (response.body == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Submit Successful"),
              content: Text("Your have been register"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
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
          builder: (context) => Login(),
        ));
  }
}
