import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_app_bar.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/profile/viewmodel/profile_viewmodel.dart';

part 'components/user_posts.dart';

class ProfileView extends StatelessWidget {
  //TODO: Implement this.
  final UserDataModel? userData;
  const ProfileView({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        viewModel: ProfileViewModel(),
        onPageBuilder: (context, model) {
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
              title: Text(
                model.userName!,
                style: TextConsts.instance.regularWhite20Bold,
              ),
            ).build(),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }

  Widget buildProfileRow(ProfileViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: model.profileImage!.isNotEmpty
                  ? NetworkImage(model.profileImage!)
                  : Svg(
                      AssetConsts.instance.man,
                    ) as ImageProvider<Object>,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              model.userName!,
              style: TextConsts.instance.regularBlack20,
            ),
            settingsButton(),
          ],
        )
      ],
    );
  }

  Widget settingsButton() {
    return userData != null
        ? const SizedBox()
        : ElevatedButton(
            onPressed: () {},
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
        const Text("1"),
        const Text("2"),
      ],
    );
  }
}
