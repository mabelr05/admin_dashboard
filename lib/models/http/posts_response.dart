import 'dart:convert';

import '../post.dart';

class PostsResponse {
    List<Post> posts;

    PostsResponse({
        required this.posts,
    });

    factory PostsResponse.fromJson(String str) => PostsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PostsResponse.fromMap(Map<String, dynamic> json) => PostsResponse(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toMap())),
    };
}

