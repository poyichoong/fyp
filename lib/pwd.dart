import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/main.dart';

class Pwd extends StatefulWidget {
  Pwd({Key key}) : super(key: key);

  @override
  _PwdState createState() => _PwdState();
}

class _PwdState extends State<Pwd> {
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final ScrollController controller = ScrollController();
  String forgetURL = "http://192.168.43.245/fyp/forgetPassword.php";

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
              "Forget Password",
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
                        "Phone Number",
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
                        "New Password",
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
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minWidth: double.infinity,
                    height: 50,
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: _submit,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void _submit() async {
    http.post(forgetURL, body: {
      "password": _passcontroller.text,
      "phone": _phonecontroller.text,
    }).then((response) {
      if (response.body == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Reset Successful"),
              content: Text("Your password have been register"),
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
