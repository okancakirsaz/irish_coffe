import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/service/mock_services/menu_mock_services.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';
import 'package:irish_coffe/views/menu/views/menu_view.dart';
import 'package:irish_coffe/views/payment/view/payment_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'menu_viewmodel.g.dart';

class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    await getAllMenuFirstInit();
  }

  @observable
  int selectedItemCount = 1;

  @observable
  ObservableList basket = ObservableList.of([]);
  @observable
  ObservableList<MenuItemModel> allMenu = ObservableList<MenuItemModel>.of([]);
  List<int> selectedItemsPrices = [];

  @observable
  bool isLoadSuccessful = false;

  //TODO: Change to real services
  final MenuMockServices service = MenuMockServices();

  @action
  Future<void> getMenu() async {
    try {
      final List<MenuItemModel>? response = await service.getAllMenu();
      await localeManager.setJsonData(LocaleKeysEnums.menu.name, response);
      allMenu = getCachedMenuAsModel();
    } catch (e) {
      debugPrint("$e");
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz.");
    }
  }

  @action
  Future<void> getAllMenuFirstInit() async {
    if (localeManager.getNullableJsonData(LocaleKeysEnums.menu.name) == null) {
      await getMenu();
    } else {
      //Already in cache
      allMenu = getCachedMenuAsModel();
    }
    isLoadSuccessful = true;
  }

  ObservableList<MenuItemModel> getCachedMenuAsModel() {
    List<dynamic> cachedList =
        localeManager.getJsonData(LocaleKeysEnums.menu.name);
    ObservableList<MenuItemModel> convertedList =
        ObservableList<MenuItemModel>.of([]);
    for (var element in cachedList) {
      convertedList.add(MenuItemModel.fromJson(element));
    }
    return convertedList;
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

  int calculateElementPrice(int index) {
    String price = basket[index]["element"].price!;
    int response = int.parse(price.substring(0, price.length - 1)) *
        basket[index]["count"] as int;
    selectedItemsPrices.add(response);
    return response;
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

  navigateToPayment() {
    if (basket.isEmpty) {
      Fluttertoast.showToast(msg: "Önce sepete bir şeyler eklemelisiniz.");
    } else {
      //TODO: use navigation manager
      Navigator.push(
        viewModelContext,
        CupertinoPageRoute(
          builder: (context) => PaymentView(
            priceList: selectedItemsPrices,
          ),
        ),
      );
    }
  }
}
