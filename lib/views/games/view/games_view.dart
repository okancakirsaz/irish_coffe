import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/views/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/games/view/components/games_element.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/consts/color_consts/color_consts.dart';
import '../../../core/consts/padding_consts.dart';
import '../../../core/consts/radius_consts.dart';
import '../../../core/consts/text_consts.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../community/models/currently_in_irish_model.dart';
import '../../games/viewmodel/games_viewmodel.dart';

part 'components/events.dart';
part 'components/games.dart';
part 'components/quiz_game.dart';
part 'components/events_element.dart';
part 'components/snake_game.dart';
part 'components/select_user_page.dart';
part 'components/select_award_dialog.dart';
part 'components/wait_user_page.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<GamesViewModel>(
        viewModel: GamesViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            appBar: CustomAppBar(
              title: Text(
                "Irish Coffee",
                style: TextConsts.instance.regularWhite25Bold,
              ),
              tabs: TabBar(
                indicatorColor: ColorConsts.instance.orange,
                onTap: (index) => model.navigateToIndexedPage(index),
                controller: model.tabController,
                tabs: <Widget>[
                  Tab(
                    icon: Text(
                      "Oyunlar",
                      textAlign: TextAlign.center,
                      style: TextConsts.instance.regularWhite16Bold,
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "Etkinlikler",
                      textAlign: TextAlign.center,
                      style: TextConsts.instance.regularWhite16Bold,
                    ),
                  ),
                ],
              ),
            ).build(),
            body: PageView(
              onPageChanged: (index) {
                model.whenPageChangedWithHand(index);
              },
              controller: model.pageController,
              children: <Widget>[
                Games(viewModel: model),
                Events(viewModel: model),
              ],
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
