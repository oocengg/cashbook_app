import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  AppState changePasswordState = AppState.initial;
  AppState stateLogout = AppState.initial;

  final GlobalKey<FormState> changePasswordFormkey = GlobalKey<FormState>();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();

  String error = '';

  void changePassword(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('userId');
    String? username = preferences.getString('username');

    if (userId == null) {
      // Handle error jika userId tidak ditemukan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                FontAwesomeIcons.circleXmark,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text('User tidak ditemukan, silakan login kembali'),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    changePasswordState = AppState.loading;
    notifyListeners();

    try {
      var dbHelper = DBHelper();

      // Get user details
      Map<String, dynamic>? user = await dbHelper.getUserByUsernameAndPassword(
          username ?? '', oldPassController.text);

      if (user != null) {
        // Update password
        await dbHelper.updateUserPassword(
            username ?? '', newPassController.text);
        error = '';

        clearFormInputan();

        await Future.delayed(const Duration(seconds: 2));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  FontAwesomeIcons.circleCheck,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text('Sukses, password berhasil diganti.'),
                ),
              ],
            ),
            backgroundColor: AppColors.success500,
            behavior: SnackBarBehavior.floating,
          ),
        );

        changePasswordState = AppState.loaded;
        notifyListeners();
      } else {
        error = "Current password is incorrect";

        clearFormInputan();

        changePasswordState = AppState.failed;
        notifyListeners();
      }
    } catch (e) {
      changePasswordState = AppState.failed;
      notifyListeners();
    }
  }

  void clearFormInputan() async {
    oldPassController.clear();
    newPassController.clear();
    notifyListeners();
  }

  // Fungsi fungsi untuk validasi inputan
  String? validateInputan(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong.';
    }

    return null; // validasi berhasil
  }

  // Fungsi untuk user logout dari aplikasi
  Future<void> logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    stateLogout = AppState.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 3));
      preferences.remove("id");
      preferences.remove("username");
      preferences.setBool("isLoggedIn", false);

      stateLogout = AppState.loaded;
      notifyListeners();
    } catch (e) {
      stateLogout = AppState.failed;
      notifyListeners();
    }
  }
}
