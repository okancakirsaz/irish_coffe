// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  late final _$anonymValueAtom =
      Atom(name: '_ProfileViewModelBase.anonymValue', context: context);

  @override
  bool? get anonymValue {
    _$anonymValueAtom.reportRead();
    return super.anonymValue;
  }

  @override
  set anonymValue(bool? value) {
    _$anonymValueAtom.reportWrite(value, super.anonymValue, () {
      super.anonymValue = value;
    });
  }

  late final _$changeAnonymValueAsyncAction =
      AsyncAction('_ProfileViewModelBase.changeAnonymValue', context: context);

  @override
  Future<void> changeAnonymValue(bool value) {
    return _$changeAnonymValueAsyncAction
        .run(() => super.changeAnonymValue(value));
  }

  @override
  String toString() {
    return '''
anonymValue: ${anonymValue}
    ''';
  }
}
