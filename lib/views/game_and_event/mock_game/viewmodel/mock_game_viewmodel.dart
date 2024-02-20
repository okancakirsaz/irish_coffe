// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/managers/choose_winner_manager.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'mock_game_viewmodel.g.dart';

class MockGameViewModel = _MockGameViewModelBase with _$MockGameViewModel;

abstract class _MockGameViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await _removeCache();
    await setTimer();
  }

  @observable
  int score = 0;
  late final DuelInviteModel duelData;
  @observable
  int timerSeconds = 5;

  ChooseWinnerManager get winnerManager => ChooseWinnerManager(duelData);

  Future<void> _removeCache() async {
    await localeManager.removeData(LocaleKeysEnums.isUserInTheGame.name);
    await localeManager.removeData(LocaleKeysEnums.duelData.name);
    await localeManager.removeData(LocaleKeysEnums.gamePage.name);
  }

  initDuelData(DuelInviteModel data) => duelData = data;

  @action
  incrementScore() {
    score++;
  }

  @action
  Future<void> setTimer() async {
    //winnerManager.listenIsGameRoomDone(viewModelContext);
    for (timerSeconds; timerSeconds >= 1; timerSeconds--) {
      await Future.delayed(const Duration(seconds: 1));
    }

    await winnerManager.setGameFinalData(
        score, winnerManager.isUserChallenger(), viewModelContext);
  }
}
