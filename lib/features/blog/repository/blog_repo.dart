// network logic here
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../model/blog_data_ui_model.dart';

class BlogRepo {
  static Future<List<BlogDataModel>> fetchBlogs() async {
    final blogDatabase = Hive.box('blog_database');
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    List<BlogDataModel> blogs = [];
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      final resData = jsonDecode(response.body);
      final res = resData["blogs"];
      for (int i = 0; i < res.length; i++) {
        BlogDataModel blog = BlogDataModel.fromJson(res[i]);
        blogs.add(blog);
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
      return [];
    }
    return blogs;
  }
}
