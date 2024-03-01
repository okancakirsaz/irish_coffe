// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_game_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizGameViewModel on _QuizGameViewModelBase, Store {
  late final _$currentQuestionAtom =
      Atom(name: '_QuizGameViewModelBase.currentQuestion', context: context);

  @override
  String get currentQuestion {
    _$currentQuestionAtom.reportRead();
    return super.currentQuestion;
  }

  @override
  set currentQuestion(String value) {
    _$currentQuestionAtom.reportWrite(value, super.currentQuestion, () {
      super.currentQuestion = value;
    });
  }

  late final _$currentOptionsAtom =
      Atom(name: '_QuizGameViewModelBase.currentOptions', context: context);

  @override
  ObservableList<dynamic> get currentOptions {
    _$currentOptionsAtom.reportRead();
    return super.currentOptions;
  }

  @override
  set currentOptions(ObservableList<dynamic> value) {
    _$currentOptionsAtom.reportWrite(value, super.currentOptions, () {
      super.currentOptions = value;
    });
  }

  late final _$scoreAtom =
      Atom(name: '_QuizGameViewModelBase.score', context: context);

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

  late final _$colorListAtom =
      Atom(name: '_QuizGameViewModelBase.colorList', context: context);

  @override
  ObservableList<dynamic> get colorList {
    _$colorListAtom.reportRead();
    return super.colorList;
  }

  @override
  set colorList(ObservableList<dynamic> value) {
    _$colorListAtom.reportWrite(value, super.colorList, () {
      super.colorList = value;
    });
  }

  late final _$_QuizGameViewModelBaseActionController =
      ActionController(name: '_QuizGameViewModelBase', context: context);

  @override
  dynamic fetchQuestion() {
    final _$actionInfo = _$_QuizGameViewModelBaseActionController.startAction(
        name: '_QuizGameViewModelBase.fetchQuestion');
    try {
      return super.fetchQuestion();
    } finally {
      _$_QuizGameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _questionTrueProcess(int index) {
    final _$actionInfo = _$_QuizGameViewModelBaseActionController.startAction(
        name: '_QuizGameViewModelBase._questionTrueProcess');
    try {
      return super._questionTrueProcess(index);
    } finally {
      _$_QuizGameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _questionFalseProcess(int index) {
    final _$actionInfo = _$_QuizGameViewModelBaseActionController.startAction(
        name: '_QuizGameViewModelBase._questionFalseProcess');
    try {
      return super._questionFalseProcess(index);
    } finally {
      _$_QuizGameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentQuestion: ${currentQuestion},
currentOptions: ${currentOptions},
score: ${score},
colorList: ${colorList}
    ''';
  }
}
