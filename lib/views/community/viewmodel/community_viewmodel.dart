import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/model/lite_user_data_model.dart';
import 'package:irish_coffe/core/service/mock_services/community_mock_service.dart';
import 'package:irish_coffe/views/community/models/currently_in_irish_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
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
  init() async {
    await getPostsFirstInit();
    await getCustomersFirstInit();
  }

  final PageController pageController = PageController();
  Uint8List? pickedImage;

  //TODO:Change to real services
  final CommunityMockService service = CommunityMockService();
  late final ScrollController postsScrollController;
  final TextEditingController postDescriptionController =
      TextEditingController();
  late final TabController tabController;

  @observable
  Widget? moreDataNotExist;
  bool isDataLoadSuccessful = false;
  @observable
  ObservableList<PostModel> allPosts = ObservableList<PostModel>.of([]);
  @observable
  ObservableList<CurrentlyInIrishModel> customers =
      ObservableList<CurrentlyInIrishModel>.of([]);

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

  addPageFinishListener(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      getMorePosts();
    } else {
      //Nothing.
    }
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

  Future<void> getPostsFirstInit() async {
    List<dynamic>? cachedPosts =
        localeManager.getNullableJsonData(LocaleKeysEnums.posts.name);
    if (cachedPosts == null) {
      await getFirstPosts();
    } else {
      //Posts already cached.
      allPosts = convertCachedPostsToModel();
      isDataLoadSuccessful = true;
    }
  }

  @action
  Future<void> getFirstPosts() async {
    try {
      final List<PostModel>? response = await service.getPosts();
      await localeManager.setJsonData(
          LocaleKeysEnums.posts.name, response ?? []);
      allPosts = convertCachedPostsToModel();
      if (allPosts.isNotEmpty) {
        await localeManager.setStringData(
            LocaleKeysEnums.lastCamePost.name, allPosts.last.time!);
      }
      isDataLoadSuccessful = true;
    } catch (e) {
      debugPrint("$e");
      Fluttertoast.showToast(
          backgroundColor: ColorConsts.instance.orange,
          msg: "Bir sorun oluştu. Tekrar deneyiniz.");
    }
  }

  @action
  Future<void> getMorePosts() async {
    final List<PostModel> response = await service.getMorePosts(
        localeManager.getStringData(LocaleKeysEnums.lastCamePost.name));
    if (response.isEmpty) {
      moreDataNotExist = Text(
        "O kadar çok kaydırdın ki görüntülenebilecek başka içerik bırakmadın. :)",
        style: TextConsts.instance.regularBlack14Bold,
        textAlign: TextAlign.center,
      );
    }
    for (PostModel post in response) {
      allPosts.add(post);
    }
    await cacheMoreGettedPosts();
  }

  Future<void> cacheMoreGettedPosts() async {
    List<Map<String, dynamic>> allPostsAsJson = [];
    for (PostModel post in allPosts) {
      allPostsAsJson.add(post.toJson());
    }
    await localeManager.setJsonData(LocaleKeysEnums.posts.name, allPostsAsJson);
    await localeManager.setStringData(
        LocaleKeysEnums.lastCamePost.name, allPosts.last.time!);
  }

  ObservableList<PostModel> convertCachedPostsToModel() {
    final List<dynamic> cachedList =
        localeManager.getJsonData(LocaleKeysEnums.posts.name);
    ObservableList<PostModel> convertedList = ObservableList<PostModel>.of([]);

    for (var element in cachedList) {
      convertedList.add(
        PostModel.fromJson(element),
      );
    }

    return convertedList;
  }

  navigateToProfile(LiteUserDataModel data) {
    Navigator.push(
        viewModelContext,
        CupertinoPageRoute(
            builder: (context) => ProfileView(
                  userData: data,
                )));
  }

  @action
  Future<void> getCustomerList() async {
    try {
      isDataLoadSuccessful = false;
      final List<CurrentlyInIrishModel>? response =
          await service.getWhoInIrishData();
      await localeManager.setJsonData(LocaleKeysEnums.customers.name, response);
      isDataLoadSuccessful = true;
      customers = convertCachedCustomerListAsModel();
    } catch (e) {
      debugPrint("$e");
      Fluttertoast.showToast(
          backgroundColor: ColorConsts.instance.orange,
          msg: "Bir sorun oluştu. Tekrar deneyiniz.");
    }
  }

  ObservableList<CurrentlyInIrishModel> convertCachedCustomerListAsModel() {
    final List<dynamic> cachedList =
        localeManager.getJsonData(LocaleKeysEnums.customers.name);
    ObservableList<CurrentlyInIrishModel> convertedList =
        ObservableList<CurrentlyInIrishModel>.of([]);
    for (var element in cachedList) {
      convertedList.add(
        CurrentlyInIrishModel.fromJson(element),
      );
    }

    return convertedList;
  }

  Future<void> getCustomersFirstInit() async {
    List<dynamic>? cachedList =
        localeManager.getNullableJsonData(LocaleKeysEnums.customers.name);
    if (cachedList == null) {
      await getCustomerList();
    } else {
      //Customers already cached.
      customers = convertCachedCustomerListAsModel();
      isDataLoadSuccessful = true;
    }
  }

  checkUserIsAnonymAndNavigateProfile(CurrentlyInIrishModel data) {
    if (data.isAnonym) {
      Fluttertoast.showToast(
          msg: "Kullanıcı anonim kalmak istediği için profilini açamazsınız.",
          backgroundColor: ColorConsts.instance.orange);
    } else {
      navigateToProfile(
        LiteUserDataModel(
            name: data.name,
            gender: data.gender,
            token: data.token,
            profileImage: data.profileImage),
      );
    }
  }
}
