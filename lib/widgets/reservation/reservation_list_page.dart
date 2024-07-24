import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/reservation_service.dart';
import 'package:smarta1/services/user_service.dart';

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/utils/navigation_drawer.dart';
import 'package:smarta1/widgets/reservation/models/reservation_list_model.dart';
import 'package:smarta1/widgets/reservation/reservation_list_widgets/reservation_list_widget.dart';
import 'package:smarta1/widgets/travel/travel_list_page.dart';

class ReservationListPage extends StatefulWidget {
  String userId;
  ReservationListPage({required this.userId});

  @override
  State<ReservationListPage> createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  ReservationService get reservationServices => GetIt.I<ReservationService>();
  late APIResponse<List<ReservationListModel>> apiResponse;
  bool dataIsLoaded = false;
  bool dataLoadingError = false;
  bool showFilterFields = false;
  bool emptyReservation = false;
  // bool userLoggedIn = true;
  // bool userError = false;
  // late String userId;

  _getData() async {
    apiResponse =
        await reservationServices.getReservationsListForUser(widget.userId);
    if (apiResponse.error == false) {
      setState(() {
        dataIsLoaded = true;
      });
      if (apiResponse.data.length == 0) {
        setState(() {
          emptyReservation = true;
        });
      }
    } else {
      setState(() {
        dataIsLoaded = true;
        dataLoadingError = true;
      });
    }
  }

  _showfilter() {
    setState(() {
      showFilterFields = !showFilterFields;
    });
  }

  @override
  void initState() {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    //SET UP
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;

    //REAL FUNCTION
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text("Liste des Réservations"),
            SizedBox(width: 15),
            Icon(Icons.book)
          ],
        ),
      ),
      drawer: MyNavigationDrawer(),
      body: !dataIsLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !dataLoadingError
              ? emptyReservation
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              "Vous n'avez pas encore fais aucune réservation!",
                              style: GoogleFonts.bitter(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 130,
                            width: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/due-date.png'),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => TravelListPage()));
                              print("tapped");
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: width * 0.85,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 27, 47, 77),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/planning.png',
                                    height: 80,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          constraints: BoxConstraints(
                                              maxWidth: width * 0.5),
                                          child: Text(
                                            "Organiser un voyage?",
                                            style: GoogleFonts.bitter(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_sharp,
                                    color: Colors.amber,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: heigth * 0.87,
                              child: Container(
                                  color: Colors.grey[200],
                                  height:
                                      MediaQuery.of(context).size.height * 0.78,
                                  child: ReservationListWidget(
                                      reservations: apiResponse.data)),
                            ),
                          ],
                        ),
                      ),
                    )
              : Text('Failed to load data'),
    );
  }
}
