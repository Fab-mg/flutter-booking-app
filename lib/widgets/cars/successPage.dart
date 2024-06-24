import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusPage extends StatelessWidget {
  String statusWord;
  StatusPage({required this.statusWord});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          statusWord,
          style: GoogleFonts.righteous(
            textStyle: TextStyle(fontSize: 40),
            color: Colors.greenAccent[500],
          ),
        ),
      ),
    );
  }
}
