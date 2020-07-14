import 'package:flutter/material.dart';

class LoginAs extends StatefulWidget {
  LoginAs({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _LoginAsState createState() => _LoginAsState();

}

class OptionsList{
  static const String user = 'ProductUser';
  static const String admin = 'ProductAdmin';
  static const String owner = 'ProductOwner';
  static const String retailer = 'ProductRetailer';
  static const String testing = 'TestPage';
  
  static const List<String> options = <String>[
    user,
    admin,
    owner,
    retailer,
    testing,
  ];
}

class _LoginAsState extends State<LoginAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Login as a..."),
          automaticallyImplyLeading: false,
          leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {Navigator.pushNamed(context,'/wbapi');},
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected:(val) => selectOption(val, context),
              itemBuilder:(BuildContext context){
                return OptionsList.options.map((String option){
                    return PopupMenuItem<String>(
                      value:option,
                      child: Text(option));
                      }).toList();
                      },
                  ),
                  ],
      ),
    );
  }
}


void selectOption(String option, BuildContext context){
  if(option==OptionsList.user){
    print("Loading Page ProductUser....");
    Navigator.pushNamed(
          context, '/wbapi/login/user');
    
  }else if(option==OptionsList.admin){
    print("Loading Page ProductAdmin....");
    Navigator.pushNamed(
          context, '/wbapi/login/admin');
    
  }else if(option==OptionsList.owner){
    print("Loading Page ProductOwner....");
    Navigator.pushNamed(
          context, '/wbapi/login/owner');

  }else if(option==OptionsList.retailer){
    print("Loading Page Retailer....");
    Navigator.pushNamed(
          context, '/wbapi/retailer');
  }
  else if(option==OptionsList.testing){
    print("Loading Page Info....");
    Navigator.pushNamed(
          context, '/wbapi/listIssues');
  }
}

/*
 Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminLoginPage()));
 */

/*
if(option==OptionsList.user){
    print("Loading Page ProductUser....");
    Navigator.pushNamed(
          context, '/wbapi/login/user');
  }else */
