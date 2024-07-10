import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartProvider with ChangeNotifier {
  AppState chartState = AppState.loading;
  List<Map<String, dynamic>> dailySummary = [];

  void getChartData(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('userId');

    if (userId == null) {
      dailySummary = [];

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

      notifyListeners();
      return;
    }

    try {
      chartState = AppState.loading;
      notifyListeners();

      var dbHelper = DBHelper();
      dailySummary = await dbHelper.getDailySummary(userId);

      await Future.delayed(const Duration(seconds: 1));

      chartState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      chartState = AppState.failed;
      notifyListeners();
    }
  }
}
