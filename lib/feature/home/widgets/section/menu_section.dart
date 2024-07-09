import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/state/finite_state.dart';
import 'package:cashbook_app/feature/home/provider/menu_provider.dart';
import 'package:cashbook_app/feature/home/widgets/item/menu_item_widget.dart';
import 'package:cashbook_app/feature/home/widgets/loading/menu_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, _) {
        if (menuProvider.menuState == AppState.initial) {
          return const SizedBox.shrink();
        } else if (menuProvider.menuState == AppState.loading) {
          return const MenuLoading();
        } else if (menuProvider.menuState == AppState.loaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: AppFontSize.heading5,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menuProvider.menuItemData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.3,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final item = menuProvider.menuItemData[index];
                    return menuItemWidget(
                      context,
                      item.image,
                      item.title,
                      item.colorFirst,
                      item.colorSecond,
                      item.onTap,
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('jiah error'),
          );
          // return const SizedBox.shrink();
        }
      },
    );
  }
}
