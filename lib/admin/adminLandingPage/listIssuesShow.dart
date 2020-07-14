

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uiflutter/user/userModel/issue.dart';
import 'package:http/http.dart' as http;

class ListIssuesAll extends StatefulWidget {
  ListIssuesAll({Key key}) : super(key: key);

  @override
  _ListIssuesAllState createState() => _ListIssuesAllState();
}

class _ListIssuesAllState extends State<ListIssuesAll> {
  
  
  List<IssueAttributes> _issues = List<IssueAttributes>();

  File file;

 

  Future<List<IssueAttributes>> getIssues() async {

    var response = await http.post(
      'http://10.0.2.2:8081/user/issue/listIssues',
    );

    var issues = List<IssueAttributes>();

    if(response.statusCode==200){
      var responseJson = json.decode(response.body);
      var issuesJson = responseJson["issues"];

      for (var issueJson in issuesJson) {
        issues.add(IssueAttributes.fromJson(issueJson));
      }
   }
   return issues;
  }

@override
  void initState() {
    getIssues().then((value) {
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