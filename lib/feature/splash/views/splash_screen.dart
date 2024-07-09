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
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/cashbook_logo.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            // Text('Splash Screen'),
          ),
          Positioned(
            bottom: 35,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'POWERED BY',
                  style: TextStyle(
                    fontSize: AppFontSize.caption,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/powered_by.png',
                    height: 60,
                  ),
                  // Text('Splash Screen'),
                ),
              ],
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
