part of '../games_view.dart';

class QuizGame extends StatelessWidget {
  final String? time;
  final VoidCallback onPressed;
  const QuizGame({super.key, this.time, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GamesElement(
      icon: SvgPicture.asset(AssetConsts.instance.balloon),
      time: time,
      name: "Bilgi Yarışması",
      onPressed: () {},
    );
  }
}
