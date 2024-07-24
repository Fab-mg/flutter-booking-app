import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/user_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/utils/drawer_items/avatar_name_widget.dart';
import 'package:smarta1/utils/drawer_items/logout_button.dart';
import 'package:smarta1/widgets/login/login_page.dart';
import 'package:smarta1/widgets/main_page/main_page.dart';
import 'package:smarta1/widgets/posts/post_list_page.dart';
import 'package:smarta1/widgets/profile/profile_page.dart';
import 'package:smarta1/widgets/reservation/reservation_list_page.dart';

import '../services/auth_service.dart';
import '../widgets/cars/car_list_page.dart';
import '../widgets/cooperative/cooperative_list_page.dart';
import '../widgets/cooperative_member/coopMember_list_page.dart';
import '../widgets/travel/travel_list_page.dart';

class MyNavigationDrawer extends StatefulWidget {
  const MyNavigationDrawer({super.key});

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  bool isLoggedIn = true;
  AuthService get authService => GetIt.I<AuthService>();
  UserService get userService => GetIt.I<UserService>();
  bool profileLoaded = false;
  late APIResponse profileResponse;

  Widget menuTitle(String title) {
    return Container(
      child: Text(title),
      width: 200,
    );
  }

  _loginCheck() async {
    bool result = await authService.loggedinCheck();
    setState(() {
      isLoggedIn = result;
    });
  }

  _loadProfile() async {
    profileResponse = await userService.viewProfile();
    if (!profileResponse.error) {
      setState(() {
        profileLoaded = true;
      });
    }
  }

  @override
  void initState() {
    _loginCheck();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: !isLoggedIn
          ? InkWell(
              child: drawerItemMaker(
                width: width,
                context: context,
                text: 'Se connecter',
                icon: Icons.login,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => LoginPage()));
              },
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Drawer(
                backgroundColor: Color.fromARGB(189, 255, 255, 255),
                width: width * 0.9,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => UserProfilePage()));
                      },
                      child: Container(
                        width: width * 0.7,
                        child: !profileLoaded
                            ? SizedBox()
                            : DrawerAvatarNameWidget(
                                firstName: profileResponse.data.firstName,
                                lastName: profileResponse.data.lastName),
                      ),
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        InkWell(
                          child: drawerItemMaker(
                            width: width,
                            context: context,
                            text: 'Accueil',
                            icon: Icons.home,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => MainPage()));
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: drawerItemMaker(
                            width: width,
                            context: context,
                            text: 'Voyages',
                            icon: Icons.track_changes,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => TravelListPage()));
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: drawerItemMaker(
                            width: width,
                            context: context,
                            text: 'Articles',
                            icon: Icons.article,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PostListPage()));
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: drawerItemMaker(
                            width: width,
                            context: context,
                            text: 'Coopératives',
                            icon: Icons.people_alt_rounded,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CooperativeListPage()));
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: drawerItemMaker(
                            width: width,
                            context: context,
                            text: 'Réservations',
                            icon: Icons.date_range_outlined,
                          ),
                          onTap: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ReservationListPage(
                                    userId: profileResponse.data.userId)));
                          }),
                        ),
                        SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.only(left: 100, bottom: 10),
                            child: LogoutButtonWidget()),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

Widget drawerItemMaker({
  required double width,
  required BuildContext context,
  required String text,
  required IconData icon,
}) {
  return Container(
    width: width * 0.7,
    height: 50,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 27, 47, 77),
      borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
      onPressed: null,
    ),
  );
}
