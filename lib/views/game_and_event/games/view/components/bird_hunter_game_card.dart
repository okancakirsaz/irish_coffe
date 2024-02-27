part of '../games_view.dart';

class BirdHunterGameCard extends StatelessWidget {
  final String? time;
  final VoidCallback onPressed;
  const BirdHunterGameCard({super.key, this.time, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GamesElement(
      icon: Image.asset(
        AssetConsts.instance.parrot,
      ),
      name: "Kuş Vurma",
      time: time,
      onPressed: onPressed,
    );
  }
}
