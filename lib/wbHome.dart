import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DigiApp"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {Navigator.pushNamed(context,'/wbapi/loginAs');},
              textColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Colors.grey[800],
                size: 30.0,),
              )
        ],
        automaticallyImplyLeading: false,
      ),
    );
    
  }
}








