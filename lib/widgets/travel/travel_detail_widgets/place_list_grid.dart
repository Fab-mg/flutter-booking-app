import 'package:flutter/material.dart';
import 'package:smarta1/widgets/travel/place/models/place_list_model.dart';
import 'package:smarta1/widgets/travel/place/place_list_widget.dart';

import '../place/place_widgets.dart/place_item_widget.dart';

class PlaceGridWidget extends StatefulWidget {
  List<PlaceListModel> placeList;
  PlaceGridWidget(this.placeList);

  @override
  State<PlaceGridWidget> createState() => _PlaceGridWidgetState();
}

class _PlaceGridWidgetState extends State<PlaceGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          //TODO ADD ITEM BUILDER SWITCH TO ADD TOP ROW
          itemBuilder: ((context, index) {
            return Container(
              child: PlaceItemWidget(widget.placeList[index]),
            );
          }),
          itemCount: widget.placeList.length,
        ));
  }
}
