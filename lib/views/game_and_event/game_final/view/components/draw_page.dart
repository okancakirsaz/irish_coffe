part of '../game_final_view.dart';

class DrawPage extends StatelessWidget {
  final GameFinalViewModel viewModel;
  const DrawPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${viewModel.winnerUserScore} - ${viewModel.loserUserScore}",
            style: TextConsts.instance.regularWhite70Bold,
          ),
          Text(
            "BERABERE",
            style: TextConsts.instance.regularWhite25Bold,
          ),
          CustomButton(
            onPressed: () => viewModel.navigateToMainPage(),
            style: TextConsts.instance.regularBlack18Bold,
            text: "Ana Sayfaya Git",
            width: 200,
            height: 50,
          )
        ],
      ),
    );
  }
}
