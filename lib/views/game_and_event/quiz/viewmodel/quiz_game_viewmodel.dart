import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/managers/choose_winner_manager.dart';

import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'quiz_game_viewmodel.g.dart';

class QuizGameViewModel = _QuizGameViewModelBase with _$QuizGameViewModel;

abstract class _QuizGameViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  ChooseWinnerManager get winnerManager => ChooseWinnerManager(_duelData);
  late final List questions;
  @observable
  String currentQuestion = "";
  @observable
  ObservableList currentOptions = ObservableList.of(["", "", "", ""]);
  String currentAnswer = "";
  @observable
  int score = 0;
  late final DuelInviteModel _duelData;

  @observable
  ObservableList colorList = ObservableList.of([
    ColorConsts.instance.orange,
    ColorConsts.instance.orange,
    ColorConsts.instance.orange,
    ColorConsts.instance.orange,
  ]);

  @override
  init() async {
    await getQuestions();
    await fetchQuestion();
    await removeGameDataCache();
  }

  initDuelData(DuelInviteModel data) => _duelData = data;

  Future<void> getQuestions() async {
    String data = await DefaultAssetBundle.of(viewModelContext)
        .loadString(AssetConsts.instance.questions);
    questions = jsonDecode(data);
  }

  Future<void> onTimerCompleted() async {
    await winnerManager.setGameFinalData(
        score, winnerManager.isUserChallenger(), viewModelContext);
  }

  @action
  fetchQuestion() {
    Map<String, dynamic> question = _getRandomQuestion();
    currentQuestion = question["question"];
    currentAnswer = question["answer"];
    currentOptions = ObservableList.of(question["options"]);
    questions.remove(question);
    colorList = ObservableList.of([
      ColorConsts.instance.orange,
      ColorConsts.instance.orange,
      ColorConsts.instance.orange,
      ColorConsts.instance.orange,
    ]);
  }

  Map<String, dynamic> _getRandomQuestion() {
    return questions[Random().nextInt(questions.length - 1)];
  }

  Future<void> checkQuestionIsTrue(String data, int index) async {
    if (data == currentAnswer) {
      _questionTrueProcess(index);
    } else {
      _questionFalseProcess(index);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    fetchQuestion();
  }

  @action
  _questionTrueProcess(int index) {
    score++;
    colorList[index] = ColorConsts.instance.green;
  }

  @action
  _questionFalseProcess(int index) {
    colorList[index] = ColorConsts.instance.red;
  }
}
