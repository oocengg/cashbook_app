import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/feature/add_income/views/add_income_screen.dart';
import 'package:cashbook_app/feature/add_outcome/views/add_outcome_screen.dart';
import 'package:cashbook_app/feature/detail_cashflow/views/detail_cashflow_screen.dart';
import 'package:cashbook_app/feature/home/models/model/item_model.dart';
import 'package:cashbook_app/feature/settings/views/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  AppState menuState = AppState.loading;

  // List<FaqResponseModel> faqData = [];

  List<ItemModel> menuItemData = [
    ItemModel(
      image: 'assets/images/add_money.png',
      title: 'Tambah\nPemasukan',
      colorFirst: AppColors.blue500,
      colorSecond: AppColors.blue100,
      screen: const AddIncomeScreen(),
    ),
    ItemModel(
      image: 'assets/images/remove_money.png',
      title: 'Tambah\nPengeluaran',
      colorFirst: AppColors.error400,
      colorSecond: AppColors.error100,
      screen: const AddOutcomeScreen(),
    ),
    ItemModel(
      image: 'assets/images/cash_history.png',
      title: 'Detail\nCashflow',
      colorFirst: AppColors.mint500,
      colorSecond: AppColors.mint100,
      screen: const DetailCashflowScreen(),
    ),
    ItemModel(
      image: 'assets/images/settings.png',
      title: 'Pengaturan\n',
      colorFirst: AppColors.neutral500,
      colorSecond: AppColors.neutral100,
      screen: const SettingsScreen(),
    ),
  ];

  void loadingMenuData() async {
    try {
      menuState = AppState.loading;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      menuState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      menuState = AppState.failed;
      notifyListeners();
    }
  }
}
