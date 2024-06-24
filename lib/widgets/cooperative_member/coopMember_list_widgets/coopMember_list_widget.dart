import 'package:flutter/material.dart';

import '../models/coopMember_list_model.dart';
import 'coopMember_item_widget.dart';

class CoopMemberListWidget extends StatefulWidget {
  List<CoopMemberListModel> coopMembers;
  CoopMemberListWidget({required this.coopMembers});

  @override
  State<CoopMemberListWidget> createState() => _CoopMemberListWidgetState();
}

class _CoopMemberListWidgetState extends State<CoopMemberListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Card(
              child: CoopMemberListItemWidget(
                  coopMember: widget.coopMembers[index]),
            );
          }),
          itemCount: widget.coopMembers.length,
        ),
      ),
    );
  }
}
