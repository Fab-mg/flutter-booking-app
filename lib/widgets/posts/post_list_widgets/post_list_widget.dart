import 'package:flutter/material.dart';
import 'package:smarta1/widgets/posts/post_list_widgets/post_item_widget.dart';

import '../models/post_model_list.dart';

class PostListWidget extends StatefulWidget {
  List<PostListModel> posts;
  PostListWidget({required this.posts});

  @override
  State<PostListWidget> createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: PostListItemWidget(post: widget.posts[index]),
            );
          }),
          itemCount: widget.posts.length,
        ),
      ),
    );
  }
}
