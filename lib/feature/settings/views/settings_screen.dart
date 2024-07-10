import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/core/widgets/custom_text_form_field.dart';
import 'package:cashbook_app/feature/auth/views/login_screen.dart';
import 'package:cashbook_app/feature/settings/provider/settings_provider.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blue500,
        shadowColor: AppColors.black.withOpacity(0.2),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return Stack(
            children: [
              Form(
                key: settingsProvider.changePasswordFormkey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Ganti Password',
                      style: TextStyle(
                        fontSize: AppFontSize.heading5,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // Old Password Input
                    const Text(
                      'Password Saat Ini',
                      style: TextStyle(
                        fontSize: AppFontSize.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          settingsProvider.validateInputan(value, context),
                      controller: settingsProvider.oldPassController,
                      enable: true,
                      obscureText: true,
                      maxLines: 1,
                      hint: "Masukkan password saat ini",
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // New Password Input
                    const Text(
                      'Password Baru',
                      style: TextStyle(
                        fontSize: AppFontSize.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (value) =>
                          settingsProvider.validateInputan(value, context),
                      controller: settingsProvider.newPassController,
                      enable: true,
                      obscureText: true,
                      maxLines: 1,
                      hint: "Masukkan password baru",
                    ),
                    settingsProvider.error == ''
                        ? const SizedBox.shrink()
                        : const SizedBox(
                            height: 8,
                          ),
                    settingsProvider.error == ''
                        ? const SizedBox.shrink()
                        : const Text(
                            'Maaf, password saat ini salah. ',
                            style: TextStyle(
                              fontSize: AppFontSize.caption,
                              fontWeight: FontWeight.normal,
                              color: AppColors.error500,
                            ),
                          ),
                    const SizedBox(
                      height: 24,
                    ),
                    settingsProvider.changePasswordState == AppState.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary500,
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (settingsProvider
                                    .changePasswordFormkey.currentState!
                                    .validate()) {
                                  settingsProvider.changePassword(context);
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.primary500),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  fontSize: AppFontSize.text,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              keyboardIsOpened
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 24,
                          ),
                          color: AppColors.white,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(
                                      'assets/images/fauzi.jpg',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CatatKas App',
                                          style: TextStyle(
                                            fontSize: AppFontSize.heading4,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.black,
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'Muh. Fauzi Ramadhan Nugraha',
                                          style: TextStyle(
                                            fontSize: AppFontSize.heading5,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '(2041720022)',
                                          style: TextStyle(
                                            fontSize: AppFontSize.text,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          '10 Juli 2024',
                                          style: TextStyle(
                                            fontSize: AppFontSize.caption,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.neutral500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              settingsProvider.stateLogout == AppState.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.error500,
                                      ),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          bool keluar =
                                              await warningLogout(context);
                                          if (context.mounted) {
                                            if (keluar) {
                                              await settingsProvider
                                                  .logout(context);

                                              if (context.mounted) {
                                                if (settingsProvider
                                                        .stateLogout ==
                                                    AppState.loaded) {
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen(),
                                                    ),
                                                    (route) => false,
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .circleXmark,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                                'Maaf, Terjadi kesalahan. '),
                                                          ),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 255, 83, 71),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                          }
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            AppColors.error500,
                                          ),
                                        ),
                                        child: const Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontSize: AppFontSize.text,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}

Future<bool> warningLogout(BuildContext context) async {
  bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: AppFontSize.heading3,
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi ini?',
          style: TextStyle(
            fontSize: AppFontSize.text,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Mengembalikan false jika dibatalkan
            },
            child: const Text(
              'Batal',
              style: TextStyle(color: AppColors.primary500),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Mengembalikan true jika "Baca Semua" ditekan
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.error500),
            ),
            child: const Text(
              'Keluar',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      );
    },
  );
  return result ??
      false; // Mengembalikan false jika tidak ada respons dari dialog
}
