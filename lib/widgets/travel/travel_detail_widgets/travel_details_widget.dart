import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/services/car_service.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/services/travel_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/travel/models/travel_detail_model.dart';

// import '../../../services/car_service.dart';

class TravelDetailsWidget extends StatefulWidget {
  String travelId;
  TravelDetailsWidget(this.travelId);
  @override
  State<TravelDetailsWidget> createState() => _TravelDetailsWidgetState();
}

class _TravelDetailsWidgetState extends State<TravelDetailsWidget> {
  TravelService get travelService => GetIt.I<TravelService>();
  CarServices get carServices => GetIt.I<CarServices>();
  CooperativeServices get cooperativeServices => GetIt.I<CooperativeServices>();
  bool dataLoaded = false;
  bool loadingError = false;
  late TravelDetailModel travel;
  late String carModel;

  bool addressLoaded = false;
  late String address;

  _getCooperativeAddress(coopId) async {
    APIResponse coopResponse =
        await this.cooperativeServices.viewCooperative(coopId);

    if (!coopResponse.error) {
      setState(() {
        addressLoaded = true;
        address = coopResponse.data.address;
      });
    }
  }

  _getTravelDetails() async {
    APIResponse apiResponse =
        await this.travelService.viewTravelDetails(widget.travelId);

    if (apiResponse.error) {
      setState(() {
        loadingError = false;
      });
    }

    APIResponse apiResponse2 =
        await this.carServices.viewCar(apiResponse.data.travelCar.carId);
    if (apiResponse2.error) {
      setState(() {
        loadingError = false;
      });
    }
    carModel = apiResponse2.data.model;
    setState(() {
      carModel = apiResponse2.data.model;
      dataLoaded = true;
      travel = apiResponse.data;
    });

    // _getCooperativeAddress(apiResponse.data.travelAuthorCoop);
  }

  Container showDetail(String inputLabel, String inputValue) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(children: [
        SizedBox(height: 10),
        Text(
          inputLabel,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.amber[300]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          inputValue,
          style: TextStyle(
              fontSize: 15, color: Color.fromARGB(255, 255, 255, 252)),
        ),
        SizedBox(height: 15),
      ]),
    );
  }

  @override
  void initState() {
    _getTravelDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !dataLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : loadingError
              ? Text("Erreur de chargement")
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // PRIX
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/busTicket.png',
                              height: 40,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${travel.prixUnitaire.toString()} AR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/busss.png',
                            width: 50,
                          ),
                          showDetail(
                              'Départ de :', travel.leavingCity.cityName),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.amber,
                            size: 30,
                          ),
                          showDetail('Allant à :', travel.arrivalCity.cityName),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/specification.png',
                              width: 50,
                            ),
                            // SizedBox(width: 10),
                            showDetail('Numéro Matricule',
                                travel.travelCar.carMatriculate),
                            // Icon(
                            //   Icons.list_alt_rounded,
                            //   color: Colors.amber,
                            //   size: 30,
                            // ),
                            // SizedBox(width: 10),
                            showDetail('Voiture type', carModel),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/calendar2.png',
                            width: 50,
                          ),
                          showDetail(
                              'Départ prévut le',
                              DateFormat('dd MMM yyyy')
                                  .format(travel.leavingAt)),
                          showDetail('A l\'heure :',
                              DateFormat('hh:mm').format(travel.leavingAt)),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(width: 10),
                      //     Image.asset(
                      //       'assets/images/bus-stop.png',
                      //       width: 50,
                      //     ),
                      //     showDetail(
                      //         'Lieu de récuperation',
                      //         addressLoaded
                      //             ? travel.travelAuthorCoop
                      //             : 'Erreur de chargement'),
                      //   ],
                      // ),
                    ],
                  ),
                ),
    );
  }
}
