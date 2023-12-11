part of '../profile_view.dart';

class UserPosts extends StatelessWidget {
  final ProfileViewModel viewModel;
  const UserPosts({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 15,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              margin: PaddingConsts.instance.all5,
              decoration: BoxDecoration(
                borderRadius: RadiusConsts.instance.circularAll10,
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/736x/e2/6f/c2/e26fc2050cd0ef606112ca18388a7264.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
          );
        });
  }
}
