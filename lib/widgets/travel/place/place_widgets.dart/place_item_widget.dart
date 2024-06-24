import 'package:flutter/material.dart';
import 'package:smarta1/widgets/reservation/reservation_create_page.dart';
import 'package:smarta1/widgets/travel/place/models/place_list_model.dart';

class PlaceItemWidget extends StatefulWidget {
  PlaceListModel place;
  PlaceItemWidget(this.place);

  @override
  State<PlaceItemWidget> createState() => _PlaceItemWidgetState();
}

class _PlaceItemWidgetState extends State<PlaceItemWidget> {
  _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actionsPadding: EdgeInsets.zero,
        title: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Souhaitez-vous reserver cette place?",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                TextButton(
                  child: Text(
                    'Confirmer',
                    style: TextStyle(color: Colors.amber, fontSize: 17),
                  ),
                  onPressed: (() {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateReservationPage(
                            reservationPlace: widget.place.placeId)));
                  }),
                ),
                TextButton(
                  child: Text(
                    'Annuler',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width * 0.55;
    bool _uselessPlace = false;
    if (widget.place.number == '_' && widget.place.placeId == '_') {
      _uselessPlace = true;
    }

    return Container(
      // width: width * 0.3,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: _uselessPlace ? Colors.transparent : Colors.black,
            width: _uselessPlace ? 0 : 2,
          ),
          color: widget.place.isAvailable ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: !widget.place.isAvailable
              ? null
              : () {
                  _showConfirmDialog(context);
                },
          child: Container(
            // height: 40,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.place.isAvailable ? widget.place.number : " ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
