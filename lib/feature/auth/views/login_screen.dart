import 'package:animate_do/animate_do.dart';
import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/core/widgets/custom_text_form_field.dart';
import 'package:cashbook_app/feature/auth/provider/login_provider.dart';
import 'package:cashbook_app/feature/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, _) {
          return Form(
            key: loginProvider.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 70,
                      left: 70,
                      right: 70,
                      bottom: 50,
                    ),
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Image.asset(
                      'assets/images/cashbook_logo.png',
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: const Text(
                            "CatatKas",
                            style: TextStyle(
                              color: AppColors.primary500,
                              fontWeight: FontWeight.bold,
                              fontSize: AppFontSize.heading2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1100),
                          child: const Text(
                            "Silahkan login untuk masuk kedalam sistem",
                            style: TextStyle(
                              color: AppColors.neutral500,
                              fontWeight: FontWeight.normal,
                              fontSize: AppFontSize.text,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Column(
                            children: <Widget>[
                              CustomTextFormField(
                                textInputAction: TextInputAction.next,
                                validator: (value) => loginProvider
                                    .validateFormField(value, context),
                                controller: loginProvider.usernameController,
                                enable: true,
                                obscureText: false,
                                hint: 'Username',
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextFormField(
                                textInputAction: TextInputAction.done,
                                validator: (value) => loginProvider
                                    .validateFormField(value, context),
                                controller: loginProvider.passwordController,
                                enable: true,
                                maxLines: 1,
                                obscureText: true,
                                hint: 'Password',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        loginProvider.loginState == AppState.loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary500,
                                ),
                              )
                            : FadeInUp(
                                duration: const Duration(milliseconds: 1300),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (loginProvider.loginFormKey.currentState!
                                        .validate()) {
                                      await loginProvider.login(
                                        context,
                                        loginProvider.usernameController.text,
                                        loginProvider.passwordController.text,
                                      );

                                      if (context.mounted) {
                                        if (loginProvider.loginState ==
                                            AppState.loaded) {
                                          Navigator.of(context).pushReplacement(
                                            CupertinoPageRoute(
                                              builder: (BuildContext context) =>
                                                  const HomeScreen(),
                                            ),
                                          );
                                        } else {
                                          if (context.mounted) {
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
                                                            'Maaf, Username atau Password yang anda masukkan salah.')),
                                                  ],
                                                ),
                                                backgroundColor:
                                                    AppColors.error500,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    }
                                  },
                                  color: AppColors.primary500,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: AppFontSize.heading5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
