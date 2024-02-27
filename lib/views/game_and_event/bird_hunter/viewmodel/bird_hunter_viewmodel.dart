import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/views/game_and_event/bird_hunter/view/components/bird_view.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/managers/choose_winner_manager.dart';

import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'bird_hunter_viewmodel.g.dart';

class BirdHunterViewModel = _BirdHunterViewModelBase with _$BirdHunterViewModel;

abstract class _BirdHunterViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await removeGameDataCache();
  }

  initDuelData(DuelInviteModel data) => _duelData = data;

  late final DuelInviteModel _duelData;
  ChooseWinnerManager get winnerManager => ChooseWinnerManager(_duelData);

  @observable
  double birdScale = 0.5;

  @observable
  double birdAngle = 0;

  @observable
  Widget bird = const SizedBox();

  @observable
  Alignment? birdAlignment;

  @observable
  int score = 0;

  @action
  createRandomParrotPosition() {
    List<Alignment> positionList = [
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
      Alignment.topCenter,
      Alignment.topLeft,
      Alignment.topRight,
    ];
    positionList.shuffle();
    birdAlignment = positionList[0];
  }

  Future<void> scaleIncrementLoop(BirdHunterViewModel viewModel) async {
    for (int i = 0; i <= 2; i++) {
      await Future.delayed(
        const Duration(milliseconds: 400),
      );
      reScaleBird(viewModel);
    }
  }

  @action
  reScaleBird(BirdHunterViewModel viewModel) {
    switch (birdScale) {
      case 0.5:
        birdScale = 1;
        break;

      case 1:
        birdScale = 1.5;
        break;

      case 1.5:
        birdScale = 0.5;
        birdAngle = 0;
        fetchBird(viewModel);
        break;
    }
  }

  fetchBird(BirdHunterViewModel viewModel) {
    bird = BirdView(viewModel: viewModel);
  }

  @action
  shootTheBird(BirdHunterViewModel viewModel) {
    if (birdScale != 1.5) {
      score++;
      birdAngle = 180;
    }
  }

  Future<void> onGameFinish() async {
    await winnerManager.setGameFinalData(
        score, winnerManager.isUserChallenger(), viewModelContext);
  }
}
