import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/widgets/cars/model/car_entity.dart';
import 'package:smarta1/widgets/cars/car_details_page.dart';

class ListItemTest extends StatefulWidget {
  List<Car> cars;
  int index;

  ListItemTest({required this.cars, required this.index});
  @override
  State<ListItemTest> createState() => _ListItemTestState();
}

class _ListItemTestState extends State<ListItemTest> {
  bool tapped = false;
  toggleActionView() {
    setState(() {
      tapped = !tapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.cars[widget.index].matriculate),
          subtitle: Row(
            children: [
              Text(widget.cars[widget.index].model),
              Text(widget.cars[widget.index].color),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(DateFormat('dd MMM yyyy')
                  .format(widget.cars[widget.index].createdAt)),
              SizedBox(
                height: 5,
              ),
              Text(DateFormat('hh:mm')
                  .format(widget.cars[widget.index].createdAt)),
            ],
          ),
          onTap: () {
            toggleActionView();
          },
        ),
        tapped
            ? Container(
                child: TextButton(
                  child: Text('View'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ViewCarPage(
                            carId: widget.cars[widget.index].carId)));
                  },
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
