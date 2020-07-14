import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiflutter/admin/adminLandingPage/listIssuesShow.dart';
import 'package:uiflutter/owner/ownerController/ownerLogin.dart';


class OwnerWBHome extends StatefulWidget {
  OwnerWBHome({Key key}) : super(key: key);

  @override
  _OwnerWBHomeState createState() => _OwnerWBHomeState();
}

class _OwnerWBHomeState extends State<OwnerWBHome> {
  SharedPreferences sharedPreferences;

   @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("accessToken") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OwnerLogin()), (Route<dynamic> route) => false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Welcome Owner", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OwnerLogin()), (Route<dynamic> route) => false);
            },
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: Center(child: Text("Owner Page")),
      
    );
  }
}


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient:LinearGradient(colors:<Color>[
                Colors.white,
                Colors.blueAccent
              ])
            ),
            child: Container(
              child: Image.asset("images/wb_logo.png"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Stats'),
            onTap: () => {
              Navigator.of(context).pushNamed("/wbapi/pie")
              //Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssuesAll()))
            }
          ),
        ],
      ),
    );
  }
}

//{Navigator.of(context).pushNamed("/wbapi")},

// Navigator.push(context,MaterialPageRoute(builder: (context) => ProductInfo()))