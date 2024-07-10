import 'package:cashbook_app/core/extensions/date_ext.dart';
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
          List<SalesData> data = chartProvider.dailySummary.map((e) {
            return SalesData(
              e['date'],
              e['totalIncome'],
              e['totalOutcome'],
            );
          }).toList();

          return Center(
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  dataSource: data,
                  xValueMapper: (SalesData sales, _) =>
                      formatDateEEEEddMMyyyy(sales.date),
                  yValueMapper: (SalesData sales, _) => sales.income,
                  name: 'Income',
                  color: Colors.green,
                ),
                LineSeries<SalesData, String>(
                  dataSource: data,
                  xValueMapper: (SalesData sales, _) =>
                      formatDateEEEEddMMyyyy(sales.date),
                  yValueMapper: (SalesData sales, _) => sales.outcome,
                  name: 'Outcome',
                  color: Colors.red,
                ),
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

class SalesData {
  final String date;
  final double income;
  final double outcome;

  SalesData(this.date, income, outcome)
      : income = income.toDouble(),
        outcome = outcome.toDouble();
}
