import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';

class CustomTextField extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final TextStyle style;
  final TextInputType? inputType;
  final double height;
  const CustomTextField(
      {super.key,
      this.padding,
      required this.controller,
      required this.height,
      required this.style,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            boxShadow: ColorConsts.instance.shadow,
            color: ColorConsts.instance.lightGray,
            borderRadius: RadiusConsts.instance.circularAll100),
        child: TextFormField(
          keyboardType: inputType,
          inputFormatters: inputType == TextInputType.phone ||
                  inputType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : inputType == TextInputType.datetime
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
          cursorColor: Colors.black,
          style: style,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 5, left: 10),
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          controller: controller,
        ),
      ),
    );
  }
}
