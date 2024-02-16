part of '../games_view.dart';

class SnakeGame extends StatelessWidget {
  final String? time;
  final VoidCallback onPressed;
  const SnakeGame({super.key, this.time, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GamesElement(
      icon: SvgPicture.asset(AssetConsts.instance.snake),
      name: "Yılan ve Yonca",
      time: time,
      onPressed: onPressed,
    );
  }
}
