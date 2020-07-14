import 'package:flutter/material.dart';
import 'package:uiflutter/listIssues.dart';
import 'package:uiflutter/user/userLandingPage/myProductWorld_registerProduct.dart';
import 'package:uiflutter/user/userLandingPage/reportProblem.dart';


class MyProdcutWorld extends StatefulWidget {
  
  @override
  _MyProdcutWorldState createState() => _MyProdcutWorldState();
}

class _MyProdcutWorldState extends State<MyProdcutWorld> {
  get username => null;


  @override
  Widget build(BuildContext context) {

    
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        title: Text('MyProductWorld', style: TextStyle(color: Colors.white)),
        ),
        body: new Container(
          height: 600,
          child: GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        singleCard(58727,'RegisterProduct'),
        singleCard(59570,'ReportIssue'),

        singleCard(59519,'List Issues'),
        singleCard(58405,'WarrantyStatus'),
      ],
    ),
      ),
    );
    }

    
    Widget singleCard(iconcode, icontitle){
      return new Card(
        child: InkWell(
          onTap: (){
            if(iconcode == 58727){
              Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterProduct()));
            }else if(iconcode == 59570){
              Navigator.push(context,MaterialPageRoute(builder: (context) => ReportProblem()));
            }
            else if(iconcode == 59519){
              Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssues()));
            }
            else if(iconcode == 58405){
              print('Contact Info');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(IconData(iconcode, fontFamily: 'MaterialIcons'),
              color: Colors.black,
              size: 60.0,
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
}

