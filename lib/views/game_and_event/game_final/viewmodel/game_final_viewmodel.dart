import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/game_and_event/game_final/service/game_final_service.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';
import 'package:irish_coffe/views/main/view/main_view.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';
import 'package:irish_coffe/views/menu/services/menu_services.dart';
import 'package:irish_coffe/views/payment/view/payment_view.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'game_final_viewmodel.g.dart';

class GameFinalViewModel = _GameFinalViewModelBase with _$GameFinalViewModel;

abstract class _GameFinalViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    _checkUserWonTheGame();
    await updateUserScores();
  }

  //TODO: Create order part
  final GameFinalService service = GameFinalService();
  late final GameRoomModel roomData;
  late final DuelInviteModel duelData;
  late final bool isUserWonTheGame;
  late final int winnerUserScore;
  late final int loserUserScore;
  int? totalPrice;

  _checkUserWonTheGame() {
    switch (_checkIsUserChallenger()) {
      case true:
        _challengerUserCheck();
        break;
      case false:
        _challengedUserCheck();
        break;
    }
  }

  _challengedUserCheck() {
    switch (roomData.challengerUserScore > roomData.challengedUserScore) {
      case true:
        isUserWonTheGame = false;
        winnerUserScore = roomData.challengerUserScore;
        loserUserScore = roomData.challengedUserScore;
        break;
      case false:
        isUserWonTheGame = true;
        winnerUserScore = roomData.challengedUserScore;
        loserUserScore = roomData.challengerUserScore;
    }
  }

  _challengerUserCheck() {
    switch (roomData.challengerUserScore > roomData.challengedUserScore) {
      case true:
        isUserWonTheGame = true;
        winnerUserScore = roomData.challengerUserScore;
        loserUserScore = roomData.challengedUserScore;
        break;
      case false:
        isUserWonTheGame = false;
        winnerUserScore = roomData.challengedUserScore;
        loserUserScore = roomData.challengerUserScore;
    }
  }

  bool _checkIsUserChallenger() {
    final String currentUser =
        localeManager.getStringData(LocaleKeysEnums.userId.name);
    if (roomData.challengerUserId == currentUser) {
      return true;
    } else {
      return false;
    }
  }

  String _getWinnerName() {
    bool isChallenger = _checkIsUserChallenger();
    if (isChallenger && isUserWonTheGame) {
      return roomData.challengerUserName;
    } else if (isChallenger && !isUserWonTheGame) {
      return roomData.challengedUserName;
    } else if (!isChallenger && !isUserWonTheGame) {
      return roomData.challengerUserName;
    } else {
      return roomData.challengedUserName;
    }
  }

  initCameData(GameRoomModel room, DuelInviteModel duel) {
    roomData = room;
    duelData = duel;
  }

  navigateToMainPage() {
    //TODO: use navigation manager
    Navigator.pushAndRemoveUntil(
        viewModelContext,
        CupertinoPageRoute(builder: (context) => const MainView()),
        (route) => false);
  }

  _navigateToPaymentPage() {
    //TODO: use navigation manager
    Navigator.pushAndRemoveUntil(
        viewModelContext,
        CupertinoPageRoute(
            builder: (context) => PaymentView(
                  priceList: [totalPrice!],
                )),
        (route) => false);
  }

  Future<void> updateUserScores() async {
    final ScoresModel? response =
        await service.setUserScore(_fetchScoreModel());
    if (response == null) {
      Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu");
    }
  }

  ScoresModel _fetchScoreModel() {
    bool isChallenger = _checkIsUserChallenger();
    return ScoresModel(
      userName: isChallenger
          ? roomData.challengerUserName
          : roomData.challengedUserName,
      userId:
          isChallenger ? roomData.challengerUserId : roomData.challengedUserId,
      challengedUserName: isChallenger
          ? roomData.challengedUserName
          : roomData.challengerUserName,
      isWinned: isUserWonTheGame,
      game: duelData.gameName,
    );
  }

  Future<void> setOrderData() async {
    try {
      await _getMenuItemPrice();

      await localeManager.setStringData(
        LocaleKeysEnums.gameWinner.name,
        _getWinnerName(),
      );

      await localeManager.setJsonData(
        LocaleKeysEnums.orderedFoods.name,
        [
          {"name": duelData.itemName, "count": duelData.itemCount}
        ],
      );
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<void> _getMenuItemPrice() async {
    //Dependency Injection!
    final MenuItemModel? response =
        await MenuServices().getMenuItem(duelData.itemName);
    if (response != null) {
      totalPrice = (int.parse(response.price!) * duelData.itemCount);
    } else {
      Fluttertoast.showToast(msg: "Beklenmedik bir sorun oluştu.");
    }
  }

  Future<void> loserProgress() async {
    await setOrderData();
    if (totalPrice != null) {
      _navigateToPaymentPage();
    }
  }
}
