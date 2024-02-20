part of '../game_final_view.dart';

class YouWinPage extends StatelessWidget {
  final GameFinalViewModel viewModel;
  const YouWinPage({super.key, required this.viewModel});

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
          viewModel.duelData.itemName != "Ödülsüz"
              ? Padding(
                  padding: PaddingConsts.instance.all20,
                  child: Text(
                    "KAZANDINIZ: ${viewModel.duelData.itemName} x${viewModel.duelData.itemCount}",
                    style: TextConsts.instance.regularWhite25Bold,
                  ),
                )
              : Text(
                  "KAZANDINIZ!",
                  style: TextConsts.instance.regularWhite25Bold,
                ),
          viewModel.duelData.itemName != "Ödülsüz"
              ? Padding(
                  padding: PaddingConsts.instance.all20,
                  child: Text(
                    "Eğer kaybeden taraf sipariş verirse isminiz ile çağrılacaksınız.",
                    style: TextConsts.instance.regularWhite20,
                  ),
                )
              : const SizedBox(),
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
