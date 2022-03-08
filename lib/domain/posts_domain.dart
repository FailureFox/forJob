import 'package:test_project/domain/http_domain.dart';
import 'package:test_project/models/comments_model.dart';
import 'package:test_project/models/post_model.dart';

class PostsDomain {
  static const link = 'jsonplaceholder.typicode.com';
  Future<List<CommentModel>> getPostComments(int id) async {
    final postMap = await HttpDomain.domain
        .get(url: link, path: '/comments', query: {'postId': '$id'}) as List;
    return postMap.map((e) => CommentModel.fromMap(e)).toList();
  }

  Future<List<PostModel>> getPosts(int id) async {
    final List map = await HttpDomain.domain
        .get(url: link, path: '/posts', query: {'userId': '$id'});
    return map.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<PostModel> addPost(Map<String, dynamic> map) async {
    final post = await HttpDomain.domain.post(
      url: link,
      path: '/posts',
      post: map,
      header: {'Content-type': 'application/json; charset=UTF-8'},
    );
    return PostModel.fromMap(post);
  }
}
