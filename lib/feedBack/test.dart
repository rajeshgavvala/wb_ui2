import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePie extends StatefulWidget {
  @override
  _HomePieState createState() => _HomePieState();
}

class _HomePieState extends State<HomePie> {
  @override
  Widget build(BuildContext context) {
  
  var data = [
    FeedbackUser('Poor(1-2)', 500, Colors.red),
    FeedbackUser('Average(2-3)', 1000, Colors.orange),
    FeedbackUser('Good(3-4)', 1500, Colors.blue),
    FeedbackUser('Excellent(4-5)', 2000, Colors.green),
  ];

  var series = [
    charts.Series(
      domainFn: (FeedbackUser userFeedback,_)=>userFeedback.list,
      measureFn: (FeedbackUser userFeedback,_)=>userFeedback.value,
      colorFn:(FeedbackUser userFeedback,_)=>userFeedback.color,
      id: 'UserFeedback',
      data: data,
      labelAccessorFn: (FeedbackUser userFeedback,_)=> '${userFeedback.list} : ${userFeedback.value.toString()}'
    )
  ];

  var chart = charts.PieChart(
    series,
    defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [charts.ArcLabelDecorator()],
    arcWidth: 100,
    ),
    animate: false,
  );

    return Scaffold(
      appBar: AppBar(
        title: Text("OwnerPage"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text("User Feedback Review"),
            SizedBox(height: 400,
            child: chart,
            ),
          ],
        ),
        ),
    );
  }
}

class UserFeedback {
}

class FeedbackUser{
  final String list;
  final int value;
  final charts.Color color;

  FeedbackUser(this.list, this.value, Color color)
  : this.color = charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}