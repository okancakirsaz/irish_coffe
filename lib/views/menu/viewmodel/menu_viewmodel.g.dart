// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuViewModel on _MenuViewModelBase, Store {
  late final _$selectedItemCountAtom =
      Atom(name: '_MenuViewModelBase.selectedItemCount', context: context);

  @override
  int get selectedItemCount {
    _$selectedItemCountAtom.reportRead();
    return super.selectedItemCount;
  }

  @override
  set selectedItemCount(int value) {
    _$selectedItemCountAtom.reportWrite(value, super.selectedItemCount, () {
      super.selectedItemCount = value;
    });
  }

  late final _$basketAtom =
      Atom(name: '_MenuViewModelBase.basket', context: context);

  @override
  ObservableList<dynamic> get basket {
    _$basketAtom.reportRead();
    return super.basket;
  }

  @override
  set basket(ObservableList<dynamic> value) {
    _$basketAtom.reportWrite(value, super.basket, () {
      super.basket = value;
    });
  }

  late final _$allMenuAtom =
      Atom(name: '_MenuViewModelBase.allMenu', context: context);

  @override
  ObservableList<MenuItemModel> get allMenu {
    _$allMenuAtom.reportRead();
    return super.allMenu;
  }

  @override
  set allMenu(ObservableList<MenuItemModel> value) {
    _$allMenuAtom.reportWrite(value, super.allMenu, () {
      super.allMenu = value;
    });
  }

  late final _$isLoadSuccessfulAtom =
      Atom(name: '_MenuViewModelBase.isLoadSuccessful', context: context);

  @override
  bool get isLoadSuccessful {
    _$isLoadSuccessfulAtom.reportRead();
    return super.isLoadSuccessful;
  }

  @override
  set isLoadSuccessful(bool value) {
    _$isLoadSuccessfulAtom.reportWrite(value, super.isLoadSuccessful, () {
      super.isLoadSuccessful = value;
    });
  }

  late final _$getMenuAsyncAction =
      AsyncAction('_MenuViewModelBase.getMenu', context: context);

  @override
  Future<void> getMenu() {
    return _$getMenuAsyncAction.run(() => super.getMenu());
  }

  late final _$getAllMenuFirstInitAsyncAction =
      AsyncAction('_MenuViewModelBase.getAllMenuFirstInit', context: context);

  @override
  Future<void> getAllMenuFirstInit() {
    return _$getAllMenuFirstInitAsyncAction
        .run(() => super.getAllMenuFirstInit());
  }

  late final _$_MenuViewModelBaseActionController =
      ActionController(name: '_MenuViewModelBase', context: context);

  @override
  dynamic incrementSelectedItemCount() {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.incrementSelectedItemCount');
    try {
      return super.incrementSelectedItemCount();
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decramentSelectedItemCount() {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.decramentSelectedItemCount');
    try {
      return super.decramentSelectedItemCount();
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteElementFromBasket(int index) {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.deleteElementFromBasket');
    try {
      return super.deleteElementFromBasket(index);
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedItemCount: ${selectedItemCount},
basket: ${basket},
allMenu: ${allMenu},
isLoadSuccessful: ${isLoadSuccessful}
    ''';
  }
}
