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
              return postsGrid(snapshot.data!);
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

  Widget postsGrid(List<PostModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              margin: PaddingConsts.instance.all5,
              decoration: BoxDecoration(
                borderRadius: RadiusConsts.instance.circularAll10,
                image: DecorationImage(
                    image: NetworkImage(snapshot[index].apiImage!),
                    fit: BoxFit.cover),
              ),
            ),
          );
        });
  }
}
