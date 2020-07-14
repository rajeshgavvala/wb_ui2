
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiflutter/user/userModel/issue.dart';

class ListIssues extends StatefulWidget {
  ListIssues({Key key}) : super(key: key);

  @override
  _ListIssuesState createState() => _ListIssuesState();
}

class _ListIssuesState extends State<ListIssues> {

  

  List<IssueAttributes> _issues = List<IssueAttributes>();

  File file;
  String userId;

  checkLoginStatus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   userId = sharedPreferences.getString('userId');
   print('userId'+userId);
  }

  Future<List<IssueAttributes>> getIssues(String userId) async {

    var response = await http.post(
      'http://10.0.2.2:8081/user/issue/listIssues',

      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',},
      
      body: jsonEncode(<String, String>{
       'id': userId,
        }),
    );

    var issues = List<IssueAttributes>();

    print(response.statusCode);

    if(response.statusCode==200){
      var responseJson = json.decode(response.body);

      var issuesJson = responseJson["result"];

      for (var issueJson in issuesJson) {
        issues.add(IssueAttributes.fromJson(issueJson));
      }
   }
   return issues;
  }

@override
  void initState() {
    getIssues(userId).then((value) {
      setState(() {
        _issues.addAll(value);
      });
    });
    super.initState();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListIssues'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _issues[index].issueId,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    _issues[index].date,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                    _issues[index].location,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                    _issues[index].description,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Image.memory(
      base64Decode(_issues[index].image),
      fit: BoxFit.fill,
    ),
                  
                ],
              ),
            ),
          );
        },
        itemCount: _issues.length,
      )
    );
  }
}
