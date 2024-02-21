// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/cache/local_manager.dart';
import 'package:irish_coffe/views/game_and_event/game_final/view/game_final_view.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';
import 'package:irish_coffe/views/game_and_event/public_services/game_and_event_public_service.dart';
import 'package:irish_coffe/views/main/view/main_view.dart';

final class ChooseWinnerManager {
  DuelInviteModel duelData;
  ChooseWinnerManager(this.duelData);

  final GameAndEventPublicService service = GameAndEventPublicService();
  int _challengerScore = 0;
  int _challengedScore = 0;

  bool isUserChallenger() {
    if (duelData.challengerUserId ==
        LocaleManager.instance.getStringData(LocaleKeysEnums.userId.name)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setGameFinalData(
      int score, bool isChallenger, BuildContext context) async {
    GameRoomModel reqModel = _getRequestModel(score, isChallenger);
    final GameRoomModel? response = await service.setGameRoom(
      reqModel,
      isChallenger
          ? AppConst.instance.updateGameRoomChallenger
          : AppConst.instance.updateGameRoomChallenged,
    );
    if (response != null) {
      await _whoWonTheGame(context);
    } else {
      _navigateToMainPage(context);
      Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu.");
    }
  }

  GameRoomModel _getRequestModel(int score, bool isChallenger) {
    return GameRoomModel(
      challengerUserId: duelData.challengerUserId,
      challengerUserName: duelData.challengerUserName,
      challengerUserScore: isChallenger ? score : 0,
      challengedUserId: duelData.challengedUserId,
      challengedUserName: duelData.challengedUserName,
      challengedUserScore: !isChallenger ? score : 0,
      gameId: duelData.gameId,
    );
  }

  Future<void> _whoWonTheGame(BuildContext context) async {
    final GameRoomModel? response = await service.getGameRoom(duelData);
    if (response != null) {
      _navigateToFinalPage(context, response);
      _challengedScore = response.challengedUserScore;
      _challengerScore = response.challengerUserScore;
      _chooseWinner();
    } else {
      _navigateToMainPage(context);
      Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu.");
    }
  }

  _chooseWinner() {
    if (_challengerScore > _challengedScore) {
      Fluttertoast.showToast(msg: "Kazanan: ${duelData.challengerUserName}");
    } else if (_challengerScore == _challengedScore) {
      Fluttertoast.showToast(msg: "Berabere");
    } else {
      Fluttertoast.showToast(msg: "Kazanan: ${duelData.challengedUserName}");
    }
  }

  //TODO: Use navigation manager
  _navigateToFinalPage(BuildContext context, GameRoomModel data) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                GameFinalView(roomData: data, duelData: duelData)),
        (route) => false);
  }

  //TODO: Use navigation manager
  _navigateToMainPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const MainView()),
        (route) => false);
  }
}
