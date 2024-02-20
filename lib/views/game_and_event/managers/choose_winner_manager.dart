import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/cache/local_manager.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';
import 'package:irish_coffe/views/game_and_event/public_services/game_and_event_public_service.dart';

import '../../main/view/main_view.dart';

final class ChooseWinnerManager {
  DuelInviteModel duelData;
  ChooseWinnerManager(this.duelData);

  final GameAndEventPublicService service = GameAndEventPublicService();
  late int _challengerScore;
  late int _challengedScore;

  bool isUserChallenger() {
    if (duelData.challengerUserId ==
        LocaleManager.instance.getStringData(LocaleKeysEnums.userId.name)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setGameFinalData(int score, bool isChallenger) async {
    final GameRoomModel? response =
        await service.setGameRoom(_getRequestModel(score, isChallenger));

    if (response == null) {
      Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu.");
    }
  }

  GameRoomModel _getRequestModel(int score, bool isChallenger) {
    return GameRoomModel(
      challengerUserId: duelData.challengerUserId,
      challengerUserName: duelData.challengerUserName,
      challengerUserScore: isChallenger ? score : null,
      challengedUserId: duelData.challengedUserId,
      challengedUserName: duelData.challengedUserName,
      challengedUserScore: !isChallenger ? score : null,
      gameId: duelData.gameId,
    );
  }

  Future<void> _whoWonTheGame(BuildContext context) async {
    final GameRoomModel? response = await service.getGameRoom(duelData);
    if (response != null &&
        response.challengedUserScore != null &&
        response.challengerUserScore != null) {
      _challengedScore = response.challengedUserScore!;
      _challengerScore = response.challengerUserScore!;
      _chooseWinner();
      _navigateToMainPage(context);
    } else {
      Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu.");
    }
  }

  _chooseWinner() {
    if (_challengerScore > _challengedScore) {
      print("Kazanan: ${duelData.challengerUserName}");
    } else if (_challengerScore == _challengedScore) {
      print("Berabere");
    } else {
      print("Kazanan: ${duelData.challengedUserId}");
    }
  }

  //TODO: remove function
  _navigateToMainPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const MainView()),
        (route) => false);
  }

  listenIsGameRoomDone(BuildContext context) {
    WebSocketManager.instance.webSocketReceiver(duelData.gameId, (data) async {
      if (data != null) {
        await _whoWonTheGame(context);
      }
    });
  }

  //TODO: same time request bug,
  //TODO: sender device listen bug
}
