import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Util {
  static showError(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  static Future<bool> isInternetConnected() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
