import 'package:cashbook_app/feature/home/provider/chart_provider.dart';
import 'package:cashbook_app/feature/home/provider/heading_provider.dart';
import 'package:cashbook_app/feature/home/provider/menu_provider.dart';
import 'package:cashbook_app/feature/home/provider/resume_provider.dart';
import 'package:cashbook_app/feature/home/widgets/section/chart_section.dart';
import 'package:cashbook_app/feature/home/widgets/section/heading_section.dart';
import 'package:cashbook_app/feature/home/widgets/section/menu_section.dart';
import 'package:cashbook_app/feature/home/widgets/section/resume_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  onInitCalled() {
    context.read<HeadingProvider>().getHeadingData();
    context.read<ChartProvider>().getChartData();
    context.read<ResumeProvider>().getResumeData();
    context.read<MenuProvider>().loadingMenuData();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onInitCalled();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          onInitCalled();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/blurred_bg.png',
                  fit: BoxFit.fill,
                ),
              ),
              const Column(
                children: [
                  HeadingSection(),
                  ChartSection(),
                  SizedBox(
                    height: 16,
                  ),
                  ResumeSection(),
                  SizedBox(
                    height: 16,
                  ),
                  MenuSection(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
