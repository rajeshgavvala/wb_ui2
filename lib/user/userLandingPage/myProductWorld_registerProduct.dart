

import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class RegisterProduct extends StatefulWidget {
  RegisterProduct({Key key}) : super(key: key);

  @override
  _RegisterProductState createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String productId;

  String barcode = "";

  bool _isLoading;
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
       appBar: AppBar(
         title: Text('Register New Product'),
       ),
      body: new Form(
        key: formKey,
        child:runGUI(),
        ), 
    );
  }

  Widget runGUI(){
   return new Column(
     children: <Widget>[
          new Container(
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText:"Enter product Id to Register!",
              border: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.black),
              ),
            ),
            onChanged: (val) {
              if(val!=null){
                productId = val; 
              }
              return val;
            },
          ),
          padding: EdgeInsets.only(left:50.0,right: 50.0, top: 50.0, bottom: 10.0),
        ),

        new Text('--OR--',  
        style: TextStyle(
          fontWeight:FontWeight.bold,
        )),

        new Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(horizontal:50.0, vertical:10.0),
            child: RaisedButton(
          onPressed: scan,
          color: Colors.grey,
          textColor: Colors.brown[900],
          child: Row(
            children: <Widget>[
              Icon(Icons.scanner, size:30,),
              SizedBox(width: 10,),
              Column(
                children: <Widget>[
                  Text('Click to open Camera'),
                  SizedBox(height: 2,),
                  Text("Scans QRcode or Barcode")
                ],
              ),
            ],
            ),
          ),
        ),
      ],
    ),
    Padding(
            padding: EdgeInsets.symmetric(horizontal:30.0, vertical:8.0),
            child: Text(barcode, textAlign: TextAlign.center,),
            ),

        new RaisedButton(
          onPressed:()=> _submit(),
          child: new Text('Register Product'),
          color: Colors.amberAccent,
          ),
        ]

   );
  }

   void _submit() async{
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString('userId');

    var jsonResponse;
    var response = await http.post(
      'http://10.0.2.2:8081/user/product/add',

      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',},
      
      body: jsonEncode(<String, String>{
       'id': productId,
        }),
    );

    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("id:");
      print(jsonResponse['id']);
      print(response.body);
      if(jsonResponse['id']==null){
         _showSnackBar("productId is worng!");
         await new Future.delayed(const Duration(seconds: 4));
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => RegisterProduct()), (Route<dynamic> route) => false);
        }else if(jsonResponse['accessToken']!= null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("_id", jsonResponse['_id']);
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ProductUserSignup()), (Route<dynamic> route) => false);
      }
    }

    print(response.statusCode);

  
    print("productId: " + productId);


    _showSnackBar(" $productId sent successfully");

    formKey.currentState.reset();

    await new Future.delayed(const Duration(seconds: 3));

    Navigator.pushNamed(context, '/wbapi/productUserSignup');
    //Navigator.push(
      //    context, MaterialPageRoute(builder: (context) => UserWBHome()));
     }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  Future scan() async {
    try{
      String barcode = (await BarcodeScanner.scan()) as String;
      setState(() {
        this.barcode = barcode;
      });
    }catch(e){
      setState(() {
        this.barcode = "";
      });
    }
  }
}

/*
RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'skip validate product? ',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'SignUp',
              recognizer: new TapGestureRecognizer()..onTap = () => {
                Navigator.pushNamed(context, '/wbapi/userSignup')},
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'have an account? ',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Login',
              recognizer: new TapGestureRecognizer()..onTap = () => {
                Navigator.pushNamed(context, '/wbapi/login/user')},
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
 */
