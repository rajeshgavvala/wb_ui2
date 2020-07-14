import 'dart:convert';

import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uiflutter/user/userModel/retail.dart';
import 'package:http/http.dart' as http;


class RetailerPage extends StatefulWidget {
  @override
  _RetailerPageState createState() => _RetailerPageState();
}

class _RetailerPageState extends State<RetailerPage> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autoValidate = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _productCode = TextEditingController();

  String email;
  String mobile;
  String productCode;
  String purchasedOn = new DateFormat('yyyy-MM-dd').format(new DateTime.now());

  String responceMessage;

  Future<RetailAttributes> activateWarranty(
    String email, 
    String mobile,
    String productCode,
    String purchasedOn) async {
    final http.Response response = await http.post(
    'http://10.0.2.2:8081/retailer/warranty/activate',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'mobile': mobile,
      'productCode': productCode,
      'purchasedOn': purchasedOn,
    }),
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    _showSnackBar("${jsonResponse['result']}");
    print('jsonResponse: '+jsonResponse['result']);
    return new RetailAttributes.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create User responce.');
  }
}

@override
  void initState() {
    super.initState();
  }
  
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller:_email,
                onChanged: (String val){
                              email = val;
                              },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter User Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            controller:_mobileNumber,
                onChanged: (String val){
                              mobile = val;
                              },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter User Mobile',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            controller:_productCode,
                onChanged: (String val){
                              productCode = val;
                              },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.category,
                color: Colors.white,
              ),
              hintText: 'Enter Product Id',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildSignupBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () => _submit(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey[700],
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildScannerBtn(){
    return new Container(
      child: RaisedButton(
        color: Color(0xFF6CA8F1),
        elevation: 0.0,
        onPressed: () => scan(),
        padding: EdgeInsets.all(14.0),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.scanner, size:30,color: Colors.white,),
            SizedBox(width: 10,),
            Column(
              children: <Widget>[
                Text('Scan QRcode or Barcode',
                style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            //fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
          ),
                ],
              ),
            ],
          ),
        ),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Product Retailer Page'),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {Navigator.pushNamed(context,'/wbapi');},
          ),
      ),
      body: new Form(
        key: formKey,
        autovalidate: autoValidate,
        child: runGUI(),
      ),
    );
  }

  Widget runGUI(){
    return new Container(
        height: double.infinity,
        child: SingleChildScrollView(
          //Text("Product Warranty Activation"),
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Product Warranty Activation',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0
                    ),
                  _buildEmailTF(),
                  SizedBox(
                    height: 30.0,
                    ),
                  _buildPasswordTF(),
                  SizedBox(
                    height: 30.0,
                    ),
                  _buildProductTF(),
                  SizedBox(
                    height: 10.0,
                    ),
                    Text(
                      '--OR--',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildScannerBtn(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: _buildSignupBtn(),
                      ),
            ],
          ),
        ),
      );
  }
  
  Future scan() async {
    try{
      String barcode = (await BarcodeScanner.scan()) as String;
      setState(() {
        this.productCode = barcode;
      });
    }catch(e){
      setState(() {
        this.productCode = "";
      });
    }
  }


  void _submit() async{
    print('hello');
    if (formKey.currentState.validate()) {
      formKey.currentState.save(); 

    print("email: " + email);
    print("mobile: " + mobile);
    print("productCode: " + productCode);
    print("purchasedOn: " + purchasedOn);
    

    activateWarranty(email,mobile,productCode,purchasedOn);
    

    formKey.currentState.reset();

    formKey.currentState.reset();

    await new Future.delayed(const Duration(seconds: 3));

    //Navigator.pushNamed(context, '/wbapi/login');
    Navigator.push(
          context, MaterialPageRoute(builder: (context) => RetailerPage()));
    

     }else{
       setState(()=>autoValidate=true);
     }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  } 
}

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);