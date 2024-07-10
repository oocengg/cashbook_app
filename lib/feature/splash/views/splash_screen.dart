import 'dart:async';

import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/feature/auth/views/login_screen.dart';
import 'package:cashbook_app/feature/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    startSplashScreen();
    _buildPage();
  }

  startSplashScreen() async {
    const duration = Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) =>
              !isLoggedIn ? const LoginScreen() : const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue500,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cashbook_logo.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const Text(
                  'CatatKas',
                  style: TextStyle(
                    fontSize: AppFontSize.heading3,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Center(
              child: Text(
                'Muh. Fauzi Ramadhan N',
                style: TextStyle(
                  fontSize: AppFontSize.caption,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Penting untuk medefinisikan autentikasi user pertama kalo login aplikasi, login, dan logout
  _buildPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().isNotEmpty) {
      if (prefs.getBool('isLoggedIn')!) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    }
  }
}
