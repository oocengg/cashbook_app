import 'package:flutter/material.dart';

class ItemModel {
  String image;
  String title;
  Color colorFirst;
  Color colorSecond;
  Widget screen;

  ItemModel({
    required this.image,
    required this.title,
    required this.colorFirst,
    required this.colorSecond,
    required this.screen,
  });
}
