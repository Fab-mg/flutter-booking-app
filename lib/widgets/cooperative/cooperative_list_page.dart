import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/cooperative_list_widgets/cooperative_list.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_list_model.dart';

import '../../utils/navigation_drawer.dart';
import 'cooperative_create_page.dart';
import 'cooperative_list_widgets/cooperative_search_widget.dart';

class CooperativeListPage extends StatefulWidget {
  bool? queryIsSet;
  String? searchQuery;

  CooperativeListPage({bool? queryIsSet, String? searchQuery}) {
    if (queryIsSet != null) {
      this.queryIsSet = queryIsSet;
    }
    if (searchQuery != null) {
      this.searchQuery = searchQuery;
    }
  }

  @override
  State<CooperativeListPage> createState() => _CooperativeListPageState();
}

class _CooperativeListPageState extends State<CooperativeListPage> {
  CooperativeServices get cooperativeServices => GetIt.I<CooperativeServices>();
  late APIResponse<List<CooperativeListModel>> apiResponse;
  bool dataIsLoaded = false;
  bool dataLoadingError = false;

  _getData() async {
    apiResponse = await cooperativeServices.getCooperatives();
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

  _getQueryData(String query) async {
    apiResponse = await cooperativeServices.searchCooperatives(query: query);
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

  _loadData() async {
    bool isSearching;
    isSearching = widget.queryIsSet ?? false;
    if (isSearching) {
      _getQueryData(widget.searchQuery as String);
    } else {
      _getData();
    }
  }

  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    late String searchQuery;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Liste des cooperatives"),
            SizedBox(width: 8),
            Icon(Icons.people_alt_outlined),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        shadowColor: Color.fromARGB(0, 106, 0, 254),
      ),
      body: !dataIsLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !dataLoadingError
              ? SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: [
                        CooperativeSearchWidget(),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: CooperativeListWidget(
                                cooperatives: apiResponse.data)),
                      ],
                    ),
                  ),
                )
              : Text('Failed to load data'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CooperativeCreatePage()));
        },
      ),
      drawer: MyNavigationDrawer(),
    );
  }
}
