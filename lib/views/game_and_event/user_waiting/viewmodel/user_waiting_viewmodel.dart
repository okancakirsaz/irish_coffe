import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import 'package:irish_coffe/views/game_and_event/enums/game_pages.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/mock_game/view/mock_game_view.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../main/view/main_view.dart';
import '../../game_starting/view/game_starting_view.dart';

part 'user_waiting_viewmodel.g.dart';

class UserWaitingViewModel = _UserWaitingViewModelBase
    with _$UserWaitingViewModel;

abstract class _UserWaitingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await _setUserInGameValue();
    _listenIsGameInviteAcceptedStatement();
    _listenGameStartedEvent();
  }

  late final DuelInviteModel duelData;

  initDuelData(DuelInviteModel data) {
    duelData = data;
  }

  Future<void> _setUserInGameValue() async {
    await localeManager.setBoolData(LocaleKeysEnums.isUserInTheGame.name, true);
    await localeManager.setStringData(
        LocaleKeysEnums.gamePage.name, GamePages.WAITING_USER.name);
    await localeManager.setJsonData(
        LocaleKeysEnums.duelData.name, duelData.toJson());
  }

  Future<void> onTimeOut() async {
    await localeManager.removeData(LocaleKeysEnums.isUserInTheGame.name);
    _navigateToMainPage();
  }

  _navigateToMainPage() {
    //TODO: Use navigation manager
    Navigator.pushAndRemoveUntil(
        viewModelContext,
        CupertinoPageRoute(builder: (context) => const MainView()),
        (route) => false);
  }

  _listenIsGameInviteAcceptedStatement() {
    final String userId =
        localeManager.getStringData(LocaleKeysEnums.userId.name);
    WebSocketManager.instance.webSocketReceiver("Duel Response:$userId",
        (data) async {
      if (data != null) {
        DuelInviteModel dataAsModel = DuelInviteModel.fromJson(data);
        switch (dataAsModel.isAccepted) {
          case true:
            _navigateToGamePage();
            break;
          case false:
            await localeManager
                .removeData(LocaleKeysEnums.isUserInTheGame.name);
            _navigateToMainPage();
            Fluttertoast.showToast(msg: "Kullanıcı davetini reddetti.");
            break;
        }
      }
    });
  }

  _navigateToGamePage() {
    //TODO: Use navigation manager
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      CupertinoPageRoute(
          builder: (context) => GameStartingView(
                duel: duelData,
              )),
      (route) => false,
    );
  }

  _listenGameStartedEvent() {
    WebSocketManager.instance.webSocketReceiver(duelData.gameId, (data) {
      if (data != null) {
        //TODO: Navigate to selected game page
        Navigator.pushAndRemoveUntil(
          viewModelContext,
          CupertinoPageRoute(
              builder: (context) => MockGameView(
                    duelData: duelData,
                  )),
          (route) => false,
        );
      }
    });
  }
}
