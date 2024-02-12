import 'dart:io';

import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/community/view/community_view.dart';
import 'package:irish_coffe/views/games/view/games_view.dart';
import 'package:irish_coffe/views/menu/views/menu_view.dart';
import 'package:irish_coffe/views/profile/view/profile_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/consts/color_consts/color_consts.dart';
import '../../../core/consts/text_consts.dart';
import '../../../core/public_managers/log_out_manager.dart';
import '../../../core/public_managers/websocket_manager.dart';
import '../../authantication/landing_view/services/landing_services.dart';
import '../../profile/models/boolean_single_response_model.dart';
import '../../profile/models/user_id_send_request_model.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    listenIsUserBanned();
    await deleteCachedValues();
    await isUserPassedBanSystem();
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
  LogOutManager get logOutManager => LogOutManager(viewModelContext);

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
            context: viewModelContext,
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
}
