import 'package:test_project/domain/http_domain.dart';
import 'package:test_project/models/user_model.dart';

class UsersDomain {
  Future<List<UserModel>> getUsers() async {
    try {
      final usersMap = await HttpDomain.domain
          .get(url: 'jsonplaceholder.typicode.com', path: '/users') as List;
      return (usersMap).map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
