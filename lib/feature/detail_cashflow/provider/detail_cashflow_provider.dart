import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';

class DetailCashflowProvider with ChangeNotifier {
  AppState cashflowState = AppState.loading;

  // List<FaqResponseModel> faqData = [];

  // HomeService homeService = HomeService();
  // // Ini Data User yang login, jadi bisa dipakai untuk mengambil nama dan foto di home
  // HeadingModel? user;

  // Eksekusi fungsi dari home service untuk ambil Heading Data
  void getCashflowData() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      cashflowState = AppState.loading;
      notifyListeners();

      // user = await homeService.getHeadingData(id: preferences.getString('id')!);

      await Future.delayed(const Duration(seconds: 3));

      cashflowState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      cashflowState = AppState.failed;
      notifyListeners();
    }
  }
}
