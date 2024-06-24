import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/main_page/main_page.dart';
import 'package:smarta1/widgets/reservation/models/reservation_user_model.dart';

import '../../services/reservation_service.dart';

class EditReservationPage extends StatefulWidget {
  ReservationUser reservationUser;
  String reservationId;
  EditReservationPage(
      {required this.reservationUser, required this.reservationId});

  @override
  State<EditReservationPage> createState() => _EditReservationPageState();
}

class _EditReservationPageState extends State<EditReservationPage> {
  //SETUP VARIABLES
  final _formKey = GlobalKey<FormState>();
  late String fullName;
  late String phone;
  late String CIN;
  late String relativePhone;
  bool enregistrementErreur = false;
  bool enregistrementComplete = false;

  ReservationService get reservationService => GetIt.I<ReservationService>();

  _updateReservationUser(
      {required ReservationUser reservationUser,
      required String reservationId}) async {
    APIResponse apiResponse = await this
        .reservationService
        .updateReservationUser(reservationUser, reservationId);
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

  _showConfirmDialog(BuildContext context, ReservationUser reservationUser,
      String reservationId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actionsPadding: EdgeInsets.zero,
        title: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Modifier cette réservation?",
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
                    _updateReservationUser(
                      reservationUser: reservationUser,
                      reservationId: reservationId,
                    );
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: enregistrementComplete
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      Column(
                        children: [
                          Text(
                            'Modifications ',
                            style: GoogleFonts.bitter(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          ),
                          Text(
                            'enregistrées!',
                            style: GoogleFonts.bitter(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.height * 0.7,
                        child: Icon(
                          Icons.verified,
                          color: Color.fromARGB(255, 27, 47, 77),
                          size: 300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 60,
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_circle_left_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Retourner à l\'accueil',
                                style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                          ),
                          onPressed: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MainPage()));
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromARGB(255, 27, 47, 77),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //WELCOME IMAGE

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
                                  'Veuillez remplir le formulaire',
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
                            initialValue: widget.reservationUser.fullName,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nom complet',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.length <= 8) {
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
                            initialValue: widget.reservationUser.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Téléphone',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.length != 10) {
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
                            initialValue: widget.reservationUser.CIN,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'CIN: 020452031045',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.length > 15 || value.length < 9) {
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
                            initialValue: widget.reservationUser.relativePhone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Téléphone d\'urgence',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value!.length != 10) {
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
                                    color: Color.fromARGB(255, 238, 184, 58),
                                    width: 2.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MODIFIER',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 240, 194, 88),
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
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // print(widget.reservationPlace);
                                    //reservationUser final setup
                                    String phoneFinal;
                                    String CINFinal;
                                    String fullNameFinal;
                                    String relativePhoneFinal;
                                    if (phone == null) {
                                      phoneFinal = widget.reservationUser.phone;
                                    } else {
                                      phoneFinal = phone;
                                    }
                                    if (CIN == null) {
                                      CINFinal = widget.reservationUser.phone;
                                    } else {
                                      CINFinal = CIN;
                                    }
                                    if (fullName == null) {
                                      fullNameFinal =
                                          widget.reservationUser.phone;
                                    } else {
                                      fullNameFinal = fullName;
                                    }
                                    if (relativePhone == null) {
                                      relativePhoneFinal =
                                          widget.reservationUser.phone;
                                    } else {
                                      relativePhoneFinal = relativePhone;
                                    }
                                    print(phoneFinal);
                                    ReservationUser reservationUser =
                                        ReservationUser(
                                      phone: phoneFinal,
                                      CIN: CINFinal,
                                      fullName: fullNameFinal,
                                      relativePhone: relativePhoneFinal,
                                    );
                                    _showConfirmDialog(context, reservationUser,
                                        widget.reservationId);
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
        ),
      ),
    );
  }
}
