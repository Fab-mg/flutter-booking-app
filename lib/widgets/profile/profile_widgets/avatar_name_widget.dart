import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/widgets/profile/profile_widgets/clipPathWidget.dart';

class UserAvatarWidget extends StatelessWidget {
  String lastName;
  String firstName;

  UserAvatarWidget({
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          MyClipPathWidget(),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/3dMan.png'),
                  fit: BoxFit.cover),
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 225),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$firstName  $lastName',
                  style:
                      GoogleFonts.lilitaOne(textStyle: TextStyle(fontSize: 25)),
                ),
                Icon(Icons.verified_rounded, color: Colors.amber, size: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}
