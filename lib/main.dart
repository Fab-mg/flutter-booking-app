import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/auth_service.dart';
import 'package:smarta1/services/car_service.dart';
import 'package:smarta1/services/city_services.dart';
import 'package:smarta1/services/coopMember_service.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/services/place_service.dart';
import 'package:smarta1/services/post_service.dart';
import 'package:smarta1/services/reservation_service.dart';
import 'package:smarta1/services/travel_service.dart';
import 'package:smarta1/services/user_service.dart';
import 'package:smarta1/widgets/login/login_page.dart';
import 'package:smarta1/widgets/main_page/main_page.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => CarServices());
  GetIt.instance.registerLazySingleton(() => CooperativeServices());
  GetIt.instance.registerLazySingleton(() => CityServices());
  GetIt.instance.registerLazySingleton(() => CoopMemberServices());
  GetIt.instance.registerLazySingleton(() => AuthService());
  GetIt.instance.registerLazySingleton(() => TravelService());
  GetIt.instance.registerLazySingleton(() => PlaceServices());
  GetIt.instance.registerLazySingleton(() => ReservationService());
  GetIt.instance.registerLazySingleton(() => UserService());
  GetIt.instance.registerLazySingleton(() => PostService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  AuthService get authService => GetIt.I<AuthService>();

  _loginCheck() async {
    bool result = await authService.loggedinCheck();
    setState(() {
      isLoggedIn = result;
    });
  }

  @override
  void initState() {
    _loginCheck();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColorLight: Color.fromARGB(255, 27, 47, 77),

        primarySwatch: Colors.deepPurple,
      ),
      home: isLoggedIn ? MainPage() : LoginPage(),
    );
  }
}
