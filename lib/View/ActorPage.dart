import 'package:flutter/material.dart';

class ActorPage extends StatefulWidget {
  @override
  _ActorPageState createState() => _ActorPageState();
}

class _ActorPageState extends State<ActorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Actor Page"),
      ),
    );
  }
}
