import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/widgets/reservation/models/reservation_list_model.dart';
import 'package:smarta1/widgets/reservation/reservation_list_widgets/reservation_item.dart';
import 'package:smarta1/widgets/travel/models/travel_detail_model.dart';

import '../../../services/place_service.dart';
import '../../../services/travel_service.dart';
import '../../../utils/api_response.dart';
import '../../travel/place/models/place_details_model.dart';

class ReservationListWidget extends StatefulWidget {
  List<ReservationListModel> reservations;
  ReservationListWidget({required this.reservations});

  @override
  State<ReservationListWidget> createState() => _ReservationListWidgetState();
}

class _ReservationListWidgetState extends State<ReservationListWidget> {
  bool loadingError = false;
  PlaceServices get placeService => GetIt.I<PlaceServices>();
  bool placeLoaded = false;
  late APIResponse<PlaceDetailsModel?> placeResponse;
  late TravelDetailModel travel;
  late PlaceDetailsModel place;

  _loadPlace(placeId) async {
    placeResponse = await this.placeService.viewPlace(placeId: placeId)
        as APIResponse<PlaceDetailsModel?>;
    if (!placeResponse.error) {
      placeLoaded = true;
    }
    return placeResponse.data;
  }

  TravelService get travelService => GetIt.I<TravelService>();
  bool travelLoaded = false;
  late APIResponse travelResponse;

  _loadTravel(travelId) async {
    travelResponse = await this.travelService.viewTravelDetails(travelId);
    if (!travelResponse.error) {
      travelLoaded = true;
      return travelResponse.data;
    } else {
      setState(() {
        loadingError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return FutureBuilder(
              future: _fetchReservationTravel(widget.reservations[index]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: ReservationItemWidget(
                      reservation: widget.reservations[index],
                      travel: travel,
                      placeId: placeResponse.data!.placeId,
                      placeNumber: place.number,
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
          itemCount: widget.reservations.length,
        ),
      ),
    );
  }

  _fetchReservationTravel(ReservationListModel reservation) async {
    place = await _loadPlace(reservation.reservedPlace);
    print(place.placeId);
    travel = await _loadTravel(place.travelId);

    return travel;
  }
}
