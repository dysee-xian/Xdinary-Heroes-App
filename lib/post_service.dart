import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final String id;
  final String userId;
  final String caption;
  final String imageUrl;
  final String likes;
  final String comments;
  final String createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.caption,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      userId: json["user_id"],
      caption: json["caption"],
      imageUrl: json["image_url"],
      likes: json["likes"],
      comments: json["comments"],
      createdAt: json["created_at"],
    );
  }
}

class PostService {
  static const String baseUrl = "http://10.0.2.2/fanbase_api";
  // pakai 10.0.2.2 kalau emulator Android

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse("$baseUrl/get_posts.php"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
