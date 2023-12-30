import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/community/view/community_view.dart';
import 'package:irish_coffe/views/games/view/games_view.dart';
import 'package:irish_coffe/views/menu/views/menu_view.dart';
import 'package:irish_coffe/views/profile/view/profile_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await deleteCachedValues();
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

  @action
  Widget changePage(int index) {
    return pages[index];
  }
}
