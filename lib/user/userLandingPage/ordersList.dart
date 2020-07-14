
import 'dart:convert';
import 'dart:io';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uiflutter/user/userLandingPage/myProductWorld_feedback.dart';
import 'package:uiflutter/user/userModel/orders.dart';

class Listorders extends StatefulWidget {
  final String id;
  Listorders({Key key, @required this.id}) : super(key: key);

  @override
  _ListordersState createState() => _ListordersState();
}

class _ListordersState extends State<Listorders> {

  List<OrdersAttributes> _orders = List<OrdersAttributes>();

  File file;

  Future<List<OrdersAttributes>> getorders(String id) async {

    var response = await http.post(
      'http://10.0.2.2:8081/user/order/getOrders',
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id,
    }),
    );

    var orders = List<OrdersAttributes>();

    if(response.statusCode==200){
      var responseJson = json.decode(response.body);
      var ordersJson = responseJson["orders"];
      for (var issueJson in ordersJson) {
        orders.add(OrdersAttributes.fromJson(issueJson));
      }

      print(ordersJson);
      print(orders);
   }
   return orders;
  }

@override
  void initState() {
    //print('id:'+'${widget.id}');
    getorders(widget.id).then((value) {
      setState(() {
        _orders.addAll(value);
      });
    });
    super.initState();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Product Name: '+_orders[index].pType,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                   'Product code: '+ _orders[index].productCode,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                    'Purchased: '+_orders[index].purchasedOn,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  Text(
                    'Warranty: '+_orders[index].warrantTill,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                  ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                            Icons.star,
                            color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                      Text(
                        'Rate & Review',
                        style: TextStyle(
                          color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                          )
                        ],
                      ),
                  onPressed: () {
                    print('');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackForm(pname: '${_orders[index].pType}',)));
                  },
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                            Icons.extension,
                            color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                      Text(
                        'Extend warranty',
                        style: TextStyle(
                          color: Color.fromRGBO(68, 153, 213, 1.0),
                          ),
                          )
                        ],
                      ),
                  onPressed: () {
                    print('Warranty extended');
                  },
                ),
              ],
            ),
                ],
              ),
              
            ),
          );
        },
        itemCount: _orders.length,
      )
    );
  }
}

 
