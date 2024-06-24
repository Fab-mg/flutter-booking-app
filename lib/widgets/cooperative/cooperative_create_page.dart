import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/car_service.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cars/model/car_entity_create.dart';
import 'package:smarta1/widgets/city/model/city_list.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_create_model.dart';

import '../../services/city_services.dart';

class CooperativeCreatePage extends StatefulWidget {
  @override
  State<CooperativeCreatePage> createState() => _CooperativeCreatePageState();
}

createLabel(String labelText) {
  return Container(
    child: Column(
      children: [
        SizedBox(height: 15),
        Text(
          labelText,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
      ],
    ),
    margin: EdgeInsets.only(left: 40),
  );
}

class _CooperativeCreatePageState extends State<CooperativeCreatePage> {
  final formKey = GlobalKey<FormState>();
  final dropFormKey = GlobalKey<FormState>();
  late String nameCooperative;
  late String emailCooperative;
  late String address;
  late String phone1;
  late String phone2;
  late String selectedCity;
  DateTime startOfActivity = DateTime.now();
  bool registered = false;
  bool saveStatus = false;

  late APIResponse apiResponse;
  late List<CityListModel> cities;
  bool citesLoaded = false;

  CooperativeServices get cooperativeService =>
      GetIt.instance<CooperativeServices>();
  CityServices get cityService => GetIt.instance<CityServices>();

  _getCities() async {
    apiResponse = await cityService.getCities();
    if (!apiResponse.error) {
      setState(() {
        cities = apiResponse.data;
        citesLoaded = true;
      });
      print("cities.length");
      print(cities[0].nameCity);
    }
  }

  @override
  void initState() {
    _getCities();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Enregistrer une cooperative'),
        ),
        body: !registered
            ? SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //INPUT 1
                      createLabel("Entrez le nom de la cooperative"),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onSaved: (String? value) {
                            nameCooperative = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Ex: SONATRA",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return "Veuillze entrer un nom avec plus de 3 lettres";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      //INPUT CAR MODEL
                      createLabel("Entrez l'adresse email du responsable"),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onSaved: (String? value) {
                            emailCooperative = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Ex: kofiam@contact.com",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return "Veuillez entrer un email valide";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      //INPUT CAR COLOR 3
                      createLabel("Adresse exact du bureau principal"),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onSaved: (String? value) {
                            address = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Ex: Lot3C10 Anjamba Box C1",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Enter une adresse correcte";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      //INPUT CAR CAPACITY 4
                      createLabel("Entrez numero téléphone principal"),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onSaved: (String? value) {
                            phone1 = value!;
                          },
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: "Ex: 03245678912",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty ||
                                // !RegExp(r'^[0,9]{1,2}+$').hasMatch(value) ||
                                value.length != 10) {
                              return "Entrer un numero de téléphone valide";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      //INPUT 5
                      createLabel("Entrez numero téléphone secondaire"),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onSaved: (String? value) {
                            phone2 = value!;
                          },
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: "Ex: 0341597486",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length != 10) {
                              return "Entrez numero téléphone correct";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      //City drop box
                      createLabel("Choisir ville"),

                      //DROPBox
                      !citesLoaded
                          ? CircularProgressIndicator()
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                items: cities
                                    .map((e) => DropdownMenuItem(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(e.nameCity),
                                          ),
                                          value: e.cityId,
                                        ))
                                    .toList(),
                                onChanged: ((value) {}),
                                onSaved: (String? value) {
                                  selectedCity = value!;
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

                      //ACTION BUTTON
                      Padding(
                        padding: EdgeInsets.only(
                            left: (screenWidth / 2) - 53, top: 10),
                        child: ElevatedButton(
                          onPressed: (() {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print(nameCooperative);
                              print(selectedCity);
                              List<String> phones = [phone1, phone2];

                              CooperativeCreateModel cooperative =
                                  CooperativeCreateModel(
                                      nameCooperative: nameCooperative,
                                      emailCooperative: emailCooperative,
                                      address: address,
                                      phones: phones,
                                      startOfActivity: startOfActivity,
                                      city: selectedCity,
                                      license: "link");

                              print(cooperative.runtimeType);
                              print('StartOfActivity ${startOfActivity}');
                              print('name ${startOfActivity}');

                              contentSaver(
                                  CooperativeCreateModel coopperative) async {
                                APIResponse response = await cooperativeService
                                    .createCooperative(cooperative);
                                setState(() {
                                  registered = true;
                                  saveStatus = response.data;
                                });
                              }

                              contentSaver(cooperative);
                            }
                          }),
                          child: Text("Enregistrer"),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Text('Save initiated'),
                  saveStatus ? Text('Save success') : Text('Save failed'),
                ],
              ) //LATER SWAP WITH SUCCESS OR FAIL PAGE,
        );
  }
}
