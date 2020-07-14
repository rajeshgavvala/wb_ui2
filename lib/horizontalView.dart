import 'package:flutter/material.dart';


class HorizontalList extends StatelessWidget {
  const HorizontalList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            location: 'images/p2.png',
            caption: 'products',
            function: '/wbapi'
          ),
          Category(
            location: 'images/p3.png',
            caption: 'filters',
            function: 'Hello_2'
          ),
          Category(
            location: 'images/p4.png',
            caption: 'others',
            function: 'Hello_3'
          ),
          Category(
            location: 'images/s.png',
            caption: 'filters',
            function: 'Hello_4'
          ),
          
        ],
      ),
    );
  }
}


class Category extends StatelessWidget{
  final String location;
  final String caption;
  final String function;

  Category({
    this.location,
    this.caption,
    this.function
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {Navigator.pushNamed(context,function);},
        child: CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.blueGrey,
          child:Image.asset(
            location,
            //width: 50.0,
            //height: 150.0,
          ),
        ),
      ),
    );
  }
}

