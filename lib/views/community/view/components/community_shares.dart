part of '../community_view.dart';

class CommunityShares extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CommunityShares({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
        future: viewModel.getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return SharedPost(
                      data: snapshot.data![index],
                    );
                  });
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetConsts.instance.hand,
                    width: 150,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Henüz bir topluluk gönderisi yok. Hadi ilk paylaşan sen ol!",
                    textAlign: TextAlign.center,
                    style: TextConsts.instance.regularBlack18,
                  ),
                ],
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
