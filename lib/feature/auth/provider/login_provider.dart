import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  AppState loginState = AppState.initial;
  AppState signUpState = AppState.initial;

  // List<FaqResponseModel> faqData = [];

  // HomeService homeService = HomeService();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateFormField(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong.';
    }

    return null; // validasi berhasil
  }

  // Eksekusi fungsi clear Data Bimbingan
  void clearLoginData() async {
    usernameController.clear();
    passwordController.clear();
  }

  Future<void> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var dbHelper = DBHelper();

    loginState = AppState.loading;
    notifyListeners();
    try {
      var user = await dbHelper.getUser(username);
      if (user != null && user['password'] == password) {
        preferences.setBool("isLoggedIn", true);
        preferences.setString(
          "username",
          user['username'],
        );
        preferences.setInt(
          "userId",
          user['id'],
        ); // Simpan user_id di SharedPreferences
        await Future.delayed(const Duration(seconds: 3));
        clearLoginData();
        loginState = AppState.loaded;
      } else {
        loginState = AppState.failed;
      }
      notifyListeners();
    } catch (e) {
      loginState = AppState.failed;
      notifyListeners();
    }
  }

  Future<void> signUp(
    BuildContext context,
    String username,
    String password,
  ) async {
    var dbHelper = DBHelper();

    signUpState = AppState.loading;
    notifyListeners();
    try {
      await dbHelper.signUp(username, password);
      signUpState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      signUpState = AppState.failed;
      notifyListeners();
    }
  }
}
