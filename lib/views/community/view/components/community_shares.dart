part of '../community_view.dart';

class CommunityShares extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CommunityShares({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    //TODO: IMPORTANT!!! Sliver app bar dont work in the list mod

    return Observer(builder: (context) {
      if (viewModel.allPosts.isNotEmpty) {
        return buildPostList(viewModel);
      } else if (viewModel.allPosts.isEmpty && viewModel.isDataLoadSuccessful) {
        return buildListIsEmptyView();
      } else {
        return buildLoadingWidget(viewModel);
      }
    });
  }

  Widget buildLoadingWidget(CommunityViewModel viewModel) {
    return viewModel.moreDataNotExist ??
        Center(
            child: CircularProgressIndicator(
          color: ColorConsts.instance.orange,
        ));
  }

  Widget buildListIsEmptyView() {
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

  Widget buildPostList(CommunityViewModel viewModel) {
    return RefreshIndicator(
      backgroundColor: ColorConsts.instance.lightGray,
      color: ColorConsts.instance.orange,
      onRefresh: () async => await viewModel.getFirstPosts(),
      child: Observer(
        builder: (context) {
          return ListView.builder(
              controller: viewModel.postsScrollController,
              itemCount: viewModel.allPosts.length + 1,
              itemBuilder: (context, index) {
                if (index == viewModel.allPosts.length) {
                  return Observer(builder: (context) {
                    return Padding(
                      padding: PaddingConsts.instance.all10,
                      child: buildLoadingWidget(viewModel),
                    );
                  });
                } else {
                  return SharedPost(
                    viewModel: viewModel,
                    data: viewModel.allPosts[index],
                  );
                }
              });
        },
      ),
    );
  }
}
