// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_game_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MockGameViewModel on _MockGameViewModelBase, Store {
  late final _$scoreAtom =
      Atom(name: '_MockGameViewModelBase.score', context: context);

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

  late final _$timerSecondsAtom =
      Atom(name: '_MockGameViewModelBase.timerSeconds', context: context);

  @override
  int get timerSeconds {
    _$timerSecondsAtom.reportRead();
    return super.timerSeconds;
  }

  @override
  set timerSeconds(int value) {
    _$timerSecondsAtom.reportWrite(value, super.timerSeconds, () {
      super.timerSeconds = value;
    });
  }

  late final _$setTimerAsyncAction =
      AsyncAction('_MockGameViewModelBase.setTimer', context: context);

  @override
  Future<void> setTimer() {
    return _$setTimerAsyncAction.run(() => super.setTimer());
  }

  late final _$_MockGameViewModelBaseActionController =
      ActionController(name: '_MockGameViewModelBase', context: context);

  @override
  dynamic incrementScore() {
    final _$actionInfo = _$_MockGameViewModelBaseActionController.startAction(
        name: '_MockGameViewModelBase.incrementScore');
    try {
      return super.incrementScore();
    } finally {
      _$_MockGameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
score: ${score},
timerSeconds: ${timerSeconds}
    ''';
  }
}
