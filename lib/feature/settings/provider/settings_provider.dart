import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  AppState settingsState = AppState.loading;
  AppState changePasswordState = AppState.initial;

  final GlobalKey<FormState> changePasswordFormkey = GlobalKey<FormState>();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();

  // Eksekusi fungsi dari home service untuk ambil Heading Data
  void getSettingsData() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      settingsState = AppState.loading;
      notifyListeners();

      // user = await homeService.getHeadingData(id: preferences.getString('id')!);

      await Future.delayed(const Duration(seconds: 3));

      settingsState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      settingsState = AppState.failed;
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
}
