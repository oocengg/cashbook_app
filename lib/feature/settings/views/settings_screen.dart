import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/core/widgets/custom_text_form_field.dart';
import 'package:cashbook_app/feature/settings/provider/settings_provider.dart';
import 'package:cashbook_app/feature/settings/widgets/loading/settings_loading.dart';

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().getSettingsData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          if (settingsProvider.settingsState == AppState.initial) {
            return const SizedBox.shrink();
          } else if (settingsProvider.settingsState == AppState.loading) {
            return const SettingsLoading();
          } else if (settingsProvider.settingsState == AppState.loaded) {
            return RefreshIndicator(
              onRefresh: () async {
                settingsProvider.getSettingsData();
              },
              child: Stack(
                children: [
                  ListView(
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
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            settingsProvider.validateInputan(value, context),
                        controller: settingsProvider.oldPassController,
                        enable: true,
                        obscureText: true,
                        maxLines: 1,
                        hint: "Masukkan password baru",
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
                                  // if (addIncomeProvider
                                  //     .addIncomeFormKey.currentState!
                                  //     .validate()) {
                                  //   addIncomeProvider.addIncome(context);
                                  // }
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
                  Positioned(
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                'assets/images/fauzi.jpg',
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
