import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeadingProvider with ChangeNotifier {
  AppState headingState = AppState.loading;

  String? username = '';

  void getHeadingData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      headingState = AppState.loading;
      notifyListeners();

      username = preferences.getString('username');

      await Future.delayed(const Duration(seconds: 1));

      headingState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      headingState = AppState.failed;
      notifyListeners();
    }
  }
}
