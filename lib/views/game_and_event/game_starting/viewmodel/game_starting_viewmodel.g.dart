// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_starting_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameStartingViewModel on _GameStartingViewModelBase, Store {
  late final _$counterTextAtom =
      Atom(name: '_GameStartingViewModelBase.counterText', context: context);

  @override
  int get counterText {
    _$counterTextAtom.reportRead();
    return super.counterText;
  }

  @override
  set counterText(int value) {
    _$counterTextAtom.reportWrite(value, super.counterText, () {
      super.counterText = value;
    });
  }

  late final _$counterFlowAsyncAction =
      AsyncAction('_GameStartingViewModelBase.counterFlow', context: context);

  @override
  Future<void> counterFlow() {
    return _$counterFlowAsyncAction.run(() => super.counterFlow());
  }

  @override
  String toString() {
    return '''
counterText: ${counterText}
    ''';
  }
}
