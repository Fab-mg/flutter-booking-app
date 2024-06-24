import 'package:flutter/material.dart';
import 'package:smarta1/widgets/cooperative/cooperative_list_page.dart';

class CooperativeSearchWidget extends StatefulWidget {
  @override
  State<CooperativeSearchWidget> createState() =>
      _CooperativeSearchWidgetState();
}

class _CooperativeSearchWidgetState extends State<CooperativeSearchWidget> {
  final _searchController = TextEditingController();
  late String searchQuery;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 250,
            margin: EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 10),
            child: TextField(
              controller: _searchController,
            ),
          ),
          IconButton(
            onPressed: (() {
              if (!_searchController.text.isEmpty &&
                  _searchController.text.length >= 2) {
                print(
                    'We are in onPressed function ${_searchController.text} inside the widget');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => CooperativeListPage(
                          queryIsSet: true,
                          searchQuery: _searchController.text,
                        )));
              }
            }),
            icon: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
