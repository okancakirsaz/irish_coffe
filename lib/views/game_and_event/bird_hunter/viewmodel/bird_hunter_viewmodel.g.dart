// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bird_hunter_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BirdHunterViewModel on _BirdHunterViewModelBase, Store {
  late final _$birdScaleAtom =
      Atom(name: '_BirdHunterViewModelBase.birdScale', context: context);

  @override
  double get birdScale {
    _$birdScaleAtom.reportRead();
    return super.birdScale;
  }

  @override
  set birdScale(double value) {
    _$birdScaleAtom.reportWrite(value, super.birdScale, () {
      super.birdScale = value;
    });
  }

  late final _$birdAngleAtom =
      Atom(name: '_BirdHunterViewModelBase.birdAngle', context: context);

  @override
  double get birdAngle {
    _$birdAngleAtom.reportRead();
    return super.birdAngle;
  }

  @override
  set birdAngle(double value) {
    _$birdAngleAtom.reportWrite(value, super.birdAngle, () {
      super.birdAngle = value;
    });
  }

  late final _$birdAtom =
      Atom(name: '_BirdHunterViewModelBase.bird', context: context);

  @override
  Widget get bird {
    _$birdAtom.reportRead();
    return super.bird;
  }

  @override
  set bird(Widget value) {
    _$birdAtom.reportWrite(value, super.bird, () {
      super.bird = value;
    });
  }

  late final _$birdAlignmentAtom =
      Atom(name: '_BirdHunterViewModelBase.birdAlignment', context: context);

  @override
  Alignment? get birdAlignment {
    _$birdAlignmentAtom.reportRead();
    return super.birdAlignment;
  }

  @override
  set birdAlignment(Alignment? value) {
    _$birdAlignmentAtom.reportWrite(value, super.birdAlignment, () {
      super.birdAlignment = value;
    });
  }

  late final _$scoreAtom =
      Atom(name: '_BirdHunterViewModelBase.score', context: context);

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

  late final _$_BirdHunterViewModelBaseActionController =
      ActionController(name: '_BirdHunterViewModelBase', context: context);

  @override
  dynamic createRandomParrotPosition() {
    final _$actionInfo = _$_BirdHunterViewModelBaseActionController.startAction(
        name: '_BirdHunterViewModelBase.createRandomParrotPosition');
    try {
      return super.createRandomParrotPosition();
    } finally {
      _$_BirdHunterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reScaleBird(BirdHunterViewModel viewModel) {
    final _$actionInfo = _$_BirdHunterViewModelBaseActionController.startAction(
        name: '_BirdHunterViewModelBase.reScaleBird');
    try {
      return super.reScaleBird(viewModel);
    } finally {
      _$_BirdHunterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic shootTheBird(BirdHunterViewModel viewModel) {
    final _$actionInfo = _$_BirdHunterViewModelBaseActionController.startAction(
        name: '_BirdHunterViewModelBase.shootTheBird');
    try {
      return super.shootTheBird(viewModel);
    } finally {
      _$_BirdHunterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
birdScale: ${birdScale},
birdAngle: ${birdAngle},
bird: ${bird},
birdAlignment: ${birdAlignment},
score: ${score}
    ''';
  }
}
