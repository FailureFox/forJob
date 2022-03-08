import 'dart:convert';

import 'package:test_project/domain/http_domain.dart';
import 'package:test_project/models/user_model.dart';

class UsersDomain {
  static const url = 'jsonplaceholder.typicode.com';

  Future<List<AlbumModel>> getAlbums({int? id}) async {
    final Map<String, dynamic>? queryMap =
        id != null ? {'userId': '$id'} : null;
    final List map =
        await HttpDomain.domain.get(url: url, path: '/albums', query: queryMap);
    return map
        .map((e) => AlbumModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AvatarModel>> getAvatar() async {
    final List<dynamic> map =
        await HttpDomain.domain.get(url: url, path: '/photos');
    return map.map((e) => AvatarModel.fromMap(e)).toList();
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final usersMap =
          await HttpDomain.domain.get(url: url, path: '/users') as List;
      final List<AlbumModel> albumsList = await getAlbums();
      final List<AvatarModel> avatarList = await getAvatar();
      final List<UserModel> users = [];
      for (var item in usersMap) {
        final id = item['id'];
        final List<AlbumModel> userAlbums =
            albumsList.where((element) => element.id == id).toList();
        final List<AvatarModel> avatars = [];
        for (var item in userAlbums) {
          avatars.addAll(avatarList.where((element) => element.id == item.id));
        }
        users.add(UserModel.fromMap(item, avatars));
      }
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }
}

class AlbumModel {
  int userId;
  int id;
  String title;
  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}

class AvatarModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;
  AvatarModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory AvatarModel.fromMap(Map<String, dynamic> map) {
    return AvatarModel(
      albumId: map['albumId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AvatarModel.fromJson(String source) =>
      AvatarModel.fromMap(json.decode(source));
}
