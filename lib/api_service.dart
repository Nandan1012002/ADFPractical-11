import 'dart:convert';
import 'package:http/http.dart' as http;
// Define a class to represent a Post
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
// Constructor for Post
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
// Factory method to create a Post object from JSON data
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
// Define a class to handle API requests
class ApiService {
// Base URL for the API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/todos/1';
// Method to fetch posts from the API
  static Future<List<Post>> fetchPosts() async {
// Make a GET request to the API endpoint
    final response = await http.get(Uri.parse('$baseUrl/posts'));
// Check if the response is successful (status code 200)
    if (response.statusCode == 200) {
// Decode the JSON response body
      List<dynamic> jsonResponse = json.decode(response.body);
// Map the JSON data to a list of Post objects using the Post.fromJson factory method
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
// If the response is not successful, throw an exception
      throw Exception('Failed to load posts');
    }
  }
}