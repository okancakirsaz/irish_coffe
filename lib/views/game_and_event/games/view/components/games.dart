part of '../games_view.dart';

class Games extends StatelessWidget {
  final GamesViewModel viewModel;
  const Games({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(AssetConsts.instance.coin),
            const SizedBox(width: 15),
            Text(
              "Oyunları oyna,\nödülleri kap!",
              style: TextConsts.instance.regularBlack20Bold,
            )
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: <Widget>[
              QuizGame(
                onPressed: () =>
                    viewModel.navigateToGame("Bilgi Yarışması", viewModel),
              ),
              SnakeGameCard(
                onPressed: () =>
                    viewModel.navigateToGame("Yılan Oyunu", viewModel),
              )
            ],
          ),
        ),
      ],
    );
  }
}
