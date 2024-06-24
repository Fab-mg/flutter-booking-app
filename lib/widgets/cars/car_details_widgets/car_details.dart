import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarDetailsWidget extends StatefulWidget {
  String coopName;
  String carColor;
  int nbrPlace;
  String carState;

  CarDetailsWidget({
    required this.coopName,
    required this.carColor,
    required this.nbrPlace,
    required this.carState,
  });

  @override
  State<CarDetailsWidget> createState() => _CarDetailsWidgetState();
}

Container showDetail(String inputLabel, String inputValue) {
  return Container(
    padding: EdgeInsets.all(5),
    child: Row(children: [
      Text(
        inputLabel,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        inputValue,
        style: TextStyle(fontSize: 15, color: Colors.grey[500]),
      ),
    ]),
  );
}

class _CarDetailsWidgetState extends State<CarDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Column(children: [
          Text('Car details:'),
          showDetail('Cooperative Name:', widget.coopName),
          showDetail('Color:', widget.carColor),
          showDetail('Car Capacity:', widget.nbrPlace.toString()),
          showDetail('Car State:', widget.carState),
        ]),
      ),
    );
  }
}
