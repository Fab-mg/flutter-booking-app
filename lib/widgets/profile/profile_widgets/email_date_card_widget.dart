import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Container showDetail(String inputLabel, String inputValue) {
  return Container(
    padding: EdgeInsets.all(5),
    child: Row(children: [
      SizedBox(height: 10),
      Text(
        inputLabel,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        inputValue,
        style: TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 255, 255, 252),
        ),
      ),
      SizedBox(height: 15),
    ]),
  );
}

class EmailCardWidget extends StatelessWidget {
  String email;
  DateTime createdAt;
  EmailCardWidget({required this.email, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Card(
        elevation: 15,
        shadowColor: Colors.white54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.deepPurple,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(),
              ),
              showDetail(
                ' A rejoint la plateforme le ',
                DateFormat('dd MMM yyy').format(createdAt),
              ),
              // showDetail('email', email)
            ],
          ),
        ),
      ),
    );
  }
}
