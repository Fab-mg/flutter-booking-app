import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/widgets/cooperative/cooperative_list_page.dart';
import 'package:smarta1/widgets/reservation/reservation_list_page.dart';
import 'package:smarta1/widgets/travel/travel_list_page.dart';

import '../../../services/user_service.dart';
import '../../../utils/api_response.dart';
import '../../profile/models/user_details_model.dart';

class ActionListWidget extends StatefulWidget {
  bool isCoopMember = false;
  ActionListWidget({bool? isCoopMember}) {
    if (isCoopMember != null) this.isCoopMember = isCoopMember;
  }

  @override
  State<ActionListWidget> createState() => _ActionListWidgetState();
}

class _ActionListWidgetState extends State<ActionListWidget> {
  late UserDetailsModel user;
  UserService get userService => GetIt.I<UserService>();
  bool dataLoaded = false;
  bool errorStatus = false;

  _getUser() async {
    APIResponse apiResponse = await userService.viewProfile();
    if (apiResponse.error) {
      setState(() {
        dataLoaded = true;
        errorStatus = true;
      });
    } else {
      user = apiResponse.data;
      setState(() {
        dataLoaded = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemBuilder(
            'assets/images/traveler.png',
            'Voyager',
            context,
            TravelListPage(),
          ),
          _ItemBuilder(
            'assets/images/ticket-offic.png',
            'Coopérative',
            context,
            CooperativeListPage(),
          ),
          !dataLoaded
              ? SizedBox()
              : _ItemBuilder(
                  'assets/images/calendar2.png',
                  'Réservation',
                  context,
                  ReservationListPage(userId: user.userId),
                )
        ],
      ),
    );
  }
}

//HELPER
Widget _ItemBuilder(
  String imageLink,
  String label,
  BuildContext context,
  Widget widgetPath,
) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widgetPath));
    },
    child: Container(
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: 3,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageLink),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            constraints: BoxConstraints(maxWidth: 100),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
