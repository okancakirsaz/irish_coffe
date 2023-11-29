import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/service/mock_services/menu_mock_services.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';
import 'package:irish_coffe/views/menu/views/menu_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'menu_viewmodel.g.dart';

class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  int selectedItemCount = 1;

  @observable
  ObservableList basket = ObservableList.of([]);

  final MenuMockServices service = MenuMockServices();

  Future<List<MenuItemModel>> getMenu() async {
    final List<MenuItemModel> response = await service.getMenu();
    return response;
  }

  @action
  incrementSelectedItemCount() {
    if (selectedItemCount <= 9) {
      selectedItemCount += 1;
    }
  }

  @action
  decramentSelectedItemCount() {
    if (selectedItemCount >= 2) {
      selectedItemCount -= 1;
    }
  }

  addElementToBasket(MenuItemModel addedElement) {
    basket.add({"element": addedElement, "count": selectedItemCount});
    selectedItemCount = 1;
    Navigator.pop(viewModelContext);
  }

  @action
  deleteElementFromBasket(int index) {
    basket.removeAt(index);
  }

  navigateToBasket(MenuViewModel viewModel) {
    //TODO: use navigation manager
    Navigator.push(viewModelContext,
        CupertinoPageRoute(builder: (context) => Basket(viewModel: viewModel)));
  }
}
