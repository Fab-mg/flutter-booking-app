import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarta1/services/post_service.dart';
import 'package:smarta1/widgets/posts/models/post_model_list.dart';
import 'package:smarta1/widgets/posts/post_list_widgets/post_list_widget.dart';

import '../../utils/api_response.dart';

class PostListPage extends StatefulWidget {
  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  PostService get postServices => GetIt.I<PostService>();
  late APIResponse<List<PostListModel>> apiResponse;
  bool dataIsLoaded = false;
  bool dataLoadingError = false;

  getData() async {
    apiResponse = await postServices.getPostList();
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

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 47, 77),
      appBar: AppBar(
        title: Row(
          children: [
            Text("Liste des articles"),
            SizedBox(width: 15),
            Icon(Icons.article)
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
                    child:
                        Center(child: PostListWidget(posts: apiResponse.data)),
                  ),
                )
              : Text('Failed to load data'),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: null,
      //   // () {
      //   //   Navigator.of(context)
      //   //       .push(MaterialPageRoute(builder: (_) => CooperativeCreatePage()));
      //   // },
      // ),
    );
  }
}
