import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_snake/flutter_snake.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/snake_game/viewmodel/snake_game_viewmodel.dart';

class SnakeGameView extends StatelessWidget {
  final DuelInviteModel duelData;
  const SnakeGameView({super.key, required this.duelData});

  @override
  Widget build(BuildContext context) {
    return BaseView<SnakeGameViewModel>(
        viewModel: SnakeGameViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Yılan Ve Yonca",
                  style: TextConsts.instance.regularBlack25Bold,
                ),
                actions: [
                  Padding(
                    padding: PaddingConsts.instance.all10,
                    child: buildTimer(model),
                  )
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: PaddingConsts.instance.all20,
                    child: scoreCounter(model),
                  ),
                  Center(child: model.snakeGameWidget),
                  const SizedBox(height: 40),
                  buildControllers(model),
                ],
              ));
        },
        onModelReady: (model) {
          model.setContext(context);
          model.initDuelData(duelData);
          model.init();
        },
        onDispose: () {});
  }

  Widget buildControllers(SnakeGameViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        controllerButton(
            () => model.changeSnakeState(SNAKE_MOVE.right), Icons.arrow_left),
        const SizedBox(width: 40),
        controllerButton(
            () => model.changeSnakeState(SNAKE_MOVE.left), Icons.arrow_right),
      ],
    );
  }

  Widget controllerButton(VoidCallback onPressed, IconData icon) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConsts.instance.green,
        ),
        child: Icon(
          icon,
          size: 60,
          color: ColorConsts.instance.lightGray,
        ));
  }

  Widget buildTimer(SnakeGameViewModel model) {
    return CircularCountDownTimer(
      width: 70,
      height: 70,
      duration: 30,
      isReverse: true,
      strokeWidth: 7,
      strokeCap: StrokeCap.round,
      fillColor: ColorConsts.instance.green,
      ringColor: ColorConsts.instance.lightGray,
      onComplete: () async => await model.onTimerCompleted(),
    );
  }

  Widget scoreCounter(SnakeGameViewModel model) {
    return Observer(builder: (context) {
      return Text(
        "Skor: ${model.score}",
        style: TextConsts.instance.regularBlack25Bold,
      );
    });
  }
}
