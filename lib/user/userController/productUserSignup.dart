import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uiflutter/user/userModel/user.dart';



class ProductUserSignup extends StatefulWidget {
   ProductUserSignup({Key key}) : super(key: key);
  
  @override
  _ProductUserSignupState createState() => _ProductUserSignupState();
}

class _ProductUserSignupState extends State<ProductUserSignup> {

  Future<UserAttributes> _futureUserAttributes;
   TextEditingController _email = TextEditingController();
   TextEditingController _mobileNumber = TextEditingController();
   TextEditingController _pass = TextEditingController();
   TextEditingController _confirmPass = TextEditingController();
   


  Future<UserAttributes> createNewUser(String email, String mobile, String password) async {
    final http.Response response = await http.post(
    'http://192.168.0.108:8080/wbapi/auth/user/signup',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
       'mobile': mobile,
        'password': password,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    
    print(json.decode(response.body));
    
    return new UserAttributes.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create User responce.');
  }
}

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String email;
  String mobile;
  String password;
  
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registarion Form',
      home: Scaffold(
        key: scaffoldKey,
         resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {Navigator.pushNamed(context,'/wbapi');},
          ),
          title: Text('User Registarion with Product'),
        ),
        body: Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          autovalidate: autoValidate,
          child:(_futureUserAttributes == null) ? runGUI() : FutureBuilder<UserAttributes>(
                  future: _futureUserAttributes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text("User Registered sucessfully!");
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("Error: ${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
    ),
      ),
    );  
}

Widget runGUI(){
            return new Column(
            children: <Widget>[
              new TextFormField(
                keyboardType:TextInputType.text,
                decoration:new InputDecoration(labelText: 'Email',hintText:"Enter email"),
                controller: _email,
                validator: (String val)=> (val!=null) ? validateEmail(val):null,
                onSaved: (String val)=>email=val,
              ),
              new TextFormField(
                keyboardType:TextInputType.text,
                decoration:new InputDecoration(labelText: 'Mobile',hintText:"Enter mobile number with international code"),
                controller: _mobileNumber,
                validator: (String val)=> (val!=null) ? validateMobile(val):null,
                onSaved: (String val)=>mobile=val,
              ),
              new TextFormField(
                obscureText: true,
                keyboardType:TextInputType.text,
                decoration:new InputDecoration(labelText: 'Password',hintText:"Set your password"),
                controller: _pass,
                validator: (String val){
                              if(val.isEmpty)
                                   return 'Empty';
                              else if(val.length<4){
                                return "Password @ least 4 characters length!";
                              }
                              return null;
                              },
              ),
              new TextFormField(
                obscureText: true,
                keyboardType:TextInputType.text,
                decoration:new InputDecoration(labelText: 'Confirm Password',hintText:"Confirm your password"),
                controller: _confirmPass,
                validator: (String val){
                              if(val != _pass.text)
                                   return 'Password Not Match';
                              return null;
                              },
                onSaved: (String val)=>password=val,
              ),
              new SizedBox(
          height: 10.0,
        ),
          new RaisedButton(
            onPressed:()=> _submit(),
            child: new Text('Register'),
            color: Colors.green,
            ),
          ],
        );
      }
 void _submit() async{
    if (formKey.currentState.validate()) {
      formKey.currentState.save(); 

    print(email + mobile + password);
    
    createNewUser(email,mobile,password);

    _showSnackBar("$email registered successfully and redirected to user login page shortly");

    formKey.currentState.reset();
    await new Future.delayed(const Duration(seconds: 4));

    Navigator.pushNamed(
          context, '/wbapi/login/user');
    

     }else{
       setState(()=>autoValidate=true);
     }
}

void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  
  }
  
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }


String validateMobile(String value) {
    //Pattern pattern1 = r'^((\+)49)?(0?1[5-7][0-9]{1,})$';
    Pattern pattern = r'^(((\+){1}91){1}[1-9]{1}[0-9]{9})$';

    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Indian mobile ';
    else
      return null;
  }

}


/*
onPressed: () {
                        setState(() {
                          print(_email.text + _mobileNumber.text + _confirmPass.text);
                          _futureUserAttributes = userRegistration(_email.text, _mobileNumber.text,_confirmPass.text);
                          
                          Navigator.pushNamed(context, '/wbapi/login/user');
                        });
                      },
 */
