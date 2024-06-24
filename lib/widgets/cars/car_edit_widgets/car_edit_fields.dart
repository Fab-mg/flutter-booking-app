import 'package:flutter/material.dart';

class CarEditFields extends StatefulWidget {
  String matriculate;
  String carColor;
  int nbrPlace;
  String carState;

  CarEditFields({
    required this.matriculate,
    required this.carColor,
    required this.nbrPlace,
    required this.carState,
  });
  @override
  State<CarEditFields> createState() => _CarEditFieldsState();
}

Widget editField() {
  return Container();
}

class _CarEditFieldsState extends State<CarEditFields> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
