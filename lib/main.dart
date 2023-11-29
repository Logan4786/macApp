import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/view/addProducts.dart';
import 'package:frontend/view/listProducts.dart';
import 'package:frontend/view/loginPage.dart';
import 'package:frontend/view/registrationPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Consultar Placas",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        primaryColor: Colors.white70,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences sharedPreferences;

  final placaController = TextEditingController(); // Adicione o controller

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  void mostrarDetalhesPlaca(placaEncontrada) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Dados da Placa"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Placa: ${placaEncontrada['placas']}"),
              Text("Renavam: ${placaEncontrada['renavam']}"),
              Text("Status: ${placaEncontrada['status']}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(Duration(milliseconds: 500), () {
                  placaController.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void consultarPlaca() async {
    String placa = placaController.text;
    String token = sharedPreferences.getString("token") ?? "";

    String url = "http://192.168.1.57:3000/placas?placa=$placa";
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        var placasEncontradas = data.where((placaEncontrada) =>
            placaEncontrada['placas'].toString().toLowerCase() ==
            placa.toLowerCase());

        if (placasEncontradas.isNotEmpty) {
          mostrarDetalhesPlaca(placasEncontradas.first);
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Atenção"),
                content: Text("Nenhuma placa corresponde à consulta."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      placaController.clear();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Atenção"),
              content: Text("Nenhuma placa corresponde à consulta."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    placaController.clear();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro na Consulta"),
            content: Text("Houve um erro durante a consulta da placa."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration(milliseconds: 500), () {
                    placaController.clear();
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultar Placas", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Sair", style: TextStyle(color: Color.fromARGB(255, 16, 10, 102))),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: TextField(
                  enabled: true,
                  controller: placaController,
                  maxLength: 8,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 8.0),
                    counterText: '',
                    hintText: "Digite a placa",
                    hintStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    primary: Colors.white,
                  ),
                  onPressed: consultarPlaca,
                  child: Text("Consultar", style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Aqui_vai_o_nome_do_usuarios_logado'),
              accountEmail: Text('Aqui_vai_o_email'),
            ),
            ListTile(
              title: Text("List Placas"),
              trailing: Icon(Icons.help),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ListProducts(),
                ),
              ),
            ),
            ListTile(
              title: Text("Add Placas"),
              trailing: Icon(Icons.help),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AddDataProduct(key: UniqueKey(), title: "Título"),
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Register user"),
              trailing: Icon(Icons.fitness_center),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => RegistrationPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}