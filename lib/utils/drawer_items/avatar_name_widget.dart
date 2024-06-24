import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:smarta1/widgets/profile/profile_widgets/clipPathWidget.dart';

class DrawerAvatarNameWidget extends StatefulWidget {
  String lastName;
  String firstName;

  DrawerAvatarNameWidget({
    required this.firstName,
    required this.lastName,
  });

  @override
  State<DrawerAvatarNameWidget> createState() => _DrawerAvatarNameWidgetState();
}

class _DrawerAvatarNameWidgetState extends State<DrawerAvatarNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          // MyClipPathWidget(),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            height: 150,
            width: 150,
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
            margin: EdgeInsets.only(top: 180),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.firstName}  ${widget.lastName}',
                  style:
                      GoogleFonts.lilitaOne(textStyle: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
