import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/cooperative_create_page.dart';
import 'package:smarta1/widgets/cooperative/cooperative_list_widgets/cooperative_list.dart';
import 'package:smarta1/widgets/cooperative_member/coopMember_list_widgets/coopMember_list_widget.dart';

import '../../services/coopMember_service.dart';
import 'models/coopMember_list_model.dart';

class CoopMemberListPage extends StatefulWidget {
  @override
  State<CoopMemberListPage> createState() => _CoopMemberListPageState();
}

class _CoopMemberListPageState extends State<CoopMemberListPage> {
  CoopMemberServices get coopMemberServices => GetIt.I<CoopMemberServices>();
  late APIResponse<List<CoopMemberListModel>> apiResponse;
  bool dataIsLoaded = false;
  bool dataLoadingError = false;

  getData() async {
    apiResponse = await coopMemberServices.getCoopMembers();
    if (apiResponse.error == false) {
      setState(() {
        dataIsLoaded = true;
      });
    } else {
      setState(() {
        dataIsLoaded = true;
        dataLoadingError = true;
      });
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des membres"),
      ),
      body: !dataIsLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !dataLoadingError
              ? SingleChildScrollView(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child:
                          CoopMemberListWidget(coopMembers: apiResponse.data)),
                )
              : Text('Failed to load data'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CooperativeCreatePage()));
        },
      ),
    );
  }
}
