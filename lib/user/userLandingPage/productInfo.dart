
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:uiflutter/horizontalView.dart';
import 'package:uiflutter/user/userLandingPage/imageScreen.dart';

class ProductInfo extends StatefulWidget {
  ProductInfo({Key key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
        height: 150.0,
        child: CarouselSlider(
          items: [
            'images/wb_logo.png',
            'images/p1.png',
            'images/p2.png',
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
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        
          title: Text("Products Info"),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.shopping_cart, color:Colors.white),onPressed: (){}),
          new IconButton(icon: Icon(Icons.menu, color:Colors.white),onPressed: (){}),
          
        ], 
      ),
      body: new ListView(
        children: <Widget>[
        new Padding(padding: EdgeInsets.all(8.0),
        child:imageCarousel,
        ), 
          
        new Padding(padding: EdgeInsets.all(8.0),
        child:Text("Categories",
        textScaleFactor: 1.4,
        ),
      ), 

        HorizontalList(),
        ],
      ),
    );
  }
}