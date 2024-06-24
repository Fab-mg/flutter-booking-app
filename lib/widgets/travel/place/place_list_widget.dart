import 'package:flutter/material.dart';
import 'package:smarta1/widgets/travel/place/models/place_list_model.dart';
import 'package:smarta1/widgets/travel/place/place_widgets.dart/place_item_widget.dart';

class PlaceListWidget extends StatefulWidget {
  List<PlaceListModel> places;
  PlaceListWidget({required this.places});

  @override
  State<PlaceListWidget> createState() => _PlaceListWidgetState();
}

class _PlaceListWidgetState extends State<PlaceListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Card(
              child: PlaceItemWidget(widget.places[index]),
            );
          }),
          itemCount: widget.places.length,
        ),
      ),
    );
  }
}
