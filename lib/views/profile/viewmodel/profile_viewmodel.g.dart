// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  late final _$profileImageAtom =
      Atom(name: '_ProfileViewModelBase.profileImage', context: context);

  @override
  String? get profileImage {
    _$profileImageAtom.reportRead();
    return super.profileImage;
  }

  @override
  set profileImage(String? value) {
    _$profileImageAtom.reportWrite(value, super.profileImage, () {
      super.profileImage = value;
    });
  }

  late final _$postsAtom =
      Atom(name: '_ProfileViewModelBase.posts', context: context);

  @override
  ObservableList<PostModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<PostModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

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

  late final _$getUserPostsAsyncAction =
      AsyncAction('_ProfileViewModelBase.getUserPosts', context: context);

  @override
  Future<List<PostModel>> getUserPosts() {
    return _$getUserPostsAsyncAction.run(() => super.getUserPosts());
  }

  late final _$_setNewProfileImageAsyncAction = AsyncAction(
      '_ProfileViewModelBase._setNewProfileImage',
      context: context);

  @override
  Future<void> _setNewProfileImage() {
    return _$_setNewProfileImageAsyncAction
        .run(() => super._setNewProfileImage());
  }

  late final _$deleteProfileImageAsyncAction =
      AsyncAction('_ProfileViewModelBase.deleteProfileImage', context: context);

  @override
  Future<void> deleteProfileImage() {
    return _$deleteProfileImageAsyncAction
        .run(() => super.deleteProfileImage());
  }

  late final _$deletePostAsyncAction =
      AsyncAction('_ProfileViewModelBase.deletePost', context: context);

  @override
  Future<void> deletePost(String postId) {
    return _$deletePostAsyncAction.run(() => super.deletePost(postId));
  }

  @override
  String toString() {
    return '''
profileImage: ${profileImage},
posts: ${posts},
anonymValue: ${anonymValue}
    ''';
  }
}
