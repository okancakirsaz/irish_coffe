import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import 'package:irish_coffe/views/game_and_event/enums/game_pages.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../mock_game/view/mock_game_view.dart';

part 'game_starting_viewmodel.g.dart';

class GameStartingViewModel = _GameStartingViewModelBase
    with _$GameStartingViewModel;

abstract class _GameStartingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await _setUserInGameValue();
    await counterFlow();
  }

  late DuelInviteModel duelData;

  void setDuelData(DuelInviteModel data) {
    duelData = data;
  }

  Future<void> _setUserInGameValue() async {
    await localeManager.setBoolData(LocaleKeysEnums.isUserInTheGame.name, true);
    await localeManager.setStringData(
        LocaleKeysEnums.gamePage.name, GamePages.GAME_LOBBY.name);
    await localeManager.setJsonData(
        LocaleKeysEnums.duelData.name, duelData.toJson());
  }

  @observable
  int counterText = 10;

  @action
  Future<void> counterFlow() async {
    for (counterText; counterText >= 1; counterText--) {
      await Future.delayed(const Duration(seconds: 1));
    }
    WebSocketManager.instance
        .websSocketEmitter("game_started", duelData.toJson());
    _navigateToGame();
  }

  //TODO: Make real game seperator
  _navigateToGame() {
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      CupertinoPageRoute(
          builder: (context) => MockGameView(
                duelData: duelData,
              )),
      (route) => false,
    );
  }
}
