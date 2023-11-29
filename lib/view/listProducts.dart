import 'dart:async';
import 'dart:convert';

import 'package:frontend/view/detailProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {

  List<dynamic> data = [];

  Future<List> getData() async {
    final response = await http.get(Uri.parse("http://192.168.1.57:3000/placas"));
    return json.decode(response.body);
  }

  @override
  void initState() { 
    super.initState();
     this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews Products"),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                   list: snapshot.data?.map((item) => item.toString()).toList() ?? [],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      
    );
  }
}

  class ItemList extends StatelessWidget {

  final List<String> list;

  ItemList({List<String> list = const []}) : this.list = list;


    @override
    Widget build(BuildContext context) {
      return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )),
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  (list[i] as Map)['name'].toString(),
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
               
              ),
            ),
          ),
        );
      },
        
      );
    }
  }
  