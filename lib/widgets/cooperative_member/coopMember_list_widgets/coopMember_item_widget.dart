import 'package:flutter/material.dart';
import '../coopMember_details_page.dart';
import '../models/coopMember_list_model.dart';

class CoopMemberListItemWidget extends StatefulWidget {
  CoopMemberListModel coopMember;
  CoopMemberListItemWidget({required this.coopMember});

  @override
  State<CoopMemberListItemWidget> createState() =>
      _CoopMemberListItemWidgetState();
}

class _CoopMemberListItemWidgetState extends State<CoopMemberListItemWidget> {
  bool tapped = false;
  void _showActions() {
    setState(() {
      tapped = !tapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.coopMember.matriculateCM),
            subtitle: Text(widget.coopMember.roleCM),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.coopMember.userId),
              ],
            ),
            onTap: _showActions,
          ),
          tapped
              ? TextButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CoopMemberDetailsPage(
                              coopMemberId: widget.coopMember.coopMemberId,
                            )));
                  }),
                  child: Text('View'))
              : SizedBox(),
        ],
      ),
    );
  }
}
