import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class CustomAppBar {
  final PreferredSizeWidget? tabs;
  final Widget title;
  final List<Widget>? actions;

  CustomAppBar({
    required this.title,
    this.tabs,
    this.actions,
  });

  PreferredSizeWidget build() {
    return AppBar(
      backgroundColor: ColorConsts.instance.green,
      bottom: tabs,
      title: title,
      actions: actions,
    );
  }
}
