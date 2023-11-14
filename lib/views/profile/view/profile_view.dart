import 'package:flutter/material.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/views/profile/viewmodel/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        viewModel: ProfileViewModel(),
        onPageBuilder: (context, model) {
          return const Scaffold();
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }
}
