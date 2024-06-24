import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarTravelList extends StatefulWidget {
  List travels;

  CarTravelList({required this.travels});

  @override
  State<CarTravelList> createState() => _CarTravelListState();
}

class _CarTravelListState extends State<CarTravelList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 1.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(DateFormat('dd MMM yyyy')
                      .format(widget.travels[index].travelDate)),
                )
              ],
            ),
          );
        }),
        itemCount: widget.travels.length,
      ),
    );
  }
}
