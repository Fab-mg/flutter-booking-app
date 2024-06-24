import 'package:flutter/material.dart';
import 'package:smarta1/widgets/travel/models/travel_list_model.dart';
import 'package:smarta1/widgets/travel/travel_list_widgets/list_item_v2.dart';

class TravelListWidget extends StatefulWidget {
  List<TravelListModel> travels;
  TravelListWidget({required this.travels});

  @override
  State<TravelListWidget> createState() => _TravelListWidgetState();
}

class _TravelListWidgetState extends State<TravelListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TravelListItemV2(travel: widget.travels[index]));
          }),
          itemCount: widget.travels.length,
        ),
      ),
    );
  }
}
