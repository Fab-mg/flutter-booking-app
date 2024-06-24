import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative_member/coopMember_details_widgets/coopMember_info_widget.dart';

import '../../services/coopMember_service.dart';

class CoopMemberDetailsPage extends StatefulWidget {
  String coopMemberId;
  CoopMemberDetailsPage({required this.coopMemberId});

  @override
  State<CoopMemberDetailsPage> createState() => _CoopMemberDetailsPageState();
}

class _CoopMemberDetailsPageState extends State<CoopMemberDetailsPage> {
  CoopMemberServices get coopMemberServices => GetIt.I<CoopMemberServices>();
  late APIResponse apiResponse;
  bool isLoading = true;
  bool isAdmin = false;

  void _loadData() async {
    apiResponse = await coopMemberServices.viewCoopMember(widget.coopMemberId);
    if (apiResponse.error) {
      print("data fetching error");
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(apiResponse.data.matriculateCM)),
      body: isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Data loaded!"),
                CoopMemberInfoWidget(
                  matriculateCM: apiResponse.data.matriculateCM,
                  roleCM: apiResponse.data.roleCM,
                  createdAt: apiResponse.data.createdAt,
                  cooperativeId: apiResponse.data.cooperativeId,
                  userId: apiResponse.data.userId,
                ),
              ],
            ),
      // bottomNavigationBar: !isAdmin
      //     ? CooperativeBottomActionBar(cooperativeId: widget.cooperativeId)
      //     : null,
    );
  }
}
