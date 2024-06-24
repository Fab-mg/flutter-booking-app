import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/auth_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/login/models/user_register_model.dart';

import 'confirm_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService get authService => GetIt.I<AuthService>();

  bool enregistrementErreur = false;

  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String lastName;
  late String firstName;

  _register(UserRegisterInfo user) async {
    APIResponse apiResponse = await authService.register(user);
    if (apiResponse.error) {
      setState(() {
        enregistrementErreur = true;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ConfirmPage(email)),
      );
    }
  }

  _showConfirmDialog(BuildContext context, UserRegisterInfo user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Confirmer l'envoit du formulaire?"),
        actions: [
          TextButton(
            child: Text('Confirmer'),
            onPressed: (() {
              _register(user);
              Navigator.pop(context);
            }),
          ),
          TextButton(
            child: Text('Annuler'),
            onPressed: () => Navigator.pop(context),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //WELCOME IMAGE

                //HEllo user
                SizedBox(height: 100),
                Text(
                  'Bienvenue!',
                  style:
                      GoogleFonts.bebasNeue(textStyle: TextStyle(fontSize: 40)),
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: enregistrementErreur
                      ? Text(
                          "Une erreur s'est produite. Veuillez réessayer!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.red),
                        )
                      : Text(
                          'Veuillez remplir le formulaire suivant pour créer votre compte',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                ),
                SizedBox(height: 25),

                //Mail InputField
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
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 5) {
                        return "Entrez un email valide";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? value) {
                      email = value!;
                    },
                  ),
                ),
                SizedBox(height: 10),

                //PassWord
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mot de passe',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 8) {
                        return "Minimum de characteres = 8";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? newValue) {
                      password = newValue!;
                    },
                  ),
                ),
                SizedBox(height: 10),

                //FirstName InputField
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
                      hintText: 'Prénom',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 15) {
                        return "Entrez votre prenom";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? newValue) {
                      firstName = newValue!;
                    },
                  ),
                ),
                SizedBox(height: 10),

                //Mail InputField
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
                      hintText: 'Nom',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 20) {
                        return "Entrez un votre nom";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? newValue) {
                      lastName = newValue!;
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
                        child: Text(
                          'Suivant',
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
                            print(email);
                            UserRegisterInfo user = UserRegisterInfo(
                              userEmail: email,
                              userPassword: password,
                              firstName: firstName,
                              lastName: lastName,
                            );
                            _showConfirmDialog(context, user);
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
    );
  }
}
