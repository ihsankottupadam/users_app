import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:users_app/core/models/user_model.dart';

class UserDB {
  static String get boxName => 'userCach';
  bool get isBoxOpen => Hive.isBoxOpen(boxName);

  Box userBox = Hive.box(boxName);

  catchUsers(List mapData) async {
    mapData.forEach(_catchUser);
  }

  _catchUser(user) {
    userBox.put(user['id'], user);
  }

  Future<List<UserModel>> fetchUsers() async {
    final data = userBox.values.toList();
    return userModelFromJson(jsonDecode(jsonEncode(data)));
  }
}
