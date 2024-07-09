import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddOutcomeProvider with ChangeNotifier {
  AppState addOutcomeState = AppState.initial;

  DateTime tanggalAddIncome = DateTime.now();

  final GlobalKey<FormState> addOutcomeFormKey = GlobalKey<FormState>();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  // Eksekusi fungsi dari home service untuk ambil Heading Data
  Future<void> addOutcome(BuildContext context) async {
    try {
      addOutcomeState = AppState.loading;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        clearFormInputan();

        Navigator.pop(context);

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
                  child: Text('Sukses, tambah pengeluaran berhasil dilakukan.'),
                ),
              ],
            ),
            backgroundColor: AppColors.success500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      addOutcomeState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
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
                  child: Text('Maaf, tambah pengeluaran gagal dilakukan.'),
                ),
              ],
            ),
            backgroundColor: AppColors.error500,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      addOutcomeState = AppState.failed;
      notifyListeners();
    }
  }

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
      return 'Nominal tidak boleh kosong.';
    }

    return null; // validasi berhasil
  }

  String? validateKeterangan(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Keterangan tidak boleh kosong.';
    }

    return null; // validasi berhasil
  }
}