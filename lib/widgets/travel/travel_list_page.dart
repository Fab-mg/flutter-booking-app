import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/travel_service.dart';

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/utils/navigation_drawer.dart';
import 'package:smarta1/widgets/travel/models/travel_filter.dart';
import 'package:smarta1/widgets/travel/models/travel_list_model.dart';
import 'package:smarta1/widgets/travel/travel_list_widgets/list_widget.dart';
import 'package:smarta1/widgets/travel/travel_list_widgets/travel_search_widget.dart';

class TravelListPage extends StatefulWidget {
  bool travelIsSet = false;
  TravelFilter? filter;

  TravelListPage({TravelFilter? filter, bool? travelIsSet}) {
    if (travelIsSet != null) {
      this.travelIsSet = travelIsSet;
    }
    if (filter != null) {
      this.filter = filter;
    }
  }

  @override
  State<TravelListPage> createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  TravelService get travelServices => GetIt.I<TravelService>();
  late APIResponse<List<TravelListModel>> apiResponse;
  bool dataIsLoaded = false;
  bool dataLoadingError = false;
  bool showFilterFields = false;
  bool travelEmpty = false;

  getData() async {
    if (widget.travelIsSet) {
      apiResponse =
          await this.travelServices.getFilteredTravels(widget.filter!);
    } else {
      apiResponse = await travelServices.getTravels();
    }

    if (apiResponse.error == false) {
      setState(() {
        dataIsLoaded = true;
      });
    } else {
      setState(() {
        dataIsLoaded = true;
        dataLoadingError = true;
      });
      if (apiResponse.data.length == 0) {
        setState(() {
          travelEmpty = true;
        });
      }
    }
  }

  _showfilter() {
    setState(() {
      showFilterFields = !showFilterFields;
    });
  }

  @override
  void initState() {
    getData();
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
            Text("Liste des voyages"),
            SizedBox(width: 15),
            Icon(Icons.travel_explore_rounded)
          ],
        ),
      ),
      drawer: MyNavigationDrawer(),
      body: !dataIsLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !dataLoadingError
              ? SingleChildScrollView(
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: _showfilter,
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
                                  'assets/images/research.png',
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
                                          "Trouver un voyage Trier",
                                          style: GoogleFonts.bitter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            // color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //FILTERS
                        showFilterFields
                            ? Container(
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 27, 47, 77),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TravelSearchWidget(),
                              )
                            : SizedBox(),

                        //LIST
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: heigth * 0.8,
                          child: Container(
                              color: Colors.grey[200],
                              height: MediaQuery.of(context).size.height * 0.78,
                              child: travelEmpty
                                  ? Text('Aucun voyage trouvé')
                                  : TravelListWidget(
                                      travels: apiResponse.data)),
                        ),
                      ],
                    ),
                  ),
                )
              : Text('Failed to load data'),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: null,
      //   // () {
      //   //   Navigator.of(context)
      //   //       .push(MaterialPageRoute(builder: (_) => CooperativeCreatePage()));
      //   // },
      // ),
    );
  }
}
