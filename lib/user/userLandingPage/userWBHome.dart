import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiflutter/user/userController/userLogin.dart';

import 'package:uiflutter/user/userLandingPage/listWBUserHome.dart';
import 'package:uiflutter/user/userLandingPage/ordersList.dart';


class UserWBHome extends StatefulWidget {
  
  final String email;
  UserWBHome({Key key,@required this.email}) : super(key: key);

  @override
  _UserWBHomeState createState() => _UserWBHomeState();
}

class _UserWBHomeState extends State<UserWBHome> {
  SharedPreferences sharedPreferences;
  

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences.getString("userId") == null)
    if(sharedPreferences.getString("userId") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => UserLogin()), (Route<dynamic> route) => false);
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    final title = "Welcome User";
    final email1 = widget.email;
    print('email1: '+email1);
     Widget imageCarousel = new Center(
        child: SizedBox(
          height: 180.0,
          child: Carousel(
            boxFit: BoxFit.fitHeight,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 2000),
            dotSize: 6.0,
            dotIncreasedColor:Colors.blue,
            dotBgColor: Colors.transparent,
            dotColor: Colors.black,
            dotPosition: DotPosition.bottomLeft,
            dotVerticalPadding: 10.0,
            showIndicator: true,
            indicatorBgPadding: 7.0,
            images: [
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/wb_logo.png'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/small.png'),
                 ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Details'),
                  onPressed: () {print("Mugs");},
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Cart'),
                  onPressed: () {print("Mugs");},
                ),
              ],
            ),
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/happy.png'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/safe.jpg'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/water.jpeg'),
                 
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/smallCatetridge.png'),
                 ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Details'),
                  onPressed: () {print("smallCatetridge");},
                ),
              ],
            ),
              ])),
              Card(
                  child:Column(mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Image.asset('images/smallBottles.png'),
                 ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: const Text('Bottles'),
                  onPressed: () {print("WaterBottles");},
                ),
              ],
            ),
              ])),
            ],
          ),
        ),
      );
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)), 
      ),
      body: new ListView(
        children: <Widget>[
        new Padding(padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child:imageCarousel,
        ),
        new Container(
          height: 400,
          child: ListWBUserHome(),
        ),
         ],
      ),
      drawer: NavDrawer(email1),
       bottomNavigationBar: BottomNavigationBar(
         backgroundColor: Colors.blue,
         selectedItemColor: Colors.black,
         unselectedItemColor: Colors.white,
         type: BottomNavigationBarType.fixed,
         items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
        ],
       ),
    );
  }
}


class NavDrawer extends StatelessWidget {
  final String user;
  NavDrawer(this.user);
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
                accountName: Text('${this.user}',
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),),
                accountEmail:Text('',
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 20.0,
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
              radius: 60,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 55,
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
            leading: Icon(Icons.account_circle),
            title: Text('MyAccount'),
            onTap: () => {}
          ),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text('Inbox'),
            onTap: () => {}
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('MyOrders'),
            onTap: () => {
              Navigator.push(
          context, MaterialPageRoute(builder: (context) => Listorders(id: '${this.user}',)))
            }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {}
          ),
        ],  
      ),
    );
  }
}


//{Navigator.of(context).pushNamed("/wbapi")},


/*
@override
  Widget build(BuildContext context) {
    final title = "Welcome User";
     Widget imageCarousel = new Container(
        height: 150.0,
        child: CarouselSlider(
          items: [
            Card(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('The Enchanted Nightingale'),
                  subtitle:
                      Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                Image.network(
                    'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
              ])),
            'images/wb_logo.png',
            'images/p1.png',
            'images/p3.png',
            'images/p4.png',
            'images/camera.jpg',
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 1.0),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: GestureDetector(
                        child: Image.asset(i, fit: BoxFit.fitHeight),
                        onTap: () {
                          Navigator.push<Widget>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(i),
                            ),
                          );
                        }));
              },
            );
          }).toList(), 
          options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
        ),
        ),
        ); */