import 'package:flutter/material.dart';
import 'package:smarta1/widgets/cars/car_list_widgets/list_item_test.dart';
import '../model/car_entity.dart';

class CarListWidget extends StatefulWidget {
  List<Car> cars = [];
  CarListWidget({required this.cars});

  @override
  State<CarListWidget> createState() => _CarListWidgetState();
}

class _CarListWidgetState extends State<CarListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.cars.length <= 0
        ? Center(
            child: Text('No cars to show yet'),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 1.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    children: [
                      ListItemTest(cars: widget.cars, index: index),
                    ],
                  ),
                );
              },
              itemCount: widget.cars.length,
            ),
          );
  }
}
