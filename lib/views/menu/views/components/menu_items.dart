part of '../menu_view.dart';

class MenuItems extends StatelessWidget {
  final MenuViewModel viewModel;
  const MenuItems({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItemModel>>(
        future: viewModel.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MenuItem(
                    viewModel: viewModel,
                    data: snapshot.data![index],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
