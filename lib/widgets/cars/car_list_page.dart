import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:smarta1/services/car_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cars/model/car_entity.dart';
import 'package:smarta1/widgets/cars/car_list_widgets/car_list_widget.dart';
import 'package:smarta1/widgets/cars/car_create_page.dart';

import '../../utils/navigation_drawer.dart';

CarServices get carServices => GetIt.I<CarServices>();

class CarList extends StatefulWidget {
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  CarServices get carService => GetIt.instance<CarServices>();
  List<Car> cars = [];
  late APIResponse apiResponse;
  bool isLoading = true;

  fetchCars() async {
    apiResponse = await carService.getCars();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Lists'),
      ),
      drawer: const MyNavigationDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : apiResponse.error
              ? Center(child: Text('Error type ${apiResponse.errorMessage}'))
              : SingleChildScrollView(
                  child: Column(children: [
                    CarListWidget(cars: apiResponse.data),
                  ]),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((_) => CreateCar())));
        },
      ),
    );
  }
}
