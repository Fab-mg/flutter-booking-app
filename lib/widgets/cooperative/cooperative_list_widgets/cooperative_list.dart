import 'package:flutter/material.dart';
import 'package:smarta1/widgets/cooperative/cooperative_list_widgets/cooperative_list_item.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_list_model.dart';

class CooperativeListWidget extends StatefulWidget {
  List<CooperativeListModel> cooperatives;
  CooperativeListWidget({required this.cooperatives});

  @override
  State<CooperativeListWidget> createState() => _CooperativeListWidgetState();
}

class _CooperativeListWidgetState extends State<CooperativeListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Container(
              child: CooperativeListItemWidget(
                  cooperative: widget.cooperatives[index]),
            );
          }),
          itemCount: widget.cooperatives.length,
        ),
      ),
    );
  }
}
