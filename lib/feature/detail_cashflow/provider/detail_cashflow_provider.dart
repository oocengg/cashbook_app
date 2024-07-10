import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCashflowProvider with ChangeNotifier {
  AppState cashflowState = AppState.loading;
  List<Map<String, dynamic>> transactions = [];

  void getCashflowData(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('userId');

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

    try {
      cashflowState = AppState.loading;
      notifyListeners();

      var dbHelper = DBHelper();
      transactions = await dbHelper.getTransactionsByUser(userId);

      await Future.delayed(const Duration(seconds: 1));

      cashflowState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      cashflowState = AppState.failed;
      notifyListeners();
    }
  }
}
