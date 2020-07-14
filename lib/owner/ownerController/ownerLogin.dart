import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uiflutter/owner/ownerLandingPage/ownerWBHome.dart';



class OwnerLogin extends StatefulWidget {
  @override
  _OwnerLoginState createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {

  bool _isLoading = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    var loginBtn = new RaisedButton(
          child:new Text("Login"),
          color: Colors.green,
          onPressed:() {
          setState(() {
            _isLoading = true;
          });
          signIn(_username.text, _password.text);
        },
      );

    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: _isLoading ? Center(child: CircularProgressIndicator()): new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  controller: _username,
                  validator: (String val)=> (val!=null) ? validatEmailMobile(val):null,
                  
                  decoration: new InputDecoration(labelText: "Username",hintText: "Email Id/Mobile Number"),

                  //onSaved: (val){_username = val as TextEditingController;},
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                   controller: _password,
                  obscureText: true,
                  decoration: new InputDecoration(labelText: "Password",hintText: "password"),
                  //onSaved: (val){_password = val as TextEditingController;},
                ),
              )
            ],
          ),
        ),loginBtn,
        RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'are you new to WB_app? ',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              recognizer: new TapGestureRecognizer()..onTap = () => {
                Navigator.pushNamed(context, '/wbapi/ownerSignup')},
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      ],
    );
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ProductOwner...Page!"),
      automaticallyImplyLeading: false,
      leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {Navigator.pushNamed(
          context, '/wbapi/loginAs');},
          ),
      ),
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(username);
    print(password);

    var jsonResponse;
    var response = await http.post(
      "http://192.168.0.108:8080/wbapi/auth/owner/login",

      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',},
      
      body: jsonEncode(<String, String>{
       'username': username,
        'password': password,}),
    );

    print(response.statusCode);
    print(jsonResponse = json.decode(response.body));

    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("token:");
      print(jsonResponse['accessToken']);
      if(jsonResponse['accessToken']==null){
         _showSnackBar("username or password worng!");
         await new Future.delayed(const Duration(seconds: 4));
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OwnerLogin()), (Route<dynamic> route) => false);
      }else if(jsonResponse['accessToken']!=null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("accessToken", jsonResponse['accessToken']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OwnerWBHome()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      if(response.statusCode==401){
        String jsonResponse = response.body;
        Map decoded = json.decode(jsonResponse);
        String message = decoded['message'];
        _showSnackBar("$message!");
      }
    }
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  
  }
}

String validatEmailMobile(String value) {
    Pattern pattern1 =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    
    Pattern pattern2 = r'^(((\+){1}91){1}[1-9]{1}[0-9]{9})$';
    
    RegExp regex1 = new RegExp(pattern1);
    RegExp regex2 = new RegExp(pattern2);

    if ((!regex1.hasMatch(value))&(!regex2.hasMatch(value)))
      return 'Enter Valid Email ID/Mobile Number';
    else
      return null;
  }