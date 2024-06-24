import 'package:flutter/material.dart';
import 'package:smarta1/widgets/cooperative/cooperative_edit_page.dart';

class CooperativeBottomActionBar extends StatelessWidget {
  String cooperativeId;
  CooperativeBottomActionBar({required this.cooperativeId});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          CooperativeEditPage(cooperativeId: cooperativeId),
                    ));
                  },
                  child: Text(
                    'Edit Cooperative Details',
                  )),
              ElevatedButton(
                  onPressed: null,
                  child: Text(
                    'Register new member',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
