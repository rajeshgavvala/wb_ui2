

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String userId = prefs.getString('userId');
  return userId;
}
}
