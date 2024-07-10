import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/feature/detail_cashflow/provider/detail_cashflow_provider.dart';
import 'package:cashbook_app/feature/detail_cashflow/widgets/item/cashflow_item_widget.dart';
import 'package:cashbook_app/feature/detail_cashflow/widgets/loading/cashflow_loading.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DetailCashflowScreen extends StatefulWidget {
  const DetailCashflowScreen({super.key});

  @override
  State<DetailCashflowScreen> createState() => _DetailCashflowScreenState();
}

class _DetailCashflowScreenState extends State<DetailCashflowScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailCashflowProvider>().getCashflowData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Detail Cashflow',
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
      body: Consumer<DetailCashflowProvider>(
        builder: (context, detailCashflowProvider, _) {
          if (detailCashflowProvider.cashflowState == AppState.initial) {
            return const SizedBox.shrink();
          } else if (detailCashflowProvider.cashflowState == AppState.loading) {
            return const CashflowLoading();
          } else if (detailCashflowProvider.cashflowState == AppState.loaded) {
            return detailCashflowProvider.transactions.isEmpty
                ? const Center(
                    child: Text('Belum ada transaksi yang dilakukan.'),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      detailCashflowProvider.getCashflowData(context);
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: detailCashflowProvider.transactions.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        var transaction =
                            detailCashflowProvider.transactions[index];
                        bool isIncome = transaction['type'] == 'income';
                        return cashflowItemWidget(
                          context,
                          isIncome,
                          'Rp. ${transaction['amount'].toString()}',
                          transaction['description'],
                          DateTime.parse(transaction['date']),
                        );
                      },
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
