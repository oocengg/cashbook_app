import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/feature/home/provider/chart_provider.dart';
import 'package:cashbook_app/feature/home/provider/resume_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddIncomeProvider with ChangeNotifier {
  AppState addIncomeState = AppState.initial;

  DateTime tanggalAddIncome = DateTime.now();

  final GlobalKey<FormState> addIncomeFormKey = GlobalKey<FormState>();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  void clearFormInputan() async {
    tanggalAddIncome = DateTime.now();
    nominalController.clear();
    keteranganController.clear();
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      tanggalAddIncome = picked;
    }
    notifyListeners();
  }

  // Fungsi fungsi untuk validasi inputan
  String? validateNominal(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Nominal tidak boleh kosong';
    }
    if (double.tryParse(value) == null) {
      return 'Nominal harus berupa angka';
    }
    return null;
  }

  String? validateKeterangan(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Keterangan tidak boleh kosong.';
    }

    return null; // validasi berhasil
  }

  Future<void> addIncome(BuildContext context) async {
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

    addIncomeState = AppState.loading;
    notifyListeners();

    try {
      var dbHelper = DBHelper();
      Map<String, dynamic> transaction = {
        'type': 'income',
        'amount': double.parse(nominalController.text),
        'description': keteranganController.text,
        'date': tanggalAddIncome.toIso8601String(),
        'user_id': userId,
      };

      await dbHelper.insertTransaction(transaction);

      // Clear form
      clearFormInputan();

      await Future.delayed(const Duration(seconds: 1));

      addIncomeState = AppState.loaded;
      notifyListeners();

      Navigator.pop(context);

      context.read<ChartProvider>().getChartData(context);
      context.read<ResumeProvider>().getResumeData(context);

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
                child: Text('Sukses, tambah pemasukan berhasil dilakukan.'),
              ),
            ],
          ),
          backgroundColor: AppColors.success500,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      addIncomeState = AppState.failed;
      notifyListeners();

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
                child: Text('Maaf, tambah pemasukan gagal dilakukan.'),
              ),
            ],
          ),
          backgroundColor: AppColors.error500,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
