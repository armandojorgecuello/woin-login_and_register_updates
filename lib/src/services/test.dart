/*import 'dart:async';
import 'dart:convert';

import 'package:woin/src/entities/Post.dart';
import 'package:woin/src/helpers/apiBase.dart';

class _Servicio{
  ApiBaseHelper _api = new ApiBaseHelper();
  Future<Post> getTest(int id) async {
    final response = await _api.httpGet('posts/$id');
    return Post.fromJson(response);
  }

  Future<List<Post>> getPostAll() async {
    final response = await _api.httpGet('posts');
    List<Post> posts = [];
    response.forEach((post)=>posts.add(Post.fromJson(post)));
    return posts;
  }
}

final servicio = new _Servicio();*/
