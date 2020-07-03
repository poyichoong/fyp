import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/mamamainpage.dart';
import 'package:fyp/register.dart';
import 'package:fyp/pwd.dart';
import 'package:fyp/mainPage.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final ScrollController controller = ScrollController();
  List data = ["Customer", "Cooker"];
  String _name, _password, _mySelection;
  String loginURL = "http://192.168.43.245/fyp/login.php";
  String userType = "";

  @override
  void initState() {
    _mySelection = "Customer";
    _phonecontroller.text = '';
    _passcontroller.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(0, 0, 139, 0.5),
        backgroundColor: Color.fromRGBO(0, 0, 128, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 205, 0.5),
            elevation: 1,
            centerTitle: true,
            title: Text(
              "Login",
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
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/mamacooklg.png',
                  width: 150,
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Phone number",
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Password",
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
                    controller: _passcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "User Type",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Colors.white, style: BorderStyle.solid),
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
                  height: 10,
                ),
                InkWell(
                    onTap: _pwd,
                    child: Text("Forget Password",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: _register,
                    // onTap: _register,
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    _login();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    print(_mySelection);
    http.post(loginURL, body: {
      "phone": _phonecontroller.text,
      "password": _passcontroller.text,
      "user_type": _mySelection,
    }).then((response) async {
      print(response.body);
      var extractdata = json.decode(response.body);
      if (extractdata[0] == "success") {
        extractdata.removeAt(0);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', extractdata[0]);
        if (_mySelection == "Customer") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ));
        } else {
          print(_phonecontroller.text);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Mamamainpage(phone: _phonecontroller.text,),
              ));
        }
      } else {
        Toast.show("Login Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print("error: " + err.toString());
    });
  }

  void _pwd() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Pwd(),
        ));
  }

  void _register() {
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register(),));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ));
  }
}
