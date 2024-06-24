import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/widgets/cooperative/cooperative_details_widgets/Cooperative_city.dart';

class CooperativeInfoWidget extends StatelessWidget {
  String nameCooperative;
  String emailCooperative;
  DateTime createdAt;
  DateTime updatedAt;
  String city;
  List<String> phones;

  CooperativeInfoWidget({
    required this.nameCooperative,
    required this.emailCooperative,
    required this.createdAt,
    required this.updatedAt,
    required this.city,
    required this.phones,
  });

  Container showDetail(String inputLabel, String inputValue) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(children: [
        Text(
          inputLabel,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          inputValue,
          style:
              TextStyle(fontSize: 17, color: Color.fromARGB(255, 54, 51, 51)),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            Icon(Icons.mail),
            showDetail("Email", emailCooperative),
          ],
        ),
        Row(
          children: [
            Icon(Icons.phone),
            showDetail("Contacts", '${phones[0]}'),
          ],
        ),
        Text(
          '  ${phones[1]}',
          style:
              TextStyle(fontSize: 17, color: Color.fromARGB(255, 54, 51, 51)),
        ),
        Row(
          children: [
            Icon(Icons.date_range),
            showDetail(
                "A rejoint le", DateFormat('dd MMM yyyy').format(createdAt)),
          ],
        ),
        CooperativeCityWidget(cityId: city),
      ]),
    );
  }
}
