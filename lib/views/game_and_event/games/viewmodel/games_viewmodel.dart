import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import 'package:irish_coffe/views/community/models/currently_in_irish_model.dart';
import 'package:irish_coffe/views/community/services/community_services.dart';
import 'package:irish_coffe/views/game_and_event/user_waiting/view/user_waiting_view.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';
import 'package:irish_coffe/views/menu/services/menu_services.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../models/duel_invite_model.dart';
import '../models/event_model.dart';
import '../services/games_services.dart';
import '../view/games_view.dart';

part 'games_viewmodel.g.dart';

class GamesViewModel = _GamesViewModelBase with _$GamesViewModel;

abstract class _GamesViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    if (eventsAsWidget.isEmpty) {
      isEventsFetched = false;
    }
  }

  final PageController pageController = PageController();
  final GamesServices service = GamesServices();
  bool isEventsFetched = false;
  @observable
  int selectedItemCount = 1;
  String get cachedUserName =>
      localeManager.getStringData(LocaleKeysEnums.name.name);
  final TextEditingController selectAwardDialogController =
      TextEditingController(text: "Ödülsüz");
  late final TabController tabController;
  late final DuelInviteModel duelData;
  late final List<CurrentlyInIrishModel>? customers;

  //TODO: Do remove event in overdue logic
  final List<Widget> eventsAsWidget = [];

  navigateToIndexedPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  initializeTabController(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
  }

  whenPageChangedWithHand(int index) {
    tabController.animateTo(index);
  }

  Future<List<EventModel>> getEvents() async {
    final List<EventModel>? response = await service.getActiveEvents();
    return response ?? [];
  }

  Future<List<Widget>> fetchEventsToWidget() async {
    if (!isEventsFetched) {
      final List<EventModel> events = await getEvents();
      fetchPysicalEvents(events);
      fetchVirtualEvents(events);
      isEventsFetched = true;
    }
    return eventsAsWidget;
  }

  fetchPysicalEvents(List<EventModel> events) {
    for (EventModel event in events) {
      if (event.isPysicalEvent!) {
        eventsAsWidget
            .add(EventsElement(name: event.eventName!, time: event.eventTime!));
      }
    }
  }

  fetchVirtualEvents(List<EventModel> events) {
    for (EventModel event in events) {
      if (!event.isPysicalEvent!) {
        switch (event.gameType) {
          case "Bilgi Yarışması":
            eventsAsWidget.add(
              QuizGame(
                onPressed: () {},
                time: event.eventTime,
              ),
            );
            break;
        }
      }
    }
  }

  //Uses in a FutureBuilder at SelectUserPage
  Future<List<CurrentlyInIrishModel>?> getActiveUsers() async {
    customers = await CommunityServices().getWhoInIrishData();
    if (customers == null) {
      //TODO: Move error messages to error consts
      Fluttertoast.showToast(msg: "Bir sorun oluştu. Tekrar deneyiniz");
    }
    return customers;
  }

  navigateToGame(String gameName, GamesViewModel viewModel) {
    Navigator.push(
      viewModelContext,
      CupertinoPageRoute(
        builder: (context) =>
            SelectUserPage(gameName: gameName, viewModel: viewModel),
      ),
    );
  }

  Future<void> showSelectAwardDialog(String gameName, GamesViewModel viewModel,
      CurrentlyInIrishModel targetUser) async {
    await showDialog(
        context: viewModelContext,
        builder: (context) => SelectAwardDialog(
              viewModel: viewModel,
              targetUser: targetUser,
              gameName: gameName,
            ));
  }

  Future<List<DropdownMenuEntry>> fetchMenuItemsInDropdown() async {
    final cachedMenu =
        localeManager.getNullableJsonData(LocaleKeysEnums.menu.name);
    if (cachedMenu == null) {
      return await _fetchMenuItemsFromDb();
    } else {
      return _fetchMenuItemsFromCache(cachedMenu);
    }
  }

  Future<List<DropdownMenuEntry>> _fetchMenuItemsFromDb() async {
    final List<DropdownMenuEntry> dropdownItems = [];
    final List<MenuItemModel>? response = await MenuServices().getAllMenu();
    if (response == null) {
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz.");
    } else {
      for (int i = 0; i <= response.length - 1; i++) {
        dropdownItems.add(DropdownMenuEntry(
            value: response[i].name, label: response[i].name!));
      }
    }
    return dropdownItems;
  }

  Future<List<DropdownMenuEntry>> _fetchMenuItemsFromCache(
      dynamic cachedMenu) async {
    final List<DropdownMenuEntry> dropdownItems = [];
    for (int i = 0; i <= cachedMenu.length - 1; i++) {
      MenuItemModel menuItemAsModel = MenuItemModel.fromJson(cachedMenu[i]);

      dropdownItems.add(DropdownMenuEntry(
          value: menuItemAsModel.name, label: menuItemAsModel.name!));
    }

    return dropdownItems;
  }

  @action
  incrementSelectedItemCount() {
    if (selectedItemCount <= 9) {
      selectedItemCount++;
    }
  }

  @action
  decrementSelectedItemCount() {
    if (selectedItemCount >= 2) {
      selectedItemCount--;
    }
  }

  inviteUserToGame(CurrentlyInIrishModel targetUser, String gameName) {
    if (_checkCurrentUserIsACustomer()) {
      duelData = _getDuelDataModel(gameName, targetUser);
      WebSocketManager.instance.websSocketEmitter("duel_invite", duelData);
      _navigateToWaitPage(duelData);
    } else {
      Fluttertoast.showToast(msg: "Önce sipariş vermelisiniz.");
      //Close dialog
      navigatorPop();
      //Go main page
      navigatorPop();
    }
  }

  bool _checkCurrentUserIsACustomer() {
    bool isCustomer = false;
    for (int i = 0; i <= customers!.length - 1; i++) {
      if (customers![i].uid ==
          localeManager.getStringData(LocaleKeysEnums.userId.name)) {
        isCustomer = true;
      }
    }
    return isCustomer;
  }

  _getDuelDataModel(String gameName, CurrentlyInIrishModel targetUser) {
    return DuelInviteModel(
        gameId: const Uuid().v4(),
        isAccepted: false,
        itemName: selectAwardDialogController.text,
        itemCount: selectedItemCount,
        gameName: gameName,
        challengedUserId: targetUser.uid,
        challengedUserName: targetUser.name,
        challengedUserProfileImage: targetUser.profileImage,
        challengerUserName:
            localeManager.getStringData(LocaleKeysEnums.name.name),
        challengerUserProfileImage: localeManager
            .getNullableStringData(LocaleKeysEnums.profileImage.name),
        challengerUserId:
            localeManager.getStringData(LocaleKeysEnums.userId.name),
        challengedUserGender: targetUser.gender,
        challengerUserGender:
            localeManager.getStringData(LocaleKeysEnums.gender.name));
  }

  _navigateToWaitPage(DuelInviteModel data) {
    //TODO: Use navigation manager
    Navigator.pushAndRemoveUntil(
        viewModelContext,
        CupertinoPageRoute(builder: (context) => UserWaitingView(duel: data)),
        (route) => false);
  }
}
