import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/widgets/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:irish_coffe/views/main/viewmodel/main_viewmodel.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MainViewModel>(
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: () {},
        viewModel: MainViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
              backgroundColor: ColorConsts.instance.lightGray,
              bottomNavigationBar: const CustomButtonNavBar(),
              body: Observer(builder: (context) {
                return model
                    .changePage(CustomButtonNavBar.viewModel.currentIndex);
              }));
        });
  }
}
