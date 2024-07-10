import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/feature/home/provider/heading_provider.dart';
import 'package:cashbook_app/feature/home/widgets/loading/heading_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadingSection extends StatelessWidget {
  const HeadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadingProvider>(
      builder: (context, headingProvider, _) {
        if (headingProvider.headingState == AppState.initial) {
          return const SizedBox.shrink();
        } else if (headingProvider.headingState == AppState.loading) {
          return const HeadingLoading();
        } else if (headingProvider.headingState == AppState.loaded) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 56,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Halo!',
                            style: TextStyle(
                              fontSize: AppFontSize.heading4,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            headingProvider.username ?? 'User',
                            style: const TextStyle(
                              fontSize: AppFontSize.heading3,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.black,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: AppColors.neutral50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
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
