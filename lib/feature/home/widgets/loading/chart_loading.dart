import 'package:cashbook_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChartLoading extends StatelessWidget {
  const ChartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.baseShimmerColor,
        highlightColor: AppColors.highlightShimmerColor,
        child: Container(
          width: double.infinity,
          height: 320,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EFEF),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
