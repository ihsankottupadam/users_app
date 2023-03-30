import 'dart:developer';

import 'package:users_app/core/database/userdb.dart';
import 'package:users_app/core/models/user_model.dart';

import '../services/user_service.dart';
import '../util/util.dart';

class UserRepository {
  Future<List<UserModel>> getUsers(int page) async {
    try {
      if (await Util.isInternetConnected()) {
        final users = await UserService().getUsers(page);
        UserDB().catchUsers(users);
        return userModelFromJson(users);
      } else {
        if (page > 1) {
          return [];
        }
        final users = UserDB().fetchUsers();
        return users;
      }
    } catch (e) {
      log('User Repository=>$e');
      throw 'Something went wrong';
    }
  }
}
