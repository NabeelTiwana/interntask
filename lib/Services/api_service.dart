//api
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/post.dart';

class ApiService {
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}