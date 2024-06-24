import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/cooperative_details_widgets/cooperative_info.dart';

class CooperativeDetailsPage extends StatefulWidget {
  String cooperativeId;
  CooperativeDetailsPage({required this.cooperativeId});

  @override
  State<CooperativeDetailsPage> createState() => _CooperativeDetailsPageState();
}

class _CooperativeDetailsPageState extends State<CooperativeDetailsPage> {
  CooperativeServices get cooperativeServices => GetIt.I<CooperativeServices>();
  late APIResponse apiResponse;
  bool isLoading = true;
  bool isAdmin = false;

  void _loadData() async {
    apiResponse =
        await cooperativeServices.viewCooperative(widget.cooperativeId);
    if (apiResponse.error) {
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
      appBar: AppBar(
        title: isLoading ? null : Text('${apiResponse.data.nameCooperative}'),
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Color.fromARGB(255, 27, 47, 77),
      body: isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  padding:
                      EdgeInsets.only(top: 20, left: 30, right: 10, bottom: 30),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: CooperativeInfoWidget(
                    nameCooperative: apiResponse.data.nameCooperative,
                    emailCooperative: apiResponse.data.emailCooperative,
                    createdAt: apiResponse.data.createdAt,
                    updatedAt: apiResponse.data.updatedAt,
                    city: apiResponse.data.city,
                    phones: apiResponse.data.phones,
                  ),
                ),
              ],
            ),
      // bottomNavigationBar: !isAdmin
      //     ? CooperativeBottomActionBar(cooperativeId: widget.cooperativeId)
      //     : null,
    );
  }
}
