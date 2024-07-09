import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/feature/home/provider/chart_provider.dart';
import 'package:cashbook_app/feature/home/widgets/loading/chart_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartProvider>(
      builder: (context, chartProvider, _) {
        if (chartProvider.chartState == AppState.initial) {
          return const SizedBox.shrink();
        } else if (chartProvider.chartState == AppState.loading) {
          return const ChartLoading();
        } else if (chartProvider.chartState == AppState.loaded) {
          return Center(
            child: SfCartesianChart(
              // Initialize category axis
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 34),
                      SalesData('Apr', 32),
                      SalesData('May', 40)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales)
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('oops error'),
          );
        }
      },
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
      body: Center(
          child: SfCartesianChart(
              // Initialize category axis
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
            // Bind data source
            dataSource: <SalesData>[
              SalesData('Jan', 35),
              SalesData('Feb', 28),
              SalesData('Mar', 34),
              SalesData('Apr', 32),
              SalesData('May', 40)
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales)
      ])));
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
