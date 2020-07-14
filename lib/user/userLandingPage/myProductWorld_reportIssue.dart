import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:secure_random/secure_random.dart';
import 'package:uiflutter/user/userModel/issue.dart';

import 'package:http/http.dart' as http;

class ReportIssue extends StatefulWidget {
  
  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  List<DropdownMenuItem<String>> listItemsMenu = [];

  String get username => null;

  void loadDropdownList(){
    listItemsMenu = [];
    listItemsMenu.add(
      new DropdownMenuItem(
        child: new Text('Wb_101'), 
        value: 'wb_101',)
        );
    listItemsMenu.add(
      new DropdownMenuItem(
        child: new Text('Wb_102'), 
        value: 'wb_102',)
        );
    listItemsMenu.add(
      new DropdownMenuItem(
        child: new Text('Wb_103'), 
        value: 'wb_103',)
        );
  }

  String selected;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  bool autoValidate = false;

  Future<File> imageFile;

  Position _currentPosition;
  String location;

  String image;
  
  String imgDescription;

  String refId = ("WB-" + SecureRandom().nextString(length: 7));

  String date = new DateFormat('yyyy-MM-dd Hms').format(new DateTime.now());

  Future<IssueAttributes> createNewIssue(String issueId, String date, String location,String image, String description) async {
    final http.Response response = await http.post(
    'http://10.0.2.2:8081/user/issue/register',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'issueId': issueId,
      'date': date,
      'location': location,
      'image': image,
      'description': description,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    
    print(json.decode(response.body));
    
    return new IssueAttributes();
  } else {
    throw Exception('Failed to create User responce.');
  }
}

  @override
  void initState() {
    loadDropdownList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     loadDropdownList();
    return new Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Report Issue Page..."),
      ),
      body: new Form(
        key: formKey,
        autovalidate: autoValidate,
        child:runGUI(),
        ),
    );
  }
  Widget runGUI(){
        return new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:10.0)
              ),
            new Container(
              child: new Center(
                child: new DropdownButton(
                  value: selected,
                  items: listItemsMenu,
    
              hint: new Text("Select Product"),
              iconSize: 40.0,
              elevation: 0,
              onChanged: (val) {
                setState(() {
                  selected = val;
                });
              }),
              ),
            ),
    
            Padding(
              padding: EdgeInsets.only(top:10.0)
              ),
    
            new InkWell(
              onTap: () => _pickImage(),
              child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/camera.jpg'),
                  ),
                ),
              ),
            
            new RaisedButton.icon(
             icon: Icon(Icons.add_location),
             label: Text('Location'),
             onPressed:()=>_getCurrentLocation(),
            ),
            new SizedBox(
              height: 10.0,
            ),
    
            new Container(
              height: 120.0,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:"briefly describe the issue!",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.black),
                  ),
                ),
                onChanged: (val) {
                  if(val!=null){
                    imgDescription=val;
                  }
                  return val;
                },
              ),
              padding: EdgeInsets.only(left:50.0,right: 50.0),
              
            ),
            new SizedBox(
              height: 10.0,
            ),
            
            new RaisedButton(
              onPressed:()=> _submit(username),
          child: new Text('Report Issue'),
          color: Colors.blue,
          ),
        ],
      );
    }

  void _submit(String username) async{
    if (formKey.currentState.validate()) {
      formKey.currentState.save(); 

    print("refId: " + refId);
    print("date: " + date);
    print("location: " + location);
    //print("image: "+image);
    print("imgDescription: " + imgDescription);
    

    createNewIssue(refId,date,location,image,imgDescription);
    

    formKey.currentState.reset();

    _showSnackBar("Issue $refId sent successfully");

    formKey.currentState.reset();

    await new Future.delayed(const Duration(seconds: 3));

    //Navigator.pushNamed(context, '/wbapi/login');
    //Navigator.push(
      //    context, MaterialPageRoute(builder: (context) => UserWBHome()));
    

     }else{
       setState(()=>autoValidate=true);
     }
  }

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            )
    );
    if(imageSource != null) {
    final imageFile = await ImagePicker.pickImage(source: imageSource);
    
    String image64 = base64Encode(imageFile.readAsBytesSync());
    
    if(image64 != null) {
      setState(() => image=image64);
    }
  }
}

  _getCurrentLocation(){
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
      });

      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

     setState(() {
        location =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        
      });     

    }).catchError((e) {
      print(e);
    });
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  } 
}

