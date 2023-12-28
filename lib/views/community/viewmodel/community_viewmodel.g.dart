// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommunityViewModel on _CommunityViewModelBase, Store {
  late final _$moreDataNotExistAtom =
      Atom(name: '_CommunityViewModelBase.moreDataNotExist', context: context);

  @override
  Widget? get moreDataNotExist {
    _$moreDataNotExistAtom.reportRead();
    return super.moreDataNotExist;
  }

  @override
  set moreDataNotExist(Widget? value) {
    _$moreDataNotExistAtom.reportWrite(value, super.moreDataNotExist, () {
      super.moreDataNotExist = value;
    });
  }

  late final _$allPostsAtom =
      Atom(name: '_CommunityViewModelBase.allPosts', context: context);

  @override
  ObservableList<PostModel> get allPosts {
    _$allPostsAtom.reportRead();
    return super.allPosts;
  }

  @override
  set allPosts(ObservableList<PostModel> value) {
    _$allPostsAtom.reportWrite(value, super.allPosts, () {
      super.allPosts = value;
    });
  }

  late final _$customersAtom =
      Atom(name: '_CommunityViewModelBase.customers', context: context);

  @override
  ObservableList<CurrentlyInIrishModel> get customers {
    _$customersAtom.reportRead();
    return super.customers;
  }

  @override
  set customers(ObservableList<CurrentlyInIrishModel> value) {
    _$customersAtom.reportWrite(value, super.customers, () {
      super.customers = value;
    });
  }

  late final _$getFirstPostsAsyncAction =
      AsyncAction('_CommunityViewModelBase.getFirstPosts', context: context);

  @override
  Future<void> getFirstPosts() {
    return _$getFirstPostsAsyncAction.run(() => super.getFirstPosts());
  }

  late final _$getMorePostsAsyncAction =
      AsyncAction('_CommunityViewModelBase.getMorePosts', context: context);

  @override
  Future<void> getMorePosts() {
    return _$getMorePostsAsyncAction.run(() => super.getMorePosts());
  }

  late final _$getCustomerListAsyncAction =
      AsyncAction('_CommunityViewModelBase.getCustomerList', context: context);

  @override
  Future<void> getCustomerList() {
    return _$getCustomerListAsyncAction.run(() => super.getCustomerList());
  }

  @override
  String toString() {
    return '''
moreDataNotExist: ${moreDataNotExist},
allPosts: ${allPosts},
customers: ${customers}
    ''';
  }
}
