import 'dart:convert';

import 'package:smarta1/widgets/posts/models/post_model_list.dart';
import 'package:smarta1/widgets/posts/models/post_view_model.dart';

import '../utils/api_response.dart';
import 'package:http/http.dart' as http;

import '../utils/db_link.dart';

db_link link = db_link();

class PostService {
  final header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<PostListModel>>> getPostList() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/post/'))
        .timeout(const Duration(seconds: 15), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Place Api reached');
      var jsonData = jsonDecode(response.body);
      var postList = <PostListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');

        PostListModel post = PostListModel(
          content: item['content'],
          images: item['images'],
          postAuthor: item['postAuthor'],
          postId: item['_id'],
          postTitle: item['postTitle'],
          createdAt: DateTime.parse(item['createdAt']),
        );

        print('check number 2: model created!');
        postList.add(post);
        print('check number 3: model added to main list!');
      }
      print('Post List returned');
      return APIResponse<List<PostListModel>>(data: postList);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> viewPost({required String postId}) async {
    final _uri = Uri.parse('${link.mobile}:3000/api/post/' + postId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('Post ID  $postId');
    if (response.statusCode == 200) {
      print('Post Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');
      PostDetailsModel post = PostDetailsModel(
        content: jsonData['content'],
        images: jsonData['images'],
        postAuthor: jsonData['postAuthor'],
        postId: jsonData['_id'],
        postTitle: jsonData['postTitle'],
        createdAt: DateTime.parse(jsonData['createdAt']),
      );

      print('Post returned in view function');
      return APIResponse<PostDetailsModel>(data: post);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }
}
