import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';

class ResumeProvider with ChangeNotifier {
  AppState resumeState = AppState.loading;

  // List<FaqResponseModel> faqData = [];

  // HomeService homeService = HomeService();
  // // Ini Data User yang login, jadi bisa dipakai untuk mengambil nama dan foto di home
  // HeadingModel? user;

  // Eksekusi fungsi dari home service untuk ambil Heading Data
  void getResumeData() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      resumeState = AppState.loading;
      notifyListeners();

      // user = await homeService.getHeadingData(id: preferences.getString('id')!);

      await Future.delayed(const Duration(seconds: 3));

      resumeState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      resumeState = AppState.failed;
      notifyListeners();
    }
  }
}
