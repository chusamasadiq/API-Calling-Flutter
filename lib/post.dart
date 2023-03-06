class Post {
  int? userID;
  int? id;
  String? title;
  String? body;

  Post({this.userID, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userID: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
