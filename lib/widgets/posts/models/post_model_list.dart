class PostListModel {
  String postId;
  String postTitle;
  String content;
  List images;
  String postAuthor;
  DateTime createdAt;

  PostListModel({
    required this.content,
    required this.images,
    required this.postAuthor,
    required this.postId,
    required this.postTitle,
    required this.createdAt,
  });
}
