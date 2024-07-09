import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/keys/navigator_key.dart';
import 'package:cashbook_app/feature/add_income/provider/add_income_provider.dart';
import 'package:cashbook_app/feature/auth/provider/login_provider.dart';
import 'package:cashbook_app/feature/home/provider/chart_provider.dart';
import 'package:cashbook_app/feature/home/provider/heading_provider.dart';
import 'package:cashbook_app/feature/home/provider/menu_provider.dart';
import 'package:cashbook_app/feature/home/provider/resume_provider.dart';
import 'package:cashbook_app/feature/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth Provider
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),

        // Home Provider
        ChangeNotifierProvider(
          create: (context) => HeadingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResumeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),

        // Menu Provider
        ChangeNotifierProvider(
          create: (context) => AddIncomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cashbook App',
        home: const SplashScreen(),
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary500,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Colors.white,
            shadowColor: Colors.black,
            elevation: 20,
            surfaceTintColor: Colors.white,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.white,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
