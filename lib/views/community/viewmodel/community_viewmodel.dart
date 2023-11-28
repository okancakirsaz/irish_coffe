import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/views/community/view/community_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'community_viewmodel.g.dart';

class CommunityViewModel = _CommunityViewModelBase with _$CommunityViewModel;

abstract class _CommunityViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  final PageController pageController = PageController();

  @override
  void init() {}

  navigateToIndexedPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  Uint8List? pickedImage;
  final TextEditingController postDescriptionController =
      TextEditingController();

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
                controller: postDescriptionController,
                pickedImage: pickedImage!)));
  }
}
