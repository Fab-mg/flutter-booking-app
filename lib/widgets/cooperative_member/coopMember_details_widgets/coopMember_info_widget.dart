import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/services/coopMember_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/cooperative_details_widgets/cooperative_city.dart';

import '../../../services/cooperative_services.dart';

class CoopMemberInfoWidget extends StatefulWidget {
  String matriculateCM;
  String roleCM;
  DateTime createdAt;
  String cooperativeId;
  String userId;

  CoopMemberInfoWidget({
    required this.matriculateCM,
    required this.roleCM,
    required this.createdAt,
    required this.cooperativeId,
    required this.userId,
  });

  @override
  State<CoopMemberInfoWidget> createState() => _CoopMemberInfoWidgetState();
}

class _CoopMemberInfoWidgetState extends State<CoopMemberInfoWidget> {
  CooperativeServices get cooperativeServices => GetIt.I<CooperativeServices>();

  late String cooperativeName;

  bool cooperativeLoaded = false;
  bool userInfoLoaded = false;
  bool allDataLoaded = false;

  _getCooperative() async {
    APIResponse response =
        await cooperativeServices.viewCooperative(widget.cooperativeId);
    if (!response.error) {
      cooperativeName = response.data.nameCooperative;
      return true;
    } else {
      return false;
    }
  }

  _loadAllData() async {
    bool dataOne = await _getCooperative();
    if (dataOne) {
      setState(() {
        allDataLoaded = true;
      });
    }
  }

  @override
  void initState() {
    _loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return !allDataLoaded
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(children: [
              showDetail("Numero matricule: ", widget.matriculateCM),
              showDetail("Inscrit le: ",
                  DateFormat('dd MMM yyyy').format(widget.createdAt)),
              showDetail("Fonction: ", widget.roleCM),
              showDetail("Cooperative: ", cooperativeName),
            ]),
          );
  }
}

// HELPER METHODS
Container showDetail(String inputLabel, String inputValue) {
  return Container(
    padding: EdgeInsets.all(5),
    child: Row(children: [
      Text(
        inputLabel,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        inputValue,
        style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 54, 51, 51)),
      ),
    ]),
  );
}
