import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class CustomSliverAppBar {
  final PreferredSizeWidget? tabs;
  final Widget title;
  final List<Widget>? actions;

  CustomSliverAppBar({
    required this.title,
    this.tabs,
    this.actions,
  });

  Widget build() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: ColorConsts.instance.green,
      bottom: tabs,
      title: title,
      actions: actions,
    );
  }
}
