import 'dart:ui';

class ItemModel {
  String image;
  String title;
  Color colorFirst;
  Color colorSecond;
  Function() onTap;

  ItemModel({
    required this.image,
    required this.title,
    required this.colorFirst,
    required this.colorSecond,
    required this.onTap,
  });
}
