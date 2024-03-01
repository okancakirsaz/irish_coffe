import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/quiz/viewmodel/quiz_game_viewmodel.dart';
import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/text_consts.dart';

class QuizGameView extends StatelessWidget {
  final DuelInviteModel duelData;
  const QuizGameView({super.key, required this.duelData});

  @override
  Widget build(BuildContext context) {
    return BaseView<QuizGameViewModel>(
      viewModel: QuizGameViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.initDuelData(duelData);
        model.init();
      },
      onDispose: () {},
      onPageBuilder: (context, model) {
        return Scaffold(
          backgroundColor: ColorConsts.instance.lightGray,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 70,
            title: Text(
              "Bilgi Yarışması",
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
            children: <Widget>[
              Observer(builder: (context) {
                return Text(
                  "Skor: ${model.score}",
                  style: TextConsts.instance.regularBlack25Bold,
                );
              }),
              const SizedBox(height: 20),
              buildQuestionArea(model),
              buildOptionsArea(model)
            ],
          ),
        );
      },
    );
  }

  Widget buildTimer(QuizGameViewModel model) {
    return CircularCountDownTimer(
      width: 70,
      height: 70,
      duration: 60,
      isReverse: true,
      strokeWidth: 7,
      strokeCap: StrokeCap.round,
      fillColor: ColorConsts.instance.orange,
      ringColor: ColorConsts.instance.darkGrey,
      onComplete: () async => await model.onTimerCompleted(),
    );
  }

  Widget buildQuestionArea(QuizGameViewModel model) {
    return Observer(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Card(
          margin: PaddingConsts.instance.all10,
          color: ColorConsts.instance.orange,
          child: Padding(
            padding: PaddingConsts.instance.all10,
            child: Text(
              model.currentQuestion,
              style: TextConsts.instance.regularWhite20Bold,
            ),
          ),
        ),
      );
    });
  }

  Widget buildOptionsArea(QuizGameViewModel model) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: buildOptionButton(
                model,
                0,
              ),
            ),
            Expanded(
              child: buildOptionButton(
                model,
                1,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: buildOptionButton(model, 2),
            ),
            Expanded(
              child: buildOptionButton(
                model,
                3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildOptionButton(QuizGameViewModel model, int index) {
    return Observer(builder: (context) {
      return InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: () async =>
            await model.checkQuestionIsTrue(model.currentOptions[index], index),
        child: Container(
          margin: PaddingConsts.instance.all10,
          padding: PaddingConsts.instance.all20,
          decoration: BoxDecoration(
            color: model.colorList[index],
            borderRadius: RadiusConsts.instance.circularAll10,
          ),
          child: Text(
            model.currentOptions[index],
            style: TextConsts.instance.regularWhite16Bold,
          ),
        ),
      );
    });
  }
}
