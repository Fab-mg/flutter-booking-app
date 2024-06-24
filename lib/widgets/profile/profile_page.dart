import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/user_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/profile/models/user_details_model.dart';
import 'package:smarta1/widgets/profile/profile_widgets/avatar_name_widget.dart';
import 'package:smarta1/widgets/profile/profile_widgets/email_date_card_widget.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserService get userService => GetIt.I<UserService>();
  bool dataLoaded = false;
  bool errorStatus = false;
  late UserDetailsModel user;

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
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        shadowColor: Color.fromARGB(0, 106, 0, 254),
      ),
      body: Container(
        child: dataLoaded
            ? Container(
                child: errorStatus
                    ? Text("Error")
                    : Column(
                        children: [
                          UserAvatarWidget(
                            firstName: user.firstName,
                            lastName: user.lastName,
                          ),
                          SizedBox(height: 20),
                          EmailCardWidget(
                              email: user.email, createdAt: user.createdAt),
                        ],
                      ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
