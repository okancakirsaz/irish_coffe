part of '../profile_view.dart';

class UserPosts extends StatelessWidget {
  final ProfileViewModel viewModel;
  const UserPosts({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
        future: viewModel.getUserPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      margin: PaddingConsts.instance.all5,
                      decoration: BoxDecoration(
                        borderRadius: RadiusConsts.instance.circularAll10,
                        image: DecorationImage(
                            image:
                                NetworkImage(snapshot.data![index].apiImage!),
                            fit: BoxFit.cover),
                      ),
                    ),
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
