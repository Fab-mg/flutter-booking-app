import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/city_services.dart';
import 'package:smarta1/utils/api_response.dart';

class CooperativeCityWidget extends StatefulWidget {
  String cityId;
  CooperativeCityWidget({required this.cityId});
  @override
  State<CooperativeCityWidget> createState() => _CooperativeCityWidgetState();
}

class _CooperativeCityWidgetState extends State<CooperativeCityWidget> {
  CityServices get cityServices => GetIt.I<CityServices>();
  late APIResponse apiResponse;
  String nameCity = "Unregistered";
  String postalCode = "XXX";

  void _loadData() async {
    apiResponse = await cityServices.viewCity(cityId: widget.cityId);
    if (!apiResponse.error) {
      setState(() {
        nameCity = apiResponse.data.nameCity;
        postalCode = apiResponse.data.postalCode;
      });
    }
  }

  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        SizedBox(width: 5),
        Icon(Icons.location_on),
        Text(
          nameCity,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(width: 5),
        Text(
          "[${postalCode}]",
          style: TextStyle(fontSize: 17),
        ),
      ]),
    );
  }
}
