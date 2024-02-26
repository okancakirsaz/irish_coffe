import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import 'package:irish_coffe/views/game_and_event/enums/game_pages.dart';
import 'package:irish_coffe/views/game_and_event/game_starting/service/game_starting_service.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';
import 'package:irish_coffe/views/game_and_event/snake_game/view/snake_game_view.dart';
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
          challengerUserScore: 0,
          challengedUserId: duelData.challengedUserId,
          challengedUserName: duelData.challengedUserName,
          challengedUserScore: 0,
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

  startGame() {
    WebSocketManager.instance.websSocketEmitter("game_started", duelData);
    _gameNameSeparator();
  }

  _gameNameSeparator() {
    switch (duelData.gameName) {
      case "Yılan Oyunu":
        navigateToGame(SnakeGameView(duelData: duelData));
        break;
      //TODO: Remove here
      default:
        navigateToGame(MockGameView(duelData: duelData));
    }
  }

  navigateToGame(Widget page) {
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      CupertinoPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
