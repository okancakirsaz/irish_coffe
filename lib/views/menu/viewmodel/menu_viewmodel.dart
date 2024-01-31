import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/menu/models/bucket_verification_request_model.dart';
import 'package:irish_coffe/views/menu/models/bucket_verification_response_model.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';
import 'package:irish_coffe/views/menu/services/menu_services.dart';
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

  final MenuServices service = MenuServices();

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
    int response = int.parse(price) * basket[index]["count"] as int;
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

  Future<void> bucketVerification() async {
    if (basket.isEmpty) {
      Fluttertoast.showToast(msg: "Önce sepete bir şeyler eklemelisiniz.");
    } else {
      final BucketVerificationResponseModel? response = await _checkBucket();
      await _handleBucketResponse(response);
    }
  }

  List<String> _separateSelectedElementsName() {
    List<String> nameList = [];
    for (int i = 0; i <= basket.length - 1; i++) {
      nameList.add(basket[i]["element"].name);
    }
    return nameList;
  }

  Future<BucketVerificationResponseModel?> _checkBucket() async {
    return await service.bucketVerification(
      BucketVerificationRequestModel(
        idList: _separateSelectedElementsName(),
      ),
    );
  }

  Future<void> _handleBucketResponse(
      BucketVerificationResponseModel? response) async {
    if (response == null) {
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz");
    } else {
      if (response.isAllValid) {
        await localeManager.setJsonData(
            LocaleKeysEnums.orderedFoods.name, _separateSelectedElementsName());
        _navigateToPayment();
      } else {
        Fluttertoast.showToast(msg: response.errorMessage!);
        await getMenu();
        _navigateToMenu();
      }
    }
  }

  _navigateToPayment() {
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

  _navigateToMenu() {
    //TODO: use navigation manager
    Navigator.push(
      viewModelContext,
      CupertinoPageRoute(
        builder: (context) => const MenuView(),
      ),
    );
  }
}
