part of '../game_final_view.dart';

class YouLosePage extends StatelessWidget {
  final GameFinalViewModel viewModel;
  const YouLosePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${viewModel.loserUserScore} - ${viewModel.winnerUserScore}",
            style: TextConsts.instance.regularWhite70Bold,
          ),
          viewModel.duelData.itemName != "Ödülsüz"
              ? Padding(
                  padding: PaddingConsts.instance.all20,
                  child: Text(
                    "KAYBETTİNİZ: ${viewModel.duelData.itemName} x${viewModel.duelData.itemCount}",
                    style: TextConsts.instance.regularWhite25Bold,
                  ),
                )
              : Text(
                  "KAYBETTİNİZ :(",
                  style: TextConsts.instance.regularWhite25Bold,
                ),
          CustomButton(
            onPressed: () => viewModel.duelData.itemName != "Ödülsüz"
                ? viewModel.navigateToPaymentPage()
                : viewModel.navigateToMainPage(),
            style: TextConsts.instance.regularBlack18Bold,
            text: "Devam et",
            width: 200,
            height: 50,
          )
        ],
      ),
    );
  }
}
