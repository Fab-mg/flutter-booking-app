import 'package:flutter/material.dart';

class CarCooperativePage extends StatefulWidget {
  @override
  State<CarCooperativePage> createState() => _CarCooperativePageState();
}

class _CarCooperativePageState extends State<CarCooperativePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit car cooperative')),
      body: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(children: [
              Center(child: Text("Choose new cooperative to join"))
            ]),
          )),
    );
  }
}
