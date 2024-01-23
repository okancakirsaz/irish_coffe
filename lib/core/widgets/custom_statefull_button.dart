import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';

class CustomStateFullButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle style;
  final String text;
  final double width;
  final double height;
  const CustomStateFullButton(
      {super.key,
      required this.onPressed,
      required this.style,
      required this.text,
      required this.width,
      required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConsts.instance.lightGray,
          border: Border.all(),
          borderRadius: RadiusConsts.instance.circularAll100),
      child: EasyButton(
          type: EasyButtonType.text,
          width: width,
          height: height,
          buttonColor: ColorConsts.instance.lightGray,
          borderRadius: 100,
          onPressed: onPressed,
          idleStateWidget: Text(
            text,
            style: style,
          ),
          loadingStateWidget: Padding(
            padding: PaddingConsts.instance.all10,
            child: CircularProgressIndicator(
              color: ColorConsts.instance.orange,
            ),
          )),
    );
  }
}
