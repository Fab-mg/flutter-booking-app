import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/city_services.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/cooperative_details_page.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_list_model.dart';

class CooperativeListItemWidget extends StatefulWidget {
  CooperativeListModel cooperative;
  CooperativeListItemWidget({required this.cooperative});

  @override
  State<CooperativeListItemWidget> createState() =>
      _CooperativeListItemWidgetState();
}

class _CooperativeListItemWidgetState extends State<CooperativeListItemWidget> {
  bool tapped = false;
  void _showActions() {
    setState(() {
      tapped = !tapped;
    });
  }

  bool cityLoaded = false;
  late APIResponse cityResponse;
  CityServices get cityServices => GetIt.I<CityServices>();
  CooperativeServices get cooperativeServices => GetIt.I<CooperativeServices>();

  _loadCity() async {
    var coop = await cooperativeServices
        .viewCooperative(widget.cooperative.cooperativeId);
    cityResponse = await this.cityServices.viewCity(cityId: coop.data.city);
    if (!cityResponse.error) {
      setState(() {
        cityLoaded = true;
      });
    }
  }

  @override
  void initState() {
    _loadCity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 5),
      // color: Colors.white,
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
      child: Column(
        children: [
          ListTile(
            title: Text(widget.cooperative.nameCooperative),
            subtitle: !cityLoaded ? null : Text(cityResponse.data.nameCity),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.cooperative.phones[0]),
              ],
            ),
            onTap: _showActions,
          ),
          tapped
              ? TextButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CooperativeDetailsPage(
                              cooperativeId: widget.cooperative.cooperativeId,
                            )));
                  }),
                  child: Text('Voir les détails'))
              : SizedBox(),
        ],
      ),
    );
  }
}
