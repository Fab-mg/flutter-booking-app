import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/auth_service.dart';
import 'package:smarta1/widgets/login/login_page.dart';

class LogoutButtonWidget extends StatefulWidget {
  const LogoutButtonWidget({super.key});

  @override
  State<LogoutButtonWidget> createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends State<LogoutButtonWidget> {
  AuthService get authService => GetIt.I<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: (() {
          authService.logout();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        }),
        child: Row(
          children: [
            Text(
              'Se déconnecter',
              style: TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 27, 47, 77),
              ),
              // textAlign: TextAlign.center,
            ),
            SizedBox(width: 5),
            Icon(Icons.logout_rounded),
          ],
        ),
      ),
    );
  }
}
