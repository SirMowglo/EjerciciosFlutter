import 'package:flutter/material.dart';

void main() {
  runApp(const HList());
}

class HList extends StatelessWidget {
  const HList({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title ='Lista horizontal en plan pal lao';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
        title: const Text(title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 100.0,
              color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            Container(
              width: 100.0,
              color: Colors.blue,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            Container(
              width: 100.0,
              color: Colors.green,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
class MixList extends StatelessWidget {
  const MixList({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title ='Lista horizontal en plan pal lao';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(),
    );
  }
}
