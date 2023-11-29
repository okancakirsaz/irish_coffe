import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_app_bar.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';
import 'package:irish_coffe/views/menu/viewmodel/menu_viewmodel.dart';

import '../../../core/consts/padding_consts.dart';

part 'components/menu_items.dart';
part 'components/menu_item.dart';
part 'components/add_to_basket_dialog.dart';
part 'components/basket.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
        viewModel: MenuViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            appBar: CustomAppBar(
              actions: [
                IconButton(
                  onPressed: () => model.navigateToBasket(model),
                  icon: Icon(
                    Icons.shopping_basket_outlined,
                    color: ColorConsts.instance.lightGray,
                    size: 30,
                  ),
                ),
              ],
              title: Text(
                "Irish Coffe",
                style: TextConsts.instance.regularWhite25Bold,
              ),
            ).build(),
            body: MenuItems(
              viewModel: model,
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
