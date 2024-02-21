import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/widgets/are_you_sure_dialog.dart';
import 'package:irish_coffe/views/community/view/community_view.dart';
import 'package:irish_coffe/views/game_and_event/enums/game_pages.dart';
import 'package:irish_coffe/views/game_and_event/game_starting/view/game_starting_view.dart';
import 'package:irish_coffe/views/game_and_event/user_waiting/view/user_waiting_view.dart';
import 'package:irish_coffe/views/menu/views/menu_view.dart';
import 'package:irish_coffe/views/profile/view/profile_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/consts/color_consts/color_consts.dart';
import '../../../core/consts/text_consts.dart';
import '../../../core/public_managers/log_out_manager.dart';
import '../../../core/public_managers/websocket_manager.dart';
import '../../authantication/landing_view/services/landing_services.dart';
import '../../game_and_event/games/models/duel_invite_model.dart';
import '../../game_and_event/games/view/games_view.dart';
import '../../profile/models/boolean_single_response_model.dart';
import '../../profile/models/user_id_send_request_model.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
    mainPageContext = context;
  }

  @override
  init() async {
    await deleteCachedValues();
    await isUserPassedBanSystem();
    WebSocketManager.instance.initializeSocketConnection();
    _checkIsUserInGame();
    listenIsUserBanned();
    listenEventsState();
    listenDuelInviteStatement();
  }

  Future<void> deleteCachedValues() async {
    await localeManager.removeData(LocaleKeysEnums.posts.name);
    await localeManager.removeData(LocaleKeysEnums.customers.name);
    await localeManager.removeData(LocaleKeysEnums.menu.name);
  }

  @observable
  ObservableList<Widget> pages = ObservableList.of(<Widget>[
    const CommunityView(),
    const MenuView(),
    const GamesView(),
    const ProfileView(),
  ]);
  LogOutManager get logOutManager => LogOutManager(mainPageContext);
  late BuildContext mainPageContext;
  //TODO: Move funcs to main services
  final LandingServices services = LandingServices();

  @action
  Widget changePage(int index) {
    return pages[index];
  }

  listenIsUserBanned() {
    WebSocketManager.instance.webSocketReceiver("user_banned", (data) async {
      if (data != null &&
          data ==
              localeManager
                  .getNullableStringData(LocaleKeysEnums.userId.name)) {
        await showDialog(
            context: mainPageContext,
            builder: (context) => AlertDialog(
                  backgroundColor: ColorConsts.instance.darkGrey,
                  content: Text(
                    "Topluluk kurallarımıza aykırı davranışlarınız nedeniyle uygulamadan süresiz olarak uzaklaştırıldınız.",
                    style: TextConsts.instance.regularWhite16Bold,
                  ),
                ));
        //Close app
        await logOutManager.logOut();
        exit(0);
      }
    });
  }

  Future<void> isUserPassedBanSystem() async {
    String? userId =
        localeManager.getNullableStringData(LocaleKeysEnums.userId.name);
    if (userId != null) {
      bool isUserBanned = await _checkIsUserBanned(userId);
      if (!isUserBanned) {
        await logOutManager.logOut();
      }
    }
  }

  Future<bool> _checkIsUserBanned(String userId) async {
    final BooleanSingleResponseModel? response =
        await services.checkIsUserBanned(UserIdSendRequestModel(uid: userId));

    if (response != null) {
      //if isSuccess false user got banned
      return response.isSuccess!;
    } else {
      return false;
    }
  }

  listenEventsState() {
    WebSocketManager.instance.webSocketReceiver("event_started", (data) async {
      if (data != null) {
        Fluttertoast.showToast(
            msg: data, backgroundColor: ColorConsts.instance.orange);
      }
    });
  }

  listenDuelInviteStatement() {
    //All users have unique channel
    String userId = localeManager.getStringData(LocaleKeysEnums.userId.name);
    WebSocketManager.instance.webSocketReceiver("Duel Invite:$userId",
        (data) async {
      if (data != null) {
        _handleUserInvitedToDuel(data);
      }
    });
  }

  Future<void> _handleUserInvitedToDuel(dynamic data) async {
    bool isPressedAnyButton = false;
    DuelInviteModel dataAsModel = DuelInviteModel.fromJson(data);
    showDialog(
      context: mainPageContext,
      builder: (context) => AreYouSure(
        onPressed: () {
          isPressedAnyButton = true;
          _responseDuelInvite(dataAsModel, true);
        },
        onCancelPressed: () {
          isPressedAnyButton = true;
          _responseDuelInvite(dataAsModel, false);
          navigatorPop();
        },
        height: 240,
        question:
            '''${dataAsModel.challengerUserName} seni ${dataAsModel.gameName} oyununa davet etti. Katılmak ister misin? Ödül: ${dataAsModel.itemName} ${dataAsModel.itemName == "Ödülsüz" ? "" : "x${dataAsModel.itemCount}"}''',
      ),
    );
    Timer(const Duration(minutes: 1), () {
      if (!isPressedAnyButton) {
        navigatorPop();
      }
    });
  }

  _responseDuelInvite(DuelInviteModel data, bool isAccepted) {
    data.isAccepted = isAccepted;
    WebSocketManager.instance.websSocketEmitter("duel_response", data.toJson());
    if (isAccepted) {
      _navigateToGamePage(data);
    }
  }

  _navigateToGamePage(DuelInviteModel data) {
    //TODO:Use navigation manager.
    Navigator.pushAndRemoveUntil(
        mainPageContext,
        CupertinoPageRoute(builder: (context) => GameStartingView(duel: data)),
        (route) => false);
  }

  _checkIsUserInGame() {
    final bool? isUserAtGame =
        localeManager.getNullableBoolData(LocaleKeysEnums.isUserInTheGame.name);
    if (isUserAtGame != null && isUserAtGame) {
      final String gamePage =
          localeManager.getStringData(LocaleKeysEnums.gamePage.name);
      _sendUserToGamePage(gamePage);
    }
  }

  _sendUserToGamePage(String gamePage) {
    //TODO: Use navigation manager
    final DuelInviteModel cachedDuelData = DuelInviteModel.fromJson(
        localeManager.getJsonData(LocaleKeysEnums.duelData.name));
    if (gamePage == GamePages.GAME_LOBBY.name) {
      _navigateToGamePage(cachedDuelData);
    }

    if (gamePage == GamePages.WAITING_USER.name) {
      Navigator.pushAndRemoveUntil(
          mainPageContext,
          CupertinoPageRoute(
            builder: (context) => UserWaitingView(
              duel: cachedDuelData,
            ),
          ),
          (route) => false);
    }
  }
}
