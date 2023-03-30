import 'package:flutter/material.dart';
import 'package:users_app/core/repository/user_repository.dart';

import 'package:users_app/core/util/util.dart';

import '../models/user_model.dart';

class HomeProvider with ChangeNotifier {
  bool isLoading = false;
  bool isLodingMoreRunning = false;
  bool hasMoreData = true;
  int page = 1;
  BuildContext? context;

  List<UserModel> users = [];
  ScrollController scrollController = ScrollController();

  init(context) {
    scrollController.addListener(_paginationListener);
    isLoading = true;
    notifyListeners();
    this.context = context;
    fetchUsers();
  }

  Future fetchUsers() async {
    final data = await UserRepository().getUsers(page).onError(
        (error, stackTrace) => Util.showError(context!, error.toString()));
    if (data.isEmpty) {
      hasMoreData = false;
      return;
    }
    users.addAll(data);
    page++;

    isLoading = false;
    notifyListeners();
  }

  _paginationListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLodingMoreRunning && hasMoreData) {
        isLodingMoreRunning = true;
        notifyListeners();
        fetchUsers().whenComplete(() {
          isLodingMoreRunning = false;
          notifyListeners();
        });
      }
    }
  }
}
