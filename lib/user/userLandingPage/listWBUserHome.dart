

import 'package:flutter/material.dart';
import 'package:uiflutter/user/userLandingPage/myProductWorld.dart';
import 'package:uiflutter/user/userLandingPage/reportProblem.dart';

class ListWBUserHome extends StatefulWidget {
  ListWBUserHome({Key key}) : super(key: key);

  @override
  _ListWBUserHomeState createState() => _ListWBUserHomeState();
}

class _ListWBUserHomeState extends State<ListWBUserHome> {
  get username => null;


  @override
  Widget build(BuildContext context) {

    singleCard(iconcode, icontitle){
      return Card(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0)
        ),
        child: InkWell(
          onTap: (){
            if(iconcode == 58740){
              print('Products');
            }else if(iconcode == 57445){
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyProdcutWorld()));
            }
            else if(iconcode == 59387){
              //Navigator.push(context,MaterialPageRoute(builder: (context) => ReportProblem()));
              print('Community');
            }
            else if(iconcode == 59535){
              print('Contact Info');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(IconData(iconcode, fontFamily: 'MaterialIcons'),
              color: Colors.black,
              size: 50.0,
              ),
              Text(
                icontitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold 
                ),
              ),
            ],
            )
        ),

      );
    }

    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        singleCard(58740,'Products'),
        singleCard(57445,'My Product World'),

        singleCard(59387,'Community'),
        singleCard(57895,'Rewards'),
      ],
    );
  }
}

