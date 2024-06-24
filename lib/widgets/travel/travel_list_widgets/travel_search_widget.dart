import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/travel/models/travel_filter.dart';
import 'package:smarta1/widgets/travel/travel_list_page.dart';

import '../../../services/city_services.dart';
import '../../city/model/city_list.dart';

class TravelSearchWidget extends StatefulWidget {
  @override
  State<TravelSearchWidget> createState() => _TravelSearchWidgetState();
}

class _TravelSearchWidgetState extends State<TravelSearchWidget> {
  bool isloaded = false;
  late APIResponse apiResponse;
  late List<CityListModel> cities;
  late String selectedStartingCity;
  late String selectedDestinationCity;

  CityServices get cityService => GetIt.instance<CityServices>();

  _getCities() async {
    apiResponse = await cityService.getCities();
    if (!apiResponse.error) {
      setState(() {
        cities = apiResponse.data;
        isloaded = true;
      });
      print("cities.length");
      print(cities[0].nameCity);
    }
  }

  DateTime now = DateTime.now();
  bool dateSet = false;
  late DateTime chosenDate;

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year, now.month + 1, now.day),
    ).then((value) {
      setState(() {
        chosenDate = value!;
        dateSet = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCities();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return !isloaded
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: Column(
              children: [
                TextButton(
                  onPressed: _showDatePicker,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_outlined, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        dateSet
                            ? DateFormat('dd MMM yyyy').format(chosenDate)
                            : 'Date de départ',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: width * 0.5,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonFormField(
                    dropdownColor: Color.fromARGB(255, 27, 47, 77),
                    iconEnabledColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Départ",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        // borderSide: BorderSide(color: Colors.amber, width: 2),
                      ),
                    ),
                    items: cities
                        .map((e) => DropdownMenuItem(
                              child: Container(
                                // color: Colors.black,
                                // height: 10,
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  e.nameCity,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              value: e.cityId,
                            ))
                        .toList(),
                    onChanged: ((value) {
                      // selectedStartingCity = value!;
                    }),
                    onSaved: (String? value) {
                      selectedStartingCity = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Choisir une ville!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Container(
                    width: width * 0.5,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.white,
                      dropdownColor: Color.fromARGB(255, 27, 47, 77),
                      decoration: InputDecoration(
                        hintText: "Arrivé",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      items: cities
                          .map((e) => DropdownMenuItem(
                                child: Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    e.nameCity,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                                value: e.cityId,
                              ))
                          .toList(),
                      onChanged: ((value) {}),
                      onSaved: (String? value) {
                        selectedDestinationCity = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Choisir une ville!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: (() {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        print(
                            'We are in onPressed function $selectedDestinationCity');

                        TravelFilter filter = TravelFilter(
                          departCityId: selectedStartingCity,
                          destinationCityId: selectedDestinationCity,
                          travelDate: chosenDate,
                        );

                        print('We are still in onPressed function $chosenDate');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => TravelListPage(
                                  travelIsSet: true,
                                  filter: filter,
                                )));
                      }
                    }),

                    //
                    child: Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.amber, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Trouver',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.amber,
                            size: 30,
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
  }
}
