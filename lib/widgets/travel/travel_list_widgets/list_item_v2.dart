import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/widgets/travel/models/travel_list_model.dart';
import 'package:smarta1/widgets/travel/travel_details_page.dart';

class TravelListItemV2 extends StatefulWidget {
  TravelListModel travel;
  TravelListItemV2({required this.travel});

  @override
  State<TravelListItemV2> createState() => _TravelListItemV2State();
}

class _TravelListItemV2State extends State<TravelListItemV2> {
  bool clicked = false;

  _switch() {
    setState(() {
      clicked = !clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String dateDepart =
        DateFormat('dd MMM yyyy').format(widget.travel.leavingAt);
    String heureDepart = DateFormat('hh mm').format(widget.travel.leavingAt);
    return InkWell(
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
        child: Row(
          children: [
            Container(
              width: width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.travel.travelCar.carMatriculate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                      Text(
                        'De',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.travel.leavingCity.cityName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'A',
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
                  Text('Départ le ${dateDepart} à ${heureDepart}'),
                  // SizedBox(height: 5),
                  // Text('Arrivé prévu le ${dateDepart}'),
                  !clicked
                      ? SizedBox()
                      : TextButton(
                          onPressed: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => TravelDetailsPage(
                                    widget.travel.travelId))));
                          }),
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                'Voir plus',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 206, 157, 10),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_circle_right,
                                color: Color.fromARGB(255, 231, 175, 9),
                                size: 30,
                              )
                            ],
                          )),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Container(
              width: width * 0.28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Places Libre: '),
                      Text(
                        widget.travel.availablePlaceCount.toString(),
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('Places total: '),
                  //     Text(
                  //       widget.travel.placeCount.toString(),
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 5),
                  Container(
                    width: width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF14213d),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Text(
                          '${widget.travel.prixUnitaire} Ariary',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
