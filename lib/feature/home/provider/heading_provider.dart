import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';

class HeadingProvider with ChangeNotifier {
  AppState headingState = AppState.loading;

  // List<FaqResponseModel> faqData = [];

  // HomeService homeService = HomeService();
  // // Ini Data User yang login, jadi bisa dipakai untuk mengambil nama dan foto di home
  // HeadingModel? user;

  // Eksekusi fungsi dari home service untuk ambil Heading Data
  void getHeadingData() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      headingState = AppState.loading;
      notifyListeners();

      // user = await homeService.getHeadingData(id: preferences.getString('id')!);

      await Future.delayed(const Duration(seconds: 1));

      headingState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      headingState = AppState.failed;
      notifyListeners();
    }
  }
}
