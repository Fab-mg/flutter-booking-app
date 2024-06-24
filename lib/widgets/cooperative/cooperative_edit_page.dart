import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/city/model/city_list.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_create_model.dart';

import '../../services/city_services.dart';

class CooperativeEditPage extends StatefulWidget {
  String cooperativeId;
  CooperativeEditPage({required this.cooperativeId});

  @override
  State<CooperativeEditPage> createState() => _CooperativeEditPageState();
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

class _CooperativeEditPageState extends State<CooperativeEditPage> {
  final formKey = GlobalKey<FormState>();
  final dropFormKey = GlobalKey<FormState>();
  late String nameCooperative;
  late String emailCooperative;
  late String address;
  late String phone1;
  late String phone2;
  late String selectedCity;
  DateTime startOfActivity = DateTime.now();

  //init values
  late String nameCooperativeInit;
  late String emailCooperativeInit;
  late String addressInit;
  late String phone1Init;
  late String phone2Init;

  //Checkers
  bool registered = false;
  bool saveStatus = false;

  late APIResponse apiResponse;
  late List<CityListModel> cities;
  bool citesLoaded = false;
  bool dataLoaded = false;
  bool initialDataLoaded = false;
  bool allDataInitialized = false;

  CooperativeServices get cooperativeService =>
      GetIt.instance<CooperativeServices>();
  CityServices get cityService => GetIt.instance<CityServices>();

  _getData() async {
    APIResponse apiResponseInit =
        await cooperativeService.viewCooperative(widget.cooperativeId);
    if (!apiResponse.error) {
      setState(() {
        nameCooperativeInit = apiResponseInit.data.nameCooperative;
        emailCooperativeInit = apiResponseInit.data.emailCooperative;
        addressInit = apiResponseInit.data.address;
        phone1Init = apiResponseInit.data.phones[0];
        phone2Init = apiResponseInit.data.phones[0];
        dataLoaded = true;
      });
      _showData();
      return true;
    } else {
      return false;
    }
  }

  void _showData() async {
    print('dataLoaded ${dataLoaded}');
    if (dataLoaded) {
      setState(() {
        initialDataLoaded = true;
      });
    }
  }

  _getCities() async {
    apiResponse = await cityService.getCities();
    if (!apiResponse.error) {
      setState(() {
        cities = apiResponse.data;
        citesLoaded = true;
      });
      print("cities.length");
      print(cities[0].nameCity);
      return true;
    } else {
      return false;
    }
  }

  _showAll() async {
    bool one = await _getCities();
    bool two = await _getData();
    if (one && two) {
      setState(() {
        allDataInitialized = true;
      });
    }
  }

  @override
  void initState() {
    _showAll();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: allDataInitialized
              ? Text('Modifier ${nameCooperativeInit}')
              : Text('Modifier Cooperative'),
        ),
        body: !registered
            ? !allDataInitialized
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
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
                              initialValue:
                                  initialDataLoaded ? nameCooperativeInit : '',
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
                                  return "Veuillez entrer un nom avec plus de 3 lettres";
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
                              initialValue:
                                  initialDataLoaded ? emailCooperativeInit : '',
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
                              initialValue:
                                  initialDataLoaded ? addressInit : '',
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
                              initialValue: initialDataLoaded ? phone1Init : '',
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
                              initialValue: initialDataLoaded ? phone2Init : '',
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    items: cities
                                        .map((e) => DropdownMenuItem(
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 15),
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

                                  contentSaver({
                                    required String cooperativeId,
                                    required CooperativeCreateModel cooperative,
                                  }) async {
                                    APIResponse response =
                                        await cooperativeService
                                            .updateCooperative(
                                                cooperativeId: cooperativeId,
                                                cooperative: cooperative);
                                    if (!response.error) {
                                      setState(() {
                                        registered = true;
                                        saveStatus = response.data;
                                      });
                                    } else {
                                      setState(() {
                                        registered = true;
                                        saveStatus = false;
                                      });
                                    }
                                  }

                                  contentSaver(
                                    cooperativeId: widget.cooperativeId,
                                    cooperative: cooperative,
                                  );
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
