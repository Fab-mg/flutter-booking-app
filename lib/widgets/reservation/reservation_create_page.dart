import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/reservation/models/reservation_create_model.dart';
import 'package:smarta1/widgets/travel/travel_list_page.dart';

import '../../services/auth_service.dart';
import '../../services/reservation_service.dart';
import '../../services/user_service.dart';
import '../profile/profile_widgets/clipPathWidget.dart';

class CreateReservationPage extends StatefulWidget {
  String reservationPlace;
  CreateReservationPage({required this.reservationPlace});

  @override
  State<CreateReservationPage> createState() => _CreateReservationPageState();
}

class _CreateReservationPageState extends State<CreateReservationPage> {
  //SETUP VARIABLES
  final _formKey = GlobalKey<FormState>();
  late String fullName;
  late String phone;
  late String CIN;
  late String relativePhone;
  bool enregistrementErreur = false;
  bool enregistrementComplete = false;

  ReservationService get reservationService => GetIt.I<ReservationService>();

  _createReservation({required ReservationCreateModel reservation}) async {
    APIResponse apiResponse =
        await this.reservationService.createReservation(reservation);
    if (apiResponse.error) {
      setState(() {
        enregistrementErreur = true;
      });
    } else {
      setState(() {
        enregistrementComplete = true;
      });
    }
  }

  _showConfirmDialog(BuildContext context, ReservationCreateModel reservation) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actionsPadding: EdgeInsets.zero,
        title: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Confirmer la reservation de cette place?",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                TextButton(
                  child: Text(
                    'Confirmer',
                    style: TextStyle(color: Colors.amber, fontSize: 17),
                  ),
                  onPressed: (() {
                    Navigator.pop(context);
                    _createReservation(reservation: reservation);
                  }),
                ),
                TextButton(
                  child: Text(
                    'Annuler',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool isLoggedIn = false;
  AuthService get authService => GetIt.I<AuthService>();
  UserService get userService => GetIt.I<UserService>();
  bool profileLoaded = false;
  late APIResponse profileResponse;

  Widget menuTitle(String title) {
    return Container(
      child: Text(title),
      width: 200,
    );
  }

  _loginCheck() async {
    bool result = await authService.loggedinCheck();
    setState(() {
      isLoggedIn = result;
    });
  }

  _loadProfile() async {
    profileResponse = await userService.viewProfile();
    if (!profileResponse.error) {
      setState(() {
        profileLoaded = true;
      });
    }
  }

  @override
  void initState() {
    _loginCheck();
    _loadProfile();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: enregistrementComplete
          ? null
          : AppBar(
              backgroundColor: Color.fromARGB(255, 27, 47, 77),
              shadowColor: Colors.transparent,
            ),
      backgroundColor: Colors.grey[300],
      body: !isLoggedIn
          ? Text("veuillez vous connecter")
          : SingleChildScrollView(
              child: SafeArea(
                child: enregistrementComplete
                    ? Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.8),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TravelListPage()));
                                }),
                              ),
                            ),
                            SizedBox(height: 40),
                            Text(
                              'Réservation terminé!',
                              style: GoogleFonts.bebasNeue(
                                  textStyle: TextStyle(fontSize: 40)),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.height * 0.7,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/success-person.png'),
                                  // fit: BoxFit.cover,
                                ),
                                // border: Border.all(
                                //   color: Color.fromARGB(255, 255, 196, 0),
                                //   width: 2,
                                // ),
                                // shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    : Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Color.fromARGB(255, 27, 47, 77),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                //WELCOME IMAGE
                                SizedBox(height: 20),
                                Text(
                                  'Votre place est prète!',
                                  style: GoogleFonts.bebasNeue(
                                      textStyle: TextStyle(fontSize: 40),
                                      color: Colors.white),
                                ),

                                Container(
                                  height: 130,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/touring.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: enregistrementErreur
                                      ? Text(
                                          "Une erreur s'est produite. Veuillez vérifier les données du formulaire et réessayer!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          'Veuillez remplir le formulaire suivant pour valider votre réservation',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                                SizedBox(height: 35),

                                //FullName InputField
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nom complet',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length <= 8) {
                                        return "Entrez votre nom";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (String? value) {
                                      fullName = value!;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),

                                //Phone number
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  child: TextFormField(
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Téléphone',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 10) {
                                        return "Entrez un numero de téléphone valide";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? newValue) {
                                      phone = newValue!;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),

                                //CIN
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CIN: 020452031045',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length > 15 ||
                                          value.length < 9) {
                                        return "Entrez votre numero de CIN";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? newValue) {
                                      CIN = newValue!;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),

                                //Relative Phone
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Téléphone d\'urgence',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 10) {
                                        return "Entrez un numero téléphone d'urgence.";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? newValue) {
                                      relativePhone = newValue!;
                                    },
                                  ),
                                ),

                                SizedBox(height: 20),
                                //Register
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 238, 184, 58),
                                            width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'VALIDER',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 240, 194, 88),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Icon(
                                              Icons.beenhere_sharp,
                                              color: Colors.amber[800],
                                            )
                                          ],
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.black),
                                        ),
                                        onPressed: (() {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            print(widget.reservationPlace);
                                            ReservationCreateModel reservation =
                                                ReservationCreateModel(
                                              reservedPlace:
                                                  widget.reservationPlace,
                                              phone: phone,
                                              CIN: CIN,
                                              fullName: fullName,
                                              relativePhone: relativePhone,
                                              reservationAuthor:
                                                  profileResponse.data.userId,
                                            );
                                            _showConfirmDialog(
                                                context, reservation);
                                          }
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
              ),
            ),
    );
  }
}
