
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  FeedBack({Key key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeedBack'),
      ),
      body: Center(
        child: Text('See your messages here!')
      ),
    );
  }
}