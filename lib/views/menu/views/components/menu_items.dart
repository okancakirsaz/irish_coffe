part of '../menu_view.dart';

class MenuItems extends StatelessWidget {
  final MenuViewModel viewModel;
  const MenuItems({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (viewModel.isLoadSuccessful) {
        return buildMenu();
      } else {
        return Center(
          child: CircularProgressIndicator(color: ColorConsts.instance.orange),
        );
      }
    });
  }

  Widget buildMenu() {
    return RefreshIndicator(
      backgroundColor: ColorConsts.instance.lightGray,
      color: ColorConsts.instance.orange,
      onRefresh: () async => viewModel.getMenu(),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemCount: viewModel.allMenu.length,
          itemBuilder: (context, index) {
            return MenuItem(
              viewModel: viewModel,
              data: viewModel.allMenu[index],
            );
          }),
    );
  }
}
