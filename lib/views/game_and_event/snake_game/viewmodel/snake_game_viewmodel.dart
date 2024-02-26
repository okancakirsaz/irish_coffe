import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_snake/flutter_snake.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/managers/choose_winner_manager.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../../core/consts/color_consts/color_consts.dart';

part 'snake_game_viewmodel.g.dart';

class SnakeGameViewModel = _SnakeGameViewModelBase with _$SnakeGameViewModel;

abstract class _SnakeGameViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    snakeController = StreamController<GAME_EVENT>();
    snakeGameWidget = SnakeGame(
      caseWidth: 28,
      numberCaseHorizontally: 13,
      numberCaseVertically: 13,
      controllerEvent: snakeController,
      durationBetweenTicks: const Duration(milliseconds: 400),
      colorBackground1: ColorConsts.instance.orange,
      colorBackground2: ColorConsts.instance.orange,
      snakeBodyImgPath: AssetConsts.instance.snakeBody,
      snakeBodyTurnImgPath: AssetConsts.instance.snakeTurn,
      snakeHeadImgPath: AssetConsts.instance.snakeHead,
      snakeTailImgPath: AssetConsts.instance.snakeTail,
      snakeFruitImgPath: AssetConsts.instance.snakeEat,
    );
    await removeGameDataCache();
    listenGameEvent();
  }

  initDuelData(DuelInviteModel data) => _duelData = data;

  late final DuelInviteModel _duelData;
  ChooseWinnerManager get winnerManager => ChooseWinnerManager(_duelData);
  late final StreamController<GAME_EVENT> snakeController;
  @observable
  int score = 0;

  late final SnakeGame snakeGameWidget;

  changeSnakeState(SNAKE_MOVE move) {
    snakeGameWidget.nextDirection = move;
  }

  @action
  _incrementScore() {
    score++;
  }

  listenGameEvent() {
    snakeController.stream.listen((GAME_EVENT event) {
      switch (event) {
        case GAME_EVENT.food_eaten:
          _incrementScore();
          break;
        default:
          _showYouLoseDialog();
      }
    });
  }

  _showYouLoseDialog() {
    showDialog(
        barrierDismissible: false,
        context: viewModelContext,
        builder: (context) {
          return Dialog(
              backgroundColor: ColorConsts.instance.green,
              child: SizedBox(
                width: 300,
                height: 200,
                child: Center(
                  child: ListTile(
                    title: Text(
                      "Ups! :(",
                      style: TextConsts.instance.regularWhite25Bold,
                    ),
                    subtitle: Text(
                      "Süre bitene kadar beklemelisin.",
                      style: TextConsts.instance.regularWhite20,
                    ),
                  ),
                ),
              ));
        });
  }

  Future<void> onTimerCompleted() async {
    await winnerManager.setGameFinalData(
        score, winnerManager.isUserChallenger(), viewModelContext);
  }
}
