import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarta1/services/post_service.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/main_page/main_page_widgets/action_list.dart';
import 'package:smarta1/widgets/posts/models/post_model_list.dart';
import 'package:smarta1/widgets/posts/post_list_widgets/post_list_widget.dart';
import 'package:smarta1/widgets/profile/profile_page.dart';

import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../utils/navigation_drawer.dart';
import '../profile/models/user_details_model.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoggedIn = false;
  late String userId;
  AuthService get authService => GetIt.I<AuthService>();

  _loginCheck() async {
    bool result = await authService.loggedinCheck();
    setState(() {
      isLoggedIn = result;
    });
    // APIResponse apiResponse = await authService.;
  }

  bool postsLoaded = false;
  PostService get postServices => GetIt.I<PostService>();
  late APIResponse<List<PostListModel>> postApiResponse;

  _loadPosts() async {
    postApiResponse = await postServices.getPostList();
    if (!postApiResponse.error) {
      setState(() {
        postsLoaded = true;
      });
    }
  }

  @override
  void initState() {
    _loginCheck();
    _loadPosts();
    // _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
        title: Row(
          children: [
            Text('Accueil'),
            SizedBox(width: 5),
            Icon(Icons.home_outlined),
          ],
        ),
        shadowColor: Colors.transparent,
      ),
      drawer: MyNavigationDrawer(),
      body: !isLoggedIn
          ? Text(
              "Votre session a expiré. Veuillez retourner à la page de connexion.")
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color:
                    // Color.fromARGB(255, 111, 144, 200),
                    Colors.grey[300],
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 30),
                    //   child: Text(
                    //     'Que recherchez vous?',
                    //     style: GoogleFonts.bitter(
                    //       fontSize: 30,
                    //       fontWeight: FontWeight.bold,
                    //       // color: Colors.white,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    ActionListWidget(),
                    SizedBox(height: 50),
                    Text(
                      'Les actualités du mois',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 15),
                    !postsLoaded
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            width: MediaQuery.of(context).size.width * 0.93,
                            padding: EdgeInsets.only(top: 20, bottom: 0),
                            // color: Colors.blue,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 27, 47, 77),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            child: SingleChildScrollView(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Center(
                                    child: PostListWidget(
                                        posts: postApiResponse.data)),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
