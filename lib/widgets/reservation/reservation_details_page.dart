import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/reservation_service.dart';
import 'package:smarta1/services/user_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/profile/models/user_details_model.dart';
import 'package:smarta1/widgets/reservation/models/reservation_user_model.dart';
import 'package:smarta1/widgets/reservation/reservation_details_widget/reservation_travel_widget.dart';
import 'package:smarta1/widgets/reservation/reservation_edit_page.dart';
import 'package:smarta1/widgets/travel/travel_detail_widgets/travel_details_widget.dart';

import '../travel/models/travel_detail_model.dart';
import 'models/reservation_list_model.dart';
import 'reservation_details_widget/reservation_user_widget.dart';

class ReservationDetailsPage extends StatefulWidget {
  ReservationListModel reservation;
  TravelDetailModel travel;
  String placeNumber;
  String placeId;
  ReservationDetailsPage(
      {required this.reservation,
      required this.travel,
      required this.placeNumber,
      required this.placeId});

  @override
  State<ReservationDetailsPage> createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  UserService get userService => GetIt.I<UserService>();
  bool userLoaded = false;
  bool loadingError = false;
  late APIResponse apiResponse;

  _loadUser() async {
    apiResponse = await this
        .userService
        .viewUserDetails(userId: '63b2c82f8ddff619e0b13e28');
    // widget.reservation.reservationAuthor
    if (apiResponse.error) {
      setState(() {
        loadingError = true;
      });
    }
    print('Erreur leka');
    setState(() {
      userLoaded = true;
    });
  }

  ReservationService get reservationService => GetIt.I<ReservationService>();
  late APIResponse reservationResponse;
  late ReservationUser reservationUser;

  _loadReservation() async {
    reservationResponse = await this
        .reservationService
        .viewReservation(reservationId: widget.reservation.reservationId);
    if (reservationResponse.error) {
      reservationUser = ReservationUser(
        CIN: 'CIN',
        fullName: 'fullName',
        phone: 'phone',
        relativePhone: 'relativePhone',
      );
    } else {
      reservationUser = ReservationUser(
        CIN: reservationResponse.data.CIN,
        fullName: reservationResponse.data.fullName,
        phone: reservationResponse.data.phone,
        relativePhone: reservationResponse.data.relativePhone,
      );
    }
  }

  @override
  void initState() {
    _loadUser();
    _loadReservation();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la réservation'),
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        shadowColor: Colors.transparent,
      ),
      body: Container(
        color: Color.fromARGB(255, 27, 47, 77),
        width: width,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                Container(
                  width: width * 0.90,
                  child: ReservationUserWidget(
                    reservationId: widget.reservation.reservationId,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: width * 0.9,
                  child: TravelDetailsWidget(widget.travel.travelId),
                ),
                SizedBox(height: 25),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => EditReservationPage(
                              reservationId: widget.reservation.reservationId,
                              reservationUser: reservationUser,
                            )));
                  }),
                  child: Container(
                    height: 60,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Modifier',
                          style: GoogleFonts.bitter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 27, 47, 77),
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
