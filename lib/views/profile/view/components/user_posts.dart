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
            if (snapshot.data!.isNotEmpty) {
              return postsGrid();
            } else {
              return haventPosts();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget haventPosts() {
    return Center(
      child: SizedBox(
          width: 250,
          child: Text(
            "Bu kullanıcı henüz gönderi paylaşmamış.",
            style: TextConsts.instance.regularBlack20Bold,
            textAlign: TextAlign.center,
          )),
    );
  }

  Widget postsGrid() {
    return Observer(builder: (context) {
      return GridView.builder(
          itemCount: viewModel.posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => viewModel.openPost(
                  viewModel.posts.reversed.toList()[index], viewModel),
              child: Container(
                margin: PaddingConsts.instance.all5,
                decoration: BoxDecoration(
                  borderRadius: RadiusConsts.instance.circularAll10,
                  image: DecorationImage(
                      image: NetworkImage(
                          viewModel.posts.reversed.toList()[index].apiImage!),
                      fit: BoxFit.cover),
                ),
              ),
            );
          });
    });
  }
}
