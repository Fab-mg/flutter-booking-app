import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/services/reservation_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/reservation/reservation_details_page.dart';
import 'package:smarta1/widgets/reservation/reservation_list_widgets/menu_item_model.dart';
import 'package:smarta1/widgets/travel/models/travel_detail_model.dart';

import '../models/reservation_list_model.dart';

class ReservationItemWidget extends StatefulWidget {
  ReservationListModel reservation;
  TravelDetailModel travel;
  String placeNumber;
  String placeId;
  ReservationItemWidget(
      {required this.reservation,
      required this.travel,
      required this.placeNumber,
      required this.placeId});

  @override
  State<ReservationItemWidget> createState() => _ReservationItemWidgetState();
}

class _ReservationItemWidgetState extends State<ReservationItemWidget> {
  late APIResponse deleteResponse;
  bool deletedStatus = false;
  bool deletedError = false;
  bool clicked = false;

  ReservationService get reservationService => GetIt.I<ReservationService>();

  _switch() {
    setState(() {
      clicked = !clicked;
    });
  }

  _deleteReservation() async {
    APIResponse deleteResponse = await this
        .reservationService
        .deleteReservation(widget.reservation.reservationId);
    if (deleteResponse.error) {
      setState(() {
        deletedError = true;
      });
    }
    setState(() {
      deletedStatus = true;
    });
  }

  _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actionsPadding: EdgeInsets.zero,
        title: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Souhaitez-vous annuler cette réservation?",
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
                    this._deleteReservation();
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
    double width = MediaQuery.of(context).size.width;
    String dateDepart =
        DateFormat('dd MMM yyyy').format(widget.travel.leavingAt);
    String heureDepart = DateFormat('hh mm').format(widget.travel.leavingAt);
    return deletedStatus
        ? deletedView
        : InkWell(
            onTap: _switch,
            child: Container(
              width: width * 0.85,
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 5),
              // color: Colors.white,
              decoration: BoxDecoration(
                color: clicked ? Colors.white : Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: width * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/busTicket.png',
                                height: 30,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${widget.travel.prixUnitaire} Ariary',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 27, 47, 77),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.nature_people_sharp,
                                  color: Color.fromARGB(255, 27, 47, 77),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.travel.travelAuthorCoop,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.chair_alt_rounded,
                                  color: Color.fromARGB(255, 27, 47, 77),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Place numero ${widget.placeNumber}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.place,
                                    color: Color.fromARGB(255, 27, 47, 77)),
                                SizedBox(width: 5),
                                Text(
                                  'Direction',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.travel.arrivalCity.cityName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Color.fromARGB(255, 27, 47, 77),
                                ),
                                SizedBox(width: 5),
                                Text(
                                    'Départ le ${dateDepart} à ${heureDepart}'),
                                SizedBox(width: 15),
                                PopupMenuButton<MenuItemReservation>(
                                    onSelected: (item) =>
                                        onSelected(context, item),
                                    icon: Icon(
                                      Icons.more_horiz_outlined,
                                      size: 30,
                                    ),
                                    itemBuilder: ((context) => [
                                          ...MenuItems.itemList
                                              .map(showItem)
                                              .toList(),
                                        ])),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  onSelected(BuildContext context, MenuItemReservation item) {
    switch (item) {
      case MenuItems.itemView:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ReservationDetailsPage(
                  placeId: widget.placeId,
                  placeNumber: widget.placeNumber,
                  reservation: widget.reservation,
                  travel: widget.travel,
                )));
        break;
      case MenuItems.itemDelete:
        _showConfirmDialog(context);
        break;
    }
  }
}

//ITEM PROVIDER
PopupMenuItem<MenuItemReservation> showItem(MenuItemReservation item) {
  return PopupMenuItem(
    value: item,
    child: Container(
      width: 200,
      child: Row(
        children: [
          Icon(item.icon),
          SizedBox(
            width: 8,
          ),
          Text(
            item.title,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    ),
  );
}

class MenuItems {
  static const List<MenuItemReservation> itemList = [itemView, itemDelete];
  static const MenuItemReservation itemView = MenuItemReservation(
    title: "Voir détails",
    icon: Icons.card_travel,
  );
  static const MenuItemReservation itemDelete = MenuItemReservation(
    title: "Annuler réservation",
    icon: Icons.cancel_presentation,
  );
}

var deletedView = Container(
  margin: EdgeInsets.only(left: 20, right: 20),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20), border: Border.all(width: 2)),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: 10),
      Icon(
        Icons.delete,
        color: Colors.amber,
        size: 50,
      ),
      Text('Réservation annulé'),
      SizedBox(height: 15),
    ],
  ),
);
