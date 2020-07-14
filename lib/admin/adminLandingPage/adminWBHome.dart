import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiflutter/admin/adminController/adminLogin.dart';
import 'package:uiflutter/admin/adminLandingPage/listIssuesShow.dart';


class AdminWBHome extends StatefulWidget {
  AdminWBHome({Key key}) : super(key: key);

  @override
  _AdminWBHomeState createState() => _AdminWBHomeState();
}

class _AdminWBHomeState extends State<AdminWBHome> {
  SharedPreferences sharedPreferences;

   @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("accessToken") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => AdminLogin()), (Route<dynamic> route) => false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Welcome Admin", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => AdminLogin()), (Route<dynamic> route) => false);
            },
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: Center(child: Text("Admin Page")),
      
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
          UserAccountsDrawerHeader(
                accountName: Text('Welcome Admin',
                style: TextStyle(
                  color:Colors.black
                ),),
                accountEmail: Text('admin@email.com',
                style: TextStyle(
                  color:Colors.black
                ),),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/wb_logo.png')
                    ),
                    gradient:LinearGradient(colors:<Color>[
                      Colors.blueAccent,
                      Colors.white
              ],
              )
                ),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 45,
                child: Icon(Icons.person),
                //backgroundColor: Colors.transparent,
                //backgroundImage: AssetImage('images/camera.jpg'),
              ),
            ),
            ),
            ),
          /*
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
          ), */
          ListTile(
            leading: Icon(Icons.list),
            title: Text('List Issues'),
            onTap: () => {
              Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssuesAll()))
            }
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Analyse problems'),
            onTap: () => {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssuesAll()))
            }
          ),
           ListTile(
            leading: Icon(Icons.change_history),
            title: Text('Changes to product'),
            onTap: () => {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssuesAll()))
            }
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Dispatch products'),
            onTap: () => {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssuesAll()))
            }
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Report performance'),
            onTap: () => {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => ListIssuesAll()))
            }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
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