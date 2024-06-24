import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:smarta1/services/cooperative_services.dart';
import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative_member/coopMember_details_page.dart';
import 'package:smarta1/widgets/cooperative_member/models/coopMember_details_model.dart';
import 'package:smarta1/widgets/posts/models/post_model_list.dart';
import 'package:smarta1/widgets/travel/travel_details_page.dart';

import '../../../utils/helper_widgets/icon_builder.dart';
import '../../cooperative/cooperative_details_page.dart';
import '../../main_page/main_page.dart';
import '../post_detail_page.dart';

class PostListItemWidget extends StatefulWidget {
  PostListModel post;
  PostListItemWidget({required this.post});

  @override
  State<PostListItemWidget> createState() => _PostListItemWidgetState();
}

class _PostListItemWidgetState extends State<PostListItemWidget> {
  CooperativeServices get cooperativeServices => GetIt.I<CooperativeServices>();
  late APIResponse apiResponse;

  _loadData() async {
    apiResponse =
        await this.cooperativeServices.viewCooperative(widget.post.postAuthor);
    if (!apiResponse.error) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  bool isLoaded = false;
  bool clicked = false;

  _switch() {
    setState(() {
      clicked = !clicked;
    });
  }

  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String dateCreated =
        DateFormat('dd MMM yyyy').format(widget.post.createdAt);
    String hourCreated = DateFormat('hh mm').format(widget.post.createdAt);
    return InkWell(
      onTap: _switch,
      child: !isLoaded
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 0, right: 5),
              // margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color:
                    // Color.fromARGB(255, 111, 144, 200)
                    clicked ? Colors.grey[300] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black,
                //     blurRadius: 3,
                //   ),
                // ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //LEFT ICON
                  Container(
                    width: width * 0.2,
                    child: ItemBuilderGlobal(
                      context: context,
                      imageLink: 'assets/images/news-reportColorful.png',
                      label: '',
                      widgetPath: MainPage(),
                      isCircular: false,
                      iconSize: 80,
                      iconCircular: false,
                    ),
                  ),

                  //RIGHT CONTENT
                  Container(
                    // width: width * 0.5,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: width * 0.5),
                            child: Text(
                              widget.post.postTitle,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(height: 5),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: width * 0.5, maxHeight: 100),
                            child: clicked
                                ? voirPlus(
                                    context,
                                    widget.post.postId,
                                    apiResponse.data.nameCooperative,
                                  )
                                : Text(
                                    widget.post.content,
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                    maxLines: 3,
                                  ),
                          ),
                          SizedBox(height: 5),
                          //Action Buttons
                          Container(
                            child: Row(children: [
                              Icon(Icons.date_range),
                              Text(dateCreated),
                              Container(
                                child: TextButton(
                                  onPressed: (() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                CooperativeDetailsPage(
                                                    cooperativeId: widget
                                                        .post.postAuthor))));
                                  }),
                                  child: Text(
                                    apiResponse.data.nameCooperative,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

//HELPER
Widget voirPlus(BuildContext context, String postId, String author) {
  return TextButton(
      onPressed: (() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => PostDetailsPage(
                  postId: postId,
                  postAuthor: author,
                ))));
      }),
      child: Row(
        children: [
          SizedBox(width: 20),
          Text(
            'Voir plus',
            style: TextStyle(
                color: Color.fromARGB(255, 206, 157, 10),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_circle_right,
            color: Color.fromARGB(255, 231, 175, 9),
            size: 30,
          )
        ],
      ));
}
