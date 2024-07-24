import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cars/car_edit_page.dart';
import 'package:smarta1/widgets/cars/car_details_widgets/car_details.dart';
import 'package:smarta1/widgets/cars/car_details_widgets/car_travel_list.dart';

import '../../services/car_service.dart';
import '../../utils/navigation_drawer.dart';
import 'car_create_page.dart';

class ViewCarPage extends StatefulWidget {
  String carId;

  ViewCarPage({required this.carId});

  @override
  State<ViewCarPage> createState() => _ViewCarPageState();
}

class _ViewCarPageState extends State<ViewCarPage> {
  bool isLoading = true;
  CarServices get carService => GetIt.instance<CarServices>();
  late APIResponse apiResponse;
  late bool cooperativeFound = false;
  late bool travelsFound = false;
  late var cooperative;

  fetchCars() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await carService.viewCar(widget.carId);
    cooperative = apiResponse.data.cooperative;
    if (cooperative != null) {
      setState(() {
        cooperativeFound = true;
      });
    }
    if (apiResponse.data.travel != null) {
      setState(() {
        travelsFound = true;
      });
    }
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
        title: Text('Car Details'),
        // actions: [
        //   TextButton(
        //       onPressed: () {
        //         Navigator.of(context)
        //             .push(MaterialPageRoute(builder: ((_) => CreateCar())));
        //       },
        //       child: Text('Edit Car details'))
        // ],
      ),
      drawer: const MyNavigationDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : apiResponse.error
              ? Text('An error occured')
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Text(apiResponse.data.matriculate),
                        cooperativeFound
                            ? CarDetailsWidget(
                                coopName: apiResponse.data.cooperative.name,
                                carColor: apiResponse.data.color,
                                nbrPlace: apiResponse.data.nbrPlace,
                                carState: apiResponse.data.state_car)
                            : CarDetailsWidget(
                                coopName: 'Unregistered',
                                carColor: apiResponse.data.color,
                                nbrPlace: apiResponse.data.nbrPlace,
                                carState: apiResponse.data.state_car),
                        travelsFound
                            ? CarTravelList(travels: apiResponse.data.travel)
                            : Text('No travels recorded yet'),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: BottomAppBar(
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
                            EditCarPage(carId: apiResponse.data.carId)));
                  },
                  child: Text(
                    'Edit car details',
                  )),
              ElevatedButton(
                  onPressed: null,
                  child: Text(
                    'Edit Cooperative ',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
