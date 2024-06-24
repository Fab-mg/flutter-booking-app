import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/services/post_service.dart';
import 'package:smarta1/utils/api_response.dart';

import '../cooperative/cooperative_details_page.dart';

class PostDetailsPage extends StatefulWidget {
  String postId;
  String postAuthor;
  PostDetailsPage({required this.postId, required this.postAuthor});
  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late APIResponse apiResponse;
  PostService get postService => GetIt.I<PostService>();
  bool postLoaded = false;
  bool loadingError = false;

  _getPostDetails() async {
    apiResponse = await this.postService.viewPost(postId: widget.postId);
    if (apiResponse.error) {
      setState(() {
        loadingError = true;
      });
    }
    setState(() {
      postLoaded = true;
    });
  }

  @override
  void initState() {
    _getPostDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        backgroundColor: Color.fromARGB(255, 27, 47, 77),
      ),
      body: !postLoaded
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //METADATA
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        //TITLE
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 1),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                          child: Text(
                            apiResponse.data.postTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Post crée le: ${DateFormat('dd MMM yyyy').format(apiResponse.data.createdAt)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(
                              'Redigé par',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              child: Text(
                                widget.postAuthor,
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                        CooperativeDetailsPage(
                                            cooperativeId:
                                                apiResponse.data.postAuthor))));
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //BODY
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      apiResponse.data.content,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
