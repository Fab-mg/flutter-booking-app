import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/car_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cars/model/car_entity_create.dart';
import 'package:smarta1/widgets/cars/successPage.dart';

import 'car_create_page.dart';

class EditCarPage extends StatefulWidget {
  String carId;

  EditCarPage({required this.carId});
  @override
  State<EditCarPage> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  CarServices get carServices => GetIt.I<CarServices>();
  late APIResponse apiResponse;
  final formKey = GlobalKey<FormState>();
  late String matriculate;
  late String model;
  late String carState;
  late String color;
  late String nbrPlace;

  late String updatedMatriculate;
  late String updatedModel;
  late String updatedCarState;
  late String updatedColor;
  late String updatedNbrPlace;

  bool registered = false;
  bool saveStatus = false;

  bool isLoaded = false;
  bool noError = false;

  void loadData() async {
    apiResponse = await carServices.viewCar(widget.carId);
    if (!apiResponse.error) {
      matriculate = apiResponse.data.matriculate;
      model = apiResponse.data.model;
      color = apiResponse.data.color;
      nbrPlace = apiResponse.data.nbrPlace.toString();
      carState = apiResponse.data.state_car;

      setState(() {
        noError = true;
      });
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Edit')),
      body: !(isLoaded /* && noError */)
          ? Center(child: CircularProgressIndicator())
          : !noError
              ? Text('Failed to retrieve data')
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //INPUT 1
                        SizedBox(height: 15),
                        createLabel("Insert matriculate number"),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            initialValue: matriculate,
                            onSaved: (String? value) {
                              updatedMatriculate = value!;
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: 358FD-35",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 3) {
                                return "Enter correct matriculate";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        //INPUT CAR MODEL
                        SizedBox(height: 15),
                        createLabel("Insert car model"),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            initialValue: model,
                            onSaved: (String? value) {
                              updatedModel = value!;
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: Sprinter",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 3) {
                                return "Enter correct matriculate";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        //INPUT CAR COLOR 3
                        SizedBox(height: 15),
                        createLabel("Insert car color"),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            initialValue: color,
                            onSaved: (String? value) {
                              updatedColor = value!;
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: Green",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 3) {
                                return "Enter correct color";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        //INPUT CAR CAPACITY 4
                        SizedBox(height: 15),
                        createLabel("Insert car capacity (min: 2, max: 32)"),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            initialValue: nbrPlace,
                            onSaved: (String? value) {
                              updatedNbrPlace = value!;
                            },
                            // maxLength: 2,
                            decoration: InputDecoration(
                              hintText: "Ex: 32",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  int.parse(value) < 2 ||
                                  int.parse(value) > 32) {
                                return "Enter correct number";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        //INPUT 5
                        SizedBox(height: 15),
                        createLabel("Insert car state"),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            initialValue: carState,
                            onSaved: (String? value) {
                              updatedCarState = value!;
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: OK",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 2) {
                                return "Enter correct state";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        //ACTION BUTTON
                        Padding(
                          padding: EdgeInsets.only(
                              left: (screenWidth / 2) - 35, top: 10),
                          child: ElevatedButton(
                            onPressed: (() async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                print(matriculate);
                                CarEntityCreate car2 = CarEntityCreate(
                                    matriculate: updatedMatriculate,
                                    model: updatedModel,
                                    color: updatedColor,
                                    nbrPlace: int.parse(updatedNbrPlace),
                                    state_car: updatedCarState);

                                action() async {
                                  APIResponse updateResponse = await carServices
                                      .updateCar(widget.carId, car2);
                                  if (updateResponse.data == true) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => StatusPage(
                                                statusWord:
                                                    'Update Success!')));
                                  } else if (updateResponse.data == false) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => StatusPage(
                                                statusWord: 'Update Failed!')));
                                  }
                                }

                                await action();
                              }
                            }),
                            child: Text("Save"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
