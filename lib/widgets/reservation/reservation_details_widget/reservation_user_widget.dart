import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/reservation_service.dart';
import 'package:smarta1/utils/api_response.dart';
import '../models/reservation_list_model.dart';

class ReservationUserWidget extends StatefulWidget {
  String reservationId;
  ReservationUserWidget({required this.reservationId});

  @override
  State<ReservationUserWidget> createState() => _ReservationUserWidgetState();
}

class _ReservationUserWidgetState extends State<ReservationUserWidget> {
  ReservationService get reservationService => GetIt.I<ReservationService>();
  bool reservationLoaded = false;
  bool reservationError = false;
  late APIResponse reservationResponse;

  _loadReservation() async {
    reservationResponse = await this
        .reservationService
        .viewReservation(reservationId: widget.reservationId);
    if (reservationResponse.error) {
      reservationError = true;
    }
    setState(() {
      reservationLoaded = true;
    });
  }

  @override
  void initState() {
    _loadReservation();
  }

  @override
  Widget build(BuildContext context) {
    return !reservationLoaded
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 27, 47, 77),
                    image: DecorationImage(
                        image: AssetImage('assets/images/3dMan.png'),
                        fit: BoxFit.cover),
                    border: Border.all(
                      color: Color.fromARGB(255, 27, 47, 77),
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 8),
                          Text(
                            reservationResponse.data.fullName,
                            style: style,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.credit_card),
                          SizedBox(width: 8),
                          Text(
                            reservationResponse.data.CIN,
                            style: style,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 8),
                          Text(
                            reservationResponse.data.phone,
                            style: style,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text(
                            'Tél d\'urgence ${reservationResponse.data.relativePhone}',
                            style: style,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

var style = TextStyle(color: Colors.black, fontSize: 15);
