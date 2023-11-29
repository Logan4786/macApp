
import 'package:frontend/controllers/databasehelpers.dart';
import 'package:frontend/view/editProduct.dart';
import 'package:frontend/view/listProducts.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {

  final List list;
  final int index;
  Detail({required this.list, required this.index});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  DataBaseHelper databaseHelper = new DataBaseHelper();

  //create function delete 
  void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Esta seguto de eliminar '${widget.list[widget.index]['name']}'"),
    actions: <Widget>[
      ElevatedButton(
        child: new Text("OK remove!",style: new TextStyle(color: Colors.black),),
        style: ElevatedButton.styleFrom(
        primary: Colors.red,
        ),        
        onPressed: (){
                      databaseHelper.removeRegister(widget.list[widget.index]['_id'].toString());
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new ListProducts(),
                          )
                      );
                    },
      ),
      ElevatedButton(
        child: new Text("CANCEL",style: new TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
        primary: Colors.green,
        ),        
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(
  context: context,
  builder: (BuildContext context) {
    return alertDialog;
  },
);
}


  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['name']}")),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['name'], style: new TextStyle(fontSize: 20.0),),
                Divider(),
                new Text("Price : ${widget.list[widget.index]['price']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                    child: new Text("Edit"),
                    style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                     ),
                    ),

                    
                    
                    onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=>new EditProduct(list: widget.list, index: widget.index,),
                        )
                      ),                    
                  ),
                  VerticalDivider(),
                  ElevatedButton(
                    onPressed: () => confirm(),
                    //child: new Text("Delete"),
                    style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(30.0),
                    ),
                   ),                   
                    
                   child: Text("Delete"),              
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}