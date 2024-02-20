import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/game_and_event/enums/game_pages.dart';
import 'package:irish_coffe/views/game_and_event/game_starting/service/game_starting_service.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';
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
    await _createGameRoom();
  }

  late DuelInviteModel duelData;
  final GameStartingService service = GameStartingService();

  void setDuelData(DuelInviteModel data) {
    duelData = data;
  }

  Future<void> _createGameRoom() async {
    if (duelData.challengerUserId ==
        localeManager.getStringData(LocaleKeysEnums.userId.name)) {
      await service.createGameRoom(
        GameRoomModel(
          challengerUserId: duelData.challengerUserId,
          challengerUserName: duelData.challengerUserName,
          challengerUserScore: null,
          challengedUserId: duelData.challengedUserId,
          challengedUserName: duelData.challengedUserName,
          challengedUserScore: null,
          gameId: duelData.gameId,
        ),
      );
    }
  }

  Future<void> _setUserInGameValue() async {
    await localeManager.setBoolData(LocaleKeysEnums.isUserInTheGame.name, true);
    await localeManager.setStringData(
        LocaleKeysEnums.gamePage.name, GamePages.GAME_LOBBY.name);
    await localeManager.setJsonData(
        LocaleKeysEnums.duelData.name, duelData.toJson());
  }

  //TODO: Make real game seperator
  navigateToGame() {
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
