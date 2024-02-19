import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';

class GamesElement extends StatelessWidget {
  final Widget icon;
  final String name;
  final String? time;
  final VoidCallback onPressed;
  const GamesElement(
      {super.key,
      required this.icon,
      this.time,
      required this.name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: time == null ? PaddingConsts.instance.top5 : null,
      margin: PaddingConsts.instance.all10,
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: RadiusConsts.instance.circularAll10,
          color: ColorConsts.instance.orange,
          boxShadow: ColorConsts.instance.shadow),
      child: ListTile(
        onTap: onPressed,
        leading: icon,
        title: Text(
          name,
          style: TextConsts.instance.regularWhite20Bold,
        ),
        subtitle: time != null
            ? Text(
                time!,
                style: TextConsts.instance.regularWhite20,
              )
            : null,
        trailing: Icon(
          Icons.play_arrow,
          size: 50,
          color: ColorConsts.instance.lightGray,
        ),
      ),
    );
  }
}
