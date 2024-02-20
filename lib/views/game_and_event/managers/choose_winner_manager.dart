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

  Future<void> setGameFinalData(
      int score, bool isChallenger, BuildContext context) async {
    GameRoomModel reqModel = _getRequestModel(score, isChallenger);
    await service.setGameRoom(
      reqModel,
      isChallenger
          ? AppConst.instance.updateGameRoomChallenger
          : AppConst.instance.updateGameRoomChallenged,
    );
    await _whoWonTheGame(context);
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
    if (response != null) {
      _navigateToFinalPage(context, response);
      if (response.challengedUserScore != null &&
          response.challengerUserScore != null) {
        _challengedScore = response.challengedUserScore!;
        _challengerScore = response.challengerUserScore!;
        _chooseWinner();
      } else {
        Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu.");
      }
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

  //TODO: remove function
  _navigateToFinalPage(BuildContext context, GameRoomModel data) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                GameFinalView(roomData: data, duelData: duelData)),
        (route) => false);
  }
}
