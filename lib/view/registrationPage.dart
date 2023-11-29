import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/view/loginPage.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  _registerUser(BuildContext context) async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    final response = await http.post(
      Uri.parse("http://192.168.1.57:3000/signup"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String token = responseData['token'];

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));

    } else {
      // Lidar com erros aqui.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Usuário"),
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
              // Campo de Nome de Usuário
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Nome de Usuário",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              // Campo de Email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              // Campo de Senha
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  obscureText: true, // Para esconder a senha
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _registerUser(context);
                },
                child: Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Principal"),
      ),
      body: Center(
        child: Text("Bem-vindo à página principal!"),
      ),
    );
  }
}
