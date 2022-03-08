import 'package:test_project/domain/http_domain.dart';
import 'package:test_project/domain/posts_domain.dart';
import 'package:test_project/models/comments_model.dart';

class CommentsDomain {
  static const link = 'jsonplaceholder.typicode.com';
  Future<List<CommentModel>> getPostComments(int id) async {
    try {
      final postMap = await HttpDomain.domain
          .get(url: link, path: '/comments', query: {'postId': '$id'}) as List;
      return postMap.map((e) => CommentModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CommentModel> sendPostComment(int userId, String text) async {
    try {
      final Map<String, dynamic> map =
          await HttpDomain.domain.post(url: link, path: '/comments', post: {
        "name": "Вы",
        "body": text,
        "email": "testMail@mail.ru",
      }, header: {
        'Content-type': 'application/json; charset=UTF-8'
      });
      return CommentModel.fromMap(map);
    } catch (e) {
      throw Exception(e);
    }
  }
}
