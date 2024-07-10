import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeProvider with ChangeNotifier {
  AppState resumeState = AppState.loading;
  double totalIncome = 0.0;
  double totalOutcome = 0.0;

  void getResumeData(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('userId');

    if (userId == null) {
      totalIncome = 0.0;
      totalOutcome = 0.0;

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
      resumeState = AppState.loading;
      notifyListeners();

      var dbHelper = DBHelper();
      Map<String, double> summary = await dbHelper.getMonthlySummary(userId);
      totalIncome = summary['income'] ?? 0.0;
      totalOutcome = summary['outcome'] ?? 0.0;

      await Future.delayed(const Duration(seconds: 1));

      resumeState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      resumeState = AppState.failed;
      notifyListeners();
    }
  }
}
