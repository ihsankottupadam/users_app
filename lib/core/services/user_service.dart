import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class UserService {
  Future<List> getUsers(int page) async {
    try {
      final response =
          await Dio().get(ApiConstants.users, queryParameters: {'page': page});
      log(response.data.toString());
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.message?.startsWith('SocketException') ?? false) {
          throw Exception('No Internet');
        }
      }
      log('User Service=>$e');
      throw Exception('Something went wrong');
    }
  }
}
