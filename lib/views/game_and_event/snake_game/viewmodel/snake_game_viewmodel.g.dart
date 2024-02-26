// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snake_game_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SnakeGameViewModel on _SnakeGameViewModelBase, Store {
  late final _$scoreAtom =
      Atom(name: '_SnakeGameViewModelBase.score', context: context);

  @override
  int get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  late final _$_SnakeGameViewModelBaseActionController =
      ActionController(name: '_SnakeGameViewModelBase', context: context);

  @override
  dynamic _incrementScore() {
    final _$actionInfo = _$_SnakeGameViewModelBaseActionController.startAction(
        name: '_SnakeGameViewModelBase._incrementScore');
    try {
      return super._incrementScore();
    } finally {
      _$_SnakeGameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
score: ${score}
    ''';
  }
}
