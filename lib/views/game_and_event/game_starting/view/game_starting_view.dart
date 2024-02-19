import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/views/game_and_event/game_starting/viewmodel/game_starting_viewmodel.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';

class GameStartingView extends StatelessWidget {
  final DuelInviteModel duel;
  const GameStartingView({super.key, required this.duel});

  @override
  Widget build(BuildContext context) {
    return BaseView<GameStartingViewModel>(
        viewModel: GameStartingViewModel(),
        onPageBuilder: (context, model) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  ColorConsts.instance.green,
                  ColorConsts.instance.orange
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "Oyun başlıyor: ${duel.gameName}",
                  style: TextConsts.instance.regularWhite25Bold,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[buildAwardText(), buildCounter(model)],
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
          model.setDuelData(duel);
        },
        onDispose: () {});
  }

  Widget buildAwardText() {
    return Center(
      child: Text(
        "Ödül: ${duel.itemName} ${duel.itemName == "Ödülsüz" ? "" : "x${duel.itemCount}"}",
        style: TextConsts.instance.regularWhite20,
      ),
    );
  }

  Widget buildCounter(GameStartingViewModel model) {
    return Observer(builder: (context) {
      return Text(
        "${model.counterText}",
        style: TextConsts.instance.regularWhite70Bold,
      );
    });
  }
}
