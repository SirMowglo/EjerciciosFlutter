import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 41, 41, 41)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 41, 41, 41)),
          ),
        ),
      ),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 41, 41),
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 60.0, left: 15, right: 15),
            child: Center(
              child: Container(
                  width: 300,
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/de/thumb/d/d2/Riot_Games_logo.svg/1200px-Riot_Games_logo.svg.png')),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: 300,
              child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Introduce un email valido'),
            ),
            )
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 0),
            child: SizedBox(
              width: 300,
              child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
                hintText: 'Introduce la contraseña',
              ),
            )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: TextButton(
            onPressed: () {
              //TODO: Por hacer
            },
            child: const Text(
              'Has olvidado la contraseña?',
              
              style: TextStyle(
                  color: Color.fromRGBO(210, 51, 55, 1), fontSize: 13),
            ),
            )
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                color: Color.fromRGBO(210, 51, 55, 1),
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
          const Text('New User? Create Account')
        ],
      )),
    );
  }
}
