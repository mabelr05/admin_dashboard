import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/http/posts_response.dart';
import 'package:admin_dashboard/models/post.dart';
import 'package:flutter/material.dart';

class PostsProvider extends ChangeNotifier {
  List<Post> posts = [];

  getPosts() async {
    final resp = await CafeApi.httpGet('/posts');
    final postsResp = PostsResponse.fromMap(resp);

    posts = [...postsResp.posts];

    print(posts);

    notifyListeners();
  }

  Future<void> newPost(String titulo, String descripcion, String? img) async {
    final data = {
      'titulo': titulo,
      'descripcion': descripcion,
    };

    // Verificar si se proporcionó una imagen antes de agregarla al mapa
    if (img != null) {
      data['img'] = img;
    }

    try {
      final json = await CafeApi.post('/posts', data);
      final newPost = Post.fromMap(json);

      posts.add(newPost);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear publicacion';
    }
  }

  Future updatePost(String id, String title) async {
    final data = {'nombre': title};

    try {
      await CafeApi.put('/posts/$id', data);

      posts = posts.map((post) {
        if (post.id != id) return post;

        post.titulo = title;
        return post;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al Actualizar Post';
    }
  }

  Future deletePost(String id) async {
    try {
      await CafeApi.delete('/posts/$id', {});

      posts.removeWhere((post) => post.id == id);

      notifyListeners();
    } catch (e) {
      print(e);
      print(' Error al Eliminar Publicacion');
    }
  }
}
