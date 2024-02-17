// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GamesViewModel on _GamesViewModelBase, Store {
  late final _$selectedItemCountAtom =
      Atom(name: '_GamesViewModelBase.selectedItemCount', context: context);

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

  late final _$_GamesViewModelBaseActionController =
      ActionController(name: '_GamesViewModelBase', context: context);

  @override
  dynamic incrementSelectedItemCount() {
    final _$actionInfo = _$_GamesViewModelBaseActionController.startAction(
        name: '_GamesViewModelBase.incrementSelectedItemCount');
    try {
      return super.incrementSelectedItemCount();
    } finally {
      _$_GamesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decrementSelectedItemCount() {
    final _$actionInfo = _$_GamesViewModelBaseActionController.startAction(
        name: '_GamesViewModelBase.decrementSelectedItemCount');
    try {
      return super.decrementSelectedItemCount();
    } finally {
      _$_GamesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedItemCount: ${selectedItemCount}
    ''';
  }
}
