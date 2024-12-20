import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/init/model/lite_user_data_model.dart';
import 'package:irish_coffe/core/widgets/custom_app_bar.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/viewmodel/profile_viewmodel.dart';
import 'package:passwordfield/passwordfield.dart';

part 'components/user_posts.dart';
part 'components/game_scors.dart';
part 'components/favorite_foods.dart';
part 'components/settings.dart';
part 'components/profile_image.dart';
part 'components/opened_post.dart';

class ProfileView extends StatelessWidget {
  final LiteUserDataModel? userData;
  const ProfileView({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        viewModel: ProfileViewModel(),
        onPageBuilder: (context, model) {
          return FutureBuilder(
              future: model.init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomScaffold(
                    body: Column(
                      children: <Widget>[
                        Padding(
                          padding: PaddingConsts.instance.top10,
                          child: buildProfileRow(model),
                        ),
                        const SizedBox(height: 20),
                        buildTabBar(model),
                        Expanded(
                          child: buildPageView(model),
                        ),
                      ],
                    ),
                    appBar: CustomAppBar(
                      title: Observer(builder: (context) {
                        return Text(
                          model.userName!,
                          style: TextConsts.instance.regularWhite20Bold,
                        );
                      }),
                    ).build(),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        },
        onModelReady: (model) async {
          model.setContext(context);
          model.cameUserData = userData;
        },
        onDispose: () {});
  }

  Widget buildProfileRow(ProfileViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ProfileImage(viewModel: model),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 210,
              child: Observer(builder: (context) {
                return Text(
                  model.userName!,
                  style: TextConsts.instance.regularBlack18,
                );
              }),
            ),
            settingsButton(model),
          ],
        )
      ],
    );
  }

  Widget settingsButton(ProfileViewModel model) {
    return userData != null
        ? const SizedBox()
        : ElevatedButton(
            onPressed: () => model.navigateToSettings(model),
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: RadiusConsts.instance.circularAll10)),
              fixedSize: const MaterialStatePropertyAll(Size(210, 40)),
              backgroundColor:
                  MaterialStatePropertyAll(ColorConsts.instance.orange),
            ),
            child: Text(
              "Ayarlar",
              style: TextConsts.instance.regularWhite20Bold,
            ),
          );
  }

  Widget buildTabBar(ProfileViewModel model) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: ColorConsts.instance.green,
        child: TabBar(
          onTap: (index) {
            model.changePageView(index);
          },
          indicatorColor: ColorConsts.instance.orange,
          tabs: [
            Text(
              "Gönderiler",
              textAlign: TextAlign.center,
              style: TextConsts.instance.regularWhite14Bold,
            ),
            Text(
              "Oyun Skorları",
              textAlign: TextAlign.center,
              style: TextConsts.instance.regularWhite14Bold,
            ),
            Text(
              "Favori Yiyecekler",
              textAlign: TextAlign.center,
              style: TextConsts.instance.regularWhite14Bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageView(ProfileViewModel model) {
    return PageView(
      controller: model.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        UserPosts(viewModel: model),
        GameScors(viewModel: model),
        FavoriteFoods(viewModel: model)
      ],
    );
  }
}
