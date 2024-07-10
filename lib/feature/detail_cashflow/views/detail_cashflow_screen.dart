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
      context.read<DetailCashflowProvider>().getCashflowData();
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
            return RefreshIndicator(
              onRefresh: () async {
                detailCashflowProvider.getCashflowData();
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  cashflowItemWidget(
                    context,
                    true,
                    'Rp. 250.000',
                    'Dapat bayaran panitia sertifikasi',
                    DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  cashflowItemWidget(
                    context,
                    false,
                    'Rp. 250.000',
                    'Biaya sertifikasi',
                    DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  cashflowItemWidget(
                    context,
                    true,
                    'Rp. 250.000',
                    'Dapat bayaran panitia sertifikasi',
                    DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  cashflowItemWidget(
                    context,
                    false,
                    'Rp. 250.000',
                    'Biaya sertifikasi',
                    DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  cashflowItemWidget(
                    context,
                    true,
                    'Rp. 250.000',
                    'Dapat bayaran panitia sertifikasi',
                    DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  cashflowItemWidget(
                    context,
                    false,
                    'Rp. 250.000',
                    'Biaya sertifikasi',
                    DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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
