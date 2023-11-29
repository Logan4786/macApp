import 'package:frontend/controllers/databasehelpers.dart';
import 'package:frontend/main.dart';
import 'package:flutter/material.dart';

class AddDataProduct extends StatefulWidget {

  AddDataProduct({required Key key, required String title}) : super(key: key);
  //final String title;

  @override
  _AddDataProductState createState() => _AddDataProductState();
}

class _AddDataProductState extends State<AddDataProduct> {

  DataBaseHelper databaseHelper = new DataBaseHelper();


  final TextEditingController _placaController = new TextEditingController();  
  final TextEditingController _renavamController = new TextEditingController();
  final TextEditingController _statusController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Product',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Add Product'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              
              Container(
                height: 50,
                child: new TextField(
                  controller: _placaController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'name',
                    hintText: 'Placa name',
                    icon: new Icon(Icons.email),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _renavamController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'renavam',
                    hintText: 'Insira o ranavam',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
              
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                height: 50,
                child: new TextField(
                  controller: _statusController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'status',
                    hintText: 'Insira a situação da placa',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
             new Padding(padding: new EdgeInsets.only(top: 44.0),),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    databaseHelper.addDataProducto(
                        _placaController.text.trim(), _renavamController.text.trim(), _statusController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new MainPage(),
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                     primary: Colors.blue,
                      ),
                  child: new Text(
                    'Cadastrar',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }



}
