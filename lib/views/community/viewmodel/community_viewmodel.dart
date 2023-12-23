import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/model/lite_user_data_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/community/services/community_services.dart';
import 'package:irish_coffe/views/community/view/community_view.dart';
import 'package:irish_coffe/views/main/view/main_view.dart';
import 'package:irish_coffe/views/profile/view/profile_view.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'community_viewmodel.g.dart';

class CommunityViewModel = _CommunityViewModelBase with _$CommunityViewModel;

abstract class _CommunityViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  final PageController pageController = PageController();
  Uint8List? pickedImage;
  final CommunityServices service = CommunityServices();
  final TextEditingController postDescriptionController =
      TextEditingController();
  late final TabController tabController;

  navigateToIndexedPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  initializeTabController(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
  }

  whenPageChangedWithHand(int index) {
    tabController.animateTo(index);
  }

  openImageModeSelector() {
    showBottomSheet(
        context: viewModelContext,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: ColorConsts.instance.green,
                borderRadius: RadiusConsts.instance.circularTop10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () async => await createPost(ImageSource.camera),
                  icon: Icon(
                    Icons.camera_alt,
                    color: ColorConsts.instance.lightGray,
                    size: 60,
                  ),
                ),
                IconButton(
                  onPressed: () async => await createPost(ImageSource.gallery),
                  icon: Icon(
                    Icons.photo,
                    color: ColorConsts.instance.lightGray,
                    size: 60,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> createPost(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    pickedImage = await image?.readAsBytes();
    if (pickedImage != null) {
      navigateToCreatePostPage();
    }
  }

  navigateToCreatePostPage() {
    //TODO: Use navigation manager
    Navigator.push(
      viewModelContext,
      CupertinoPageRoute(
        builder: (context) => CreatePost(
          onPressed: sharePost,
          controller: postDescriptionController,
          pickedImage: pickedImage!,
        ),
      ),
    );
  }

  sharePost() async {
    await service.postNewPost(
      PostModel(
        //TODO: This will be dont work use an api and get api image path
        apiImage:
            "https://i.pinimg.com/236x/b9/41/53/b941537aa093ec0b9dc488a6811d819d.jpg", //pickedImage,
        description: postDescriptionController.text,
        user: LiteUserDataModel(
            token: localeManager
                .getNullableStringData(LocaleKeysEnums.token.name)!,
            name:
                localeManager.getNullableStringData(LocaleKeysEnums.name.name)!,
            profileImage: localeManager
                    .getNullableStringData(LocaleKeysEnums.profileImage.name) ??
                "",
            gender: localeManager
                    .getNullableStringData(LocaleKeysEnums.gender.name) ??
                ""),
        time: getCurrentTimeAsString(),
        id: const Uuid().v1(),
      ),
    );
    goBackPosts();
  }

  goBackPosts() {
    Navigator.pushAndRemoveUntil(
        viewModelContext,
        CupertinoPageRoute(builder: (context) => const MainView()),
        (route) => false);
  }

  String getCurrentTimeAsString() {
    final DateTime dateTime = DateTime.now();
    final int day = dateTime.day;
    final int month = dateTime.month;
    final int year = dateTime.year;
    final int hour = dateTime.hour;
    final int minute = dateTime.minute;
    return "$day.$month.$year/$hour.$minute";
  }

  Future<List<PostModel>> getAllPosts() async {
    final List<PostModel>? response = await service.getPosts();
    return response ?? [];
  }

  navigateToProfile(LiteUserDataModel data) {
    Navigator.push(
        viewModelContext,
        CupertinoPageRoute(
            builder: (context) => ProfileView(
                  userData: data,
                )));
  }
}
