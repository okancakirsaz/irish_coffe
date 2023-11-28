import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/views/community/viewmodel/community_viewmodel.dart';
import '../../../core/consts/text_consts.dart';
import '../../../core/widgets/custom_app_bar.dart';

part 'components/community_shares.dart';
part 'components/shared_post.dart';
part 'components/customer_list.dart';
part 'components/create_post.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<CommunityViewModel>(
        viewModel: CommunityViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => model.openImageModeSelector(),
              backgroundColor: ColorConsts.instance.orange,
              child: Icon(
                Icons.add,
                color: ColorConsts.instance.lightGray,
                size: 30,
              ),
            ),
            appBar: CustomAppBar(
                title: Text(
                  "Irish Coffe",
                  style: TextConsts.instance.regularWhite25Bold,
                ),
                tabs: TabBar(
                    indicatorColor: ColorConsts.instance.orange,
                    onTap: (index) => model.navigateToIndexedPage(index),
                    controller: TabController(length: 2, vsync: this),
                    tabs: <Widget>[
                      Tab(
                        icon: Text(
                          "Topluluk Paylaşımları",
                          style: TextConsts.instance.regularWhite16Bold,
                        ),
                      ),
                      Tab(
                        icon: Text(
                          "Kimler Irish'te?",
                          style: TextConsts.instance.regularWhite16Bold,
                        ),
                      ),
                    ])).build(),
            body: PageView(
              controller: model.pageController,
              children: <Widget>[
                CommunityShares(
                  viewModel: model,
                ),
                CustomerList(
                  viewModel: model,
                )
              ],
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }
}
