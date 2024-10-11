import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SQLite CRUD",
      home: Pagina1(),
    );
  }
}
class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
      ),
      body: const Column(
        children: [
          Padding(padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Nome'
            ),
          )),
        ],
      ),
    );
  }
}
