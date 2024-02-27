import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/views/game_and_event/bird_hunter/viewmodel/bird_hunter_viewmodel.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';

class BirdHunterView extends StatelessWidget {
  final DuelInviteModel duelData;
  const BirdHunterView({super.key, required this.duelData});

  @override
  Widget build(BuildContext context) {
    return BaseView<BirdHunterViewModel>(
        viewModel: BirdHunterViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                buildBackground(),
                Padding(
                  padding: PaddingConsts.instance.top150,
                  child: buildParrotSpawnArea(model),
                ),
                scoreAndTimerBar(model)
              ],
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.initDuelData(duelData);
          model.init();
          model.fetchBird(model);
        },
        onDispose: () {});
  }

  Widget buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        AssetConsts.instance.birdGameBg,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildParrotSpawnArea(BirdHunterViewModel model) {
    return Container(
      margin: PaddingConsts.instance.all10,
      width: double.infinity,
      height: 400,
      child: Observer(builder: (context) {
        return model.bird;
      }),
    );
  }

  Widget scoreAndTimerBar(BirdHunterViewModel model) {
    return SafeArea(
      child: Container(
        margin: PaddingConsts.instance.all20,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Observer(
              builder: (context) => Text(
                "Skor: ${model.score}",
                style: TextConsts.instance.regularBlack20Bold,
              ),
            ),
            buildTimer(model),
          ],
        ),
      ),
    );
  }

  Widget buildTimer(BirdHunterViewModel model) {
    return CircularCountDownTimer(
      width: 50,
      height: 50,
      duration: 30,
      strokeWidth: 7,
      fillColor: ColorConsts.instance.orange,
      ringColor: ColorConsts.instance.darkGrey,
      backgroundColor: ColorConsts.instance.darkGrey,
      textStyle: TextConsts.instance.regularWhite20Bold,
      isReverse: true,
      strokeCap: StrokeCap.round,
      onComplete: () async => await model.onGameFinish(),
    );
  }
}
