import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  const CustomScaffold(
      {super.key, required this.body, this.appBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConsts.instance.background,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
