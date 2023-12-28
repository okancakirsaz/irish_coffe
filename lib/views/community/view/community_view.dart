import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/core/widgets/custom_sliver_app_bar.dart';
import 'package:irish_coffe/views/community/models/currently_in_irish_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/community/viewmodel/community_viewmodel.dart';
import '../../../core/consts/text_consts.dart';

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
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  CustomSliverAppBar(
                    title: Text(
                      "Irish Coffee",
                      style: TextConsts.instance.regularWhite25Bold,
                    ),
                    tabs: TabBar(
                      controller: model.tabController,
                      indicatorColor: ColorConsts.instance.orange,
                      onTap: (index) => model.navigateToIndexedPage(index),
                      tabs: <Widget>[
                        Tab(
                          icon: Text(
                            "Topluluk Paylaşımları",
                            textAlign: TextAlign.center,
                            style: TextConsts.instance.regularWhite14Bold,
                          ),
                        ),
                        Tab(
                          icon: Text(
                            "Kimler Irish'te?",
                            textAlign: TextAlign.center,
                            style: TextConsts.instance.regularWhite14Bold,
                          ),
                        ),
                      ],
                    ),
                  ).build()
                ];
              },
              body: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: PageView(
                  onPageChanged: (index) {
                    model.whenPageChangedWithHand(index);
                  },
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
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
          model.initializeTabController(this);
        },
        onDispose: () {});
  }
}
