import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/place_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/travel/place/models/place_list_model.dart';
import 'package:smarta1/widgets/travel/travel_detail_widgets/place_list_grid.dart';
import 'package:smarta1/widgets/travel/travel_detail_widgets/travel_details_widget.dart';

class TravelDetailsPage extends StatefulWidget {
  String travelId;
  TravelDetailsPage(this.travelId);
  @override
  State<TravelDetailsPage> createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
  bool everythingLoaded = false;
  bool loadingError = false;

  PlaceServices get placeServices => GetIt.I<PlaceServices>();
  late List<PlaceListModel> placeList;

  _loadPlaceData() async {
    PlaceListModel placeA =
        PlaceListModel(isAvailable: false, number: '_', placeId: '_');
    APIResponse<List<PlaceListModel>> apiResponse;
    apiResponse = await this.placeServices.getPlaceList(widget.travelId);
    if (apiResponse.error) {
      setState(() {
        loadingError = true;
      });
    } else {
      setState(() {
        placeList = apiResponse.data;

        placeList.insert(0, placeA);
        placeList.insert(0, placeA);

        everythingLoaded = true;
      });
    }
  }

  @override
  void initState() {
    _loadPlaceData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text("Details du voyage"),
            SizedBox(width: 5),
            Icon(Icons.car_repair)
          ],
        ),
      ),
      body: Container(
        child: everythingLoaded
            ? SingleChildScrollView(
                child: Container(
                    height: heigth * 1.1,
                    width: width,
                    child: loadingError
                        ? Text("Data loading error")
                        : Container(
                            width: width * 0.95,
                            color: Color.fromARGB(255, 27, 47, 77),
                            child: Column(
                              children: [
                                //PLACE LIST
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "KOFIAM",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(width: 5),
                                        Image.asset(
                                          'assets/images/ticket-offic.png',
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      width: width * 0.7,
                                      child: Center(
                                          child: PlaceGridWidget(placeList)),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: width * 0.9,
                                      padding:
                                          EdgeInsets.only(left: 10, top: 20),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.58,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 27, 47, 77),
                                      ),
                                      child:
                                          TravelDetailsWidget(widget.travelId),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
