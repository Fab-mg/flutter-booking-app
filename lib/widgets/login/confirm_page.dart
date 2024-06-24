import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/auth_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/login/login_page.dart';
import 'package:smarta1/widgets/login/models/user_confirm_model.dart';

class ConfirmPage extends StatefulWidget {
  String email;
  ConfirmPage(this.email);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  AuthService get authService => GetIt.I<AuthService>();
  final _formKey = GlobalKey<FormState>();
  late String confirmationCode;
  bool codeError = false;
  bool confirmationDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: confirmationDone
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(height: 300),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Compte Activé'),
                          SizedBox(width: 10),
                          Icon(Icons.verified),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => LoginPage()));
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Retourner à la page de connexion'),
                            SizedBox(width: 10),
                            Icon(Icons.login),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 180),
                      Text(
                        'Confirmer votre email',
                        style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(fontSize: 35),
                            color: Color.fromARGB(255, 212, 168, 35)),
                        // TextStyle(
                        //     color: Color.fromARGB(255, 203, 159, 16), fontSize: 20),
                        // textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Un code de confirmation a été envoyé dans votre boite email. Veuillez confirmer l\'activation de votre compte en utilisant ce code.',
                          style:
                              TextStyle(color: Colors.grey[850], fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          initialValue:
                              widget.email.isEmpty ? '' : widget.email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length <= 5) {
                              return "Entrez un email valide";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? value) {
                            widget.email = value!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          initialValue:
                              widget.email.isEmpty ? '' : widget.email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Code de confirmation',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length <= 10) {
                              return "Entrez le code valide";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? value) {
                            confirmationCode = value!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //BUTTON
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
                              child: Text(
                                'Activer',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 240, 194, 88),
                                  fontSize: 18,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.black),
                              ),
                              onPressed: (() {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print(confirmationCode);

                                  UserConfirmModel info = UserConfirmModel(
                                    email: widget.email,
                                    code: confirmationCode,
                                  );

                                  _confirmAccount(UserConfirmModel info) async {
                                    APIResponse apiResponse = await authService
                                        .confirmAccount(info: info);
                                    if (apiResponse.error) {
                                      setState(() {
                                        codeError = true;
                                      });
                                    } else {
                                      setState(() {
                                        codeError = false;
                                        confirmationDone = true;
                                      });
                                    }
                                  }

                                  _confirmAccount(info);
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
