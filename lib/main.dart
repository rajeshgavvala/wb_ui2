
import 'package:flutter/material.dart';
import 'package:uiflutter/wbHome.dart';


void main() => runApp(
  DigitalApp()
);

class DigitalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/wb_home',
      routes: <String, WidgetBuilder>{
        '/wb_home'         : (context) => HomePage(),
                
        },
      );
    }
}



/*
'/wbapi/loginAs'     : (context) => LoginAs(),
'/wbapi/login/user'  : (context) => UserLogin(),
        '/wbapi/login/admin' : (context) => AdminLogin(),
        '/wbapi/login/owner' : (context) => OwnerLogin(),

        '/wbapi/userSignup' :(context) => UserSignup(),
        '/wbapi/adminSignup':(context) => AdminSignup(),
        '/wbapi/ownerSignup':(context) => OwnerSignup(),

        
        '/wbapi/productUserSignup':(context) => ProductUserSignup(),
        '/wbapi/pInfo':(context) => PInfo(),
        '/wbapi/pie' :(context) => MontlyExpensesView(),
        '/wbapi/piechart' :(context) => HomePie(),
        '/wbapi/listIssues':(context) => ListIssues(),
        '/wbapi/retailer':(context) => RetailerPage(),

        '/reportProblem':(context) => ReportProblem(), */