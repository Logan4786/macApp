import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class DataBaseHelper {

  var status;
  var token;
  String serverUrlPlacas = "http://192.168.1.57:3000/placas";

  //funciton getData
  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrlPlacas";
    http.Response response = await http.get(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
    });
    return json.decode(response.body);
   // print(response.body);
  }


  //function for register placas
  void addDataProducto(String _placaController, String _renavamController, String _statusController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    prefs.get(key ) ?? 0;

   // String myUrl = "$serverUrl/api";
   String myUrl = "http://192.168.1.57:3000/placas";
   final response = await  http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json'
        },
        body: {
          "placa":       "$_placaController",
          "renavam":      "$_renavamController",        
          "status":      "$_statusController"
        } ) ;
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  //function for update or put
  void editarProduct(String _id, String placa, String renavam, String status) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    prefs.get(key ) ?? 0;

    String myUrl = "http://192.168.1.57:3000/placas/$_id";
    http.put(Uri.parse(myUrl),
        body: {
         "placa":       "$placa",
         "renavam":     "$renavam",
         "status":      "$status"
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  //function for delete
  Future<void> removeRegister(String _id) async {

  String myUrl = "http://192.168.1.57:3000/placas/$_id";

  Response res = await http.delete(Uri.parse("$myUrl"));

  if (res.statusCode == 200) {
    print("Deletado");
  } else {
    throw "Can't delete post.";
  }
}

  //function save
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

//function read
 read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }
}

