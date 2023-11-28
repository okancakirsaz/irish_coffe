import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class CustomAppBar {
  final PreferredSizeWidget? tabs;
  final Widget title;

  CustomAppBar({required this.title, this.tabs});
  PreferredSizeWidget build() {
    return AppBar(
      backgroundColor: ColorConsts.instance.green,
      bottom: tabs,
      title: title,
    );
  }
}
