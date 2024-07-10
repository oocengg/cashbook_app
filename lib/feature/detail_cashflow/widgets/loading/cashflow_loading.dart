import 'package:cashbook_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CashflowLoading extends StatelessWidget {
  const CashflowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
        loadingCashflowItem(context),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget loadingCashflowItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmerColor,
                  highlightColor: AppColors.highlightShimmerColor,
                  child: Container(
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Shimmer.fromColors(
            baseColor: AppColors.baseShimmerColor,
            highlightColor: AppColors.highlightShimmerColor,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.neutral200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
