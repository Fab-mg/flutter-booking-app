import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/car_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cars/model/car_entity_create.dart';

class CreateCar extends StatefulWidget {
  bool isEditing = false;
  String carId;

  CreateCar({this.carId = ''});

  @override
  State<CreateCar> createState() => _CreateCarState();
}

createLabel(String labelText) {
  return Container(
    child: Text(
      labelText,
      style: TextStyle(fontSize: 16),
    ),
    margin: EdgeInsets.only(left: 40),
  );
}

class _CreateCarState extends State<CreateCar> {
  final formKey = GlobalKey<FormState>();
  late String matriculate;
  late String model;
  late String carState;
  late String color;
  late String nbrPlace;
  bool registered = false;
  bool saveStatus = false;

  CarServices get carService => GetIt.instance<CarServices>();

  void actionChecker() {
    if (widget.carId.length > 5) {
      widget.isEditing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Register Car'),
        ),
        body: !registered
            ? SingleChildScrollView(
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
                          onSaved: (String? value) {
                            matriculate = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Ex: 358FD-35",
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
                          onSaved: (String? value) {
                            model = value!;
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
                          onSaved: (String? value) {
                            color = value!;
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
                          onSaved: (String? value) {
                            nbrPlace = value!;
                          },
                          maxLength: 2,
                          decoration: InputDecoration(
                            hintText: "Ex: 32",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty ||
                                // !RegExp(r'^[0,9]{1,2}+$').hasMatch(value) ||
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
                          onSaved: (String? value) {
                            carState = value!;
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
                          onPressed: (() {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print(matriculate);
                              int nbrPlace2 = int.parse(nbrPlace);
                              CarEntityCreate car = CarEntityCreate(
                                  matriculate: matriculate,
                                  model: model,
                                  color: color,
                                  nbrPlace: nbrPlace2,
                                  state_car: carState);

                              print(car.runtimeType);

                              loader(CarEntityCreate car) async {
                                APIResponse response =
                                    await carService.createCar(car);
                                setState(() {
                                  registered = true;
                                  saveStatus = response.data;
                                });
                              }

                              loader(car);
                            }
                          }),
                          child: Text("Save"),
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
