import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/extensions/date_ext.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/core/widgets/custom_text_form_field.dart';
import 'package:cashbook_app/feature/add_income/provider/add_income_provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddIncomeProvider>().clearFormInputan();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Tambah Pemasukan',
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
      body: Consumer<AddIncomeProvider>(
        builder: (context, addIncomeProvider, _) {
          return Form(
            key: addIncomeProvider.addIncomeFormKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.success500,
                  ),
                  child: const Center(
                    child: Text(
                      'Tambah Pemasukan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSize.text,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Masukkan data inputan yang valid untuk mencatat informasi uang masuk anda.',
                  style: TextStyle(
                    fontSize: AppFontSize.text,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Date Input
                const Text(
                  'Tanggal',
                  style: TextStyle(
                    fontSize: AppFontSize.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.neutral300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          formatDateddMMMMyyyy(
                            addIncomeProvider.tanggalAddIncome.toString(),
                          ),
                          style: const TextStyle(
                            fontSize: AppFontSize.text,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          addIncomeProvider.selectDate(context);
                        },
                        icon: const Icon(
                          FontAwesomeIcons.calendar,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Nominal Input
                const Text(
                  'Nominal',
                  style: TextStyle(
                    fontSize: AppFontSize.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: addIncomeProvider.nominalController,
                        validator: (value) =>
                            addIncomeProvider.validateNominal(value, context),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 18,
                              bottom: 18,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                bottomLeft: Radius.circular(14),
                              ), // Bentuk persegi
                            ),
                            child: const Text(
                              'Rp.',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSize.caption,
                              ),
                            ),
                          ),
                          hintText: 'Masukkan nominal yang anda inginkan',
                          hintStyle: const TextStyle(
                            fontSize: AppFontSize.caption,
                            color: AppColors.neutral600,
                          ),
                          border: Theme.of(context).inputDecorationTheme.border,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.neutral300,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.neutral300,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primary500,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          errorStyle: const TextStyle(
                            color: AppColors.error500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.error500,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.error500,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ), // Padding teks di dalam text field
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                // Keterangan Input
                const Text(
                  'Keterangan',
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
                  validator: (value) => null,
                  controller: addIncomeProvider.keteranganController,
                  enable: true,
                  obscureText: false,
                  maxLines: 5,
                  hint: "Tambahkan keterangan pemasukan anda",
                ),
                const SizedBox(
                  height: 24,
                ),
                addIncomeProvider.addIncomeState == AppState.loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary500,
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (addIncomeProvider.addIncomeFormKey.currentState!
                                .validate()) {
                              addIncomeProvider.addIncome(context);
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.primary500),
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
          );
        },
      ),
    );
  }
}
