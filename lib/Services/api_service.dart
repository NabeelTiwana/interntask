import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Models/post.dart';

class ApiService {
  static Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'YourAppName/1.0',
        },
      ).timeout(Duration(seconds: 10));

      log("RESPONSE ${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log("Error fetching posts: $e");
      throw Exception('Failed to load posts: $e');
    }
  }
}