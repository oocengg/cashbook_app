import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  AppState loginState = AppState.initial;

  // List<FaqResponseModel> faqData = [];

  // HomeService homeService = HomeService();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateFormField(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong.';
    }

    return null; // validasi berhasil
  }

  // Eksekusi fungsi clear Data Bimbingan
  void clearLoginData() async {
    usernameController.clear();
    passwordController.clear();
  }

  Future<void> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    loginState = AppState.loading;
    notifyListeners();
    try {
      //Jika login berhasil
      //Lakukan post API login ke server
      // final response = await AuthService().login(
      //   username,
      //   password,
      // );

      //Jika post API berhasil setting preference untuk autentikasi

      // if (response != "Password Salah") {
      //   preferences.setString("token", response);
      //   preferences.setBool("isLoggedIn", true);

      //   // Dapatkan FCM token
      //   FirebaseMessaging messaging = FirebaseMessaging.instance;
      //   String? fcmToken = await messaging.getToken();
      //   String? nama = preferences.getString('nama');

      //   if (fcmToken == null) {
      //     throw Exception('Failed to get FCM token');
      //   }

      //   // Referensi ke koleksi users
      //   CollectionReference users =
      //       FirebaseFirestore.instance.collection('users');

      //   // Cari dokumen yang memiliki nama yang sama
      //   QuerySnapshot querySnapshot =
      //       await users.where('nama', isEqualTo: nama).get();

      //   if (querySnapshot.docs.isEmpty) {
      //     // Jika tidak ada dokumen dengan nama yang sama, tambahkan data baru ke Firestore
      //     await users.add({
      //       'nama': nama,
      //       'device_id': fcmToken,
      //     });
      //   } else {
      //     // Jika dokumen dengan nama yang sama ditemukan, perbarui token
      //     for (DocumentSnapshot doc in querySnapshot.docs) {
      //       await users.doc(doc.id).update({
      //         'device_id': fcmToken,
      //       });
      //     }
      //   }
      //   clearLoginData();

      //   loginState = AppState.loaded;
      //   notifyListeners();
      // } else {
      //   loginState = AppState.failed;
      //   notifyListeners();
      // }

      preferences.setBool("isLoggedIn", true);

      await Future.delayed(const Duration(seconds: 3));

      clearLoginData();

      loginState = AppState.loaded;
      notifyListeners();
    } catch (e) {
      loginState = AppState.failed;
      notifyListeners();
    }
  }
}
