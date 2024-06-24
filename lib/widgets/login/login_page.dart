import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/auth_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/login/confirm_page.dart';
import 'package:smarta1/widgets/login/models/user_login_model.dart';
import 'package:smarta1/widgets/login/register_page.dart';
import 'package:smarta1/widgets/main_page/main_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService get authService => GetIt.I<AuthService>();

  bool apiConnected = false;
  bool isChecking = false;
  bool loginError = false;
  bool hideText = true;

  String apiCode = '0';
  apiCall() async {
    Uri apiUri = Uri.parse('http://10.0.2.2:3000/api/city');
    http.Response response;
    response = await http.get(apiUri);
    if (response.statusCode == 200) {
      setState(() {
        apiConnected = true;
        apiCode = 'CONNECTED: 200';
      });
    } else {
      setState(() {
        apiCode = 'FAILED TO CONNECT';
      });
    }
  }

  login(String userEmail, String userPassword) async {
    UserLoginInfo userInfo = UserLoginInfo(
      userEmail: userEmail,
      userPassword: userPassword,
    );

    setState(() {
      isChecking = true;
    });

    APIResponse apiResponse = await authService.login(userInfo);
    if (apiResponse.error) {
      setState(() {
        isChecking = false;
        loginError = true;
      });
    } else {
      setState(() {
        isChecking = false;
        loginError = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => MainPage())));
    }
  }

  //TEst
  final _mailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                //WELCOME IMAGE
                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 20),
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/waiting.jpg'),
                        fit: BoxFit.cover),
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 196, 0),
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),

                //HEllo user
                Text(
                  'SMARTA SERVICE',
                  style:
                      GoogleFonts.bebasNeue(textStyle: TextStyle(fontSize: 40)),
                ),
                SizedBox(height: 40),

                //Mail InputField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _mailController,
                    onEditingComplete: () {
                      if (_mailController.text.isEmpty) {}
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.mail_rounded,
                            color: Colors.amber[400],
                            size: 30,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Email',
                        contentPadding: EdgeInsets.only(right: 10)),
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
                  child: TextField(
                    controller: _passController,
                    obscureText: hideText,
                    decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.lock,
                          color: Colors.amber[400],
                          size: 30,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.grey,
                        ),
                        onPressed: (() {
                          setState(() {
                            hideText = !hideText;
                          });
                        }),
                      ),
                      border: InputBorder.none,
                      hintText: 'Mot de passe',
                    ),
                  ),
                ),

                SizedBox(height: 20),
                //Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color: Color.fromARGB(255, 238, 184, 58),
                            width: 2.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: (() {
                          login(_mailController.text, _passController.text);
                        }),
                        child: isChecking
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Se connecter',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 240, 194, 88),
                                  fontSize: 18,
                                ),
                              ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                      ),
                    ),
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
                        onPressed: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => RegisterPage()));
                        }),
                        child: Text(
                          'S\'enregistrer',
                          style: TextStyle(
                            color: Color.fromARGB(255, 240, 194, 88),
                            fontSize: 18,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                loginError ? Text('Erreur de connexion!') : SizedBox(),

                //TEST PAGES: OPEN TRANSACTION LIST
                SizedBox(height: 60),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     //OPEN APP WIthout Login
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.of(context).push(
                //             MaterialPageRoute(builder: (_) => MainPage()));
                //       },
                //       child: Text('OPEN'),
                //     ),

                //     //Confirmation Page
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.of(context).push(
                //             MaterialPageRoute(builder: (_) => ConfirmPage('')));
                //       },
                //       child: Text('Confirm'),
                //     ),

                //     //TEST API
                //     ElevatedButton(
                //       onPressed: () async {
                //         apiCall();
                //       },
                //       child: Text('Tap to connect api'),
                //     ),
                //   ],
                // ),
                // !apiConnected
                //     ? Row(
                //         children: [
                //           Text('V1.0.0'),
                //           Text(
                //             ' ${apiCode}',
                //             style: TextStyle(color: Colors.red),
                //           ),
                //         ],
                //       )
                //     : Row(
                //         children: [
                //           Text('V1.0.0'),
                //           Text(
                //             ' ${apiCode}',
                //             style: TextStyle(color: Colors.green),
                //           ),
                //         ],
                //       )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
