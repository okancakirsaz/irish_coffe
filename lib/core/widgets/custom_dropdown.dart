import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';

import '../consts/color_consts/color_consts.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuEntry> props;
  final String hint;
  final double? width;
  final TextEditingController controller;
  const CustomDropdown(
      {super.key,
      required this.props,
      required this.hint,
      required this.controller,
      this.width});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      menuStyle: MenuStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: RadiusConsts.instance.circularAll10),
        ),
      ),
      width: width,
      onSelected: (value) {
        controller.text = value;
      },
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorConsts.instance.lightGray,
        border: const OutlineInputBorder(),
        activeIndicatorBorder: BorderSide(color: ColorConsts.instance.orange),
      ),
      hintText: hint,
      requestFocusOnTap: false,
      controller: controller,
      dropdownMenuEntries: props,
    );
  }
}
