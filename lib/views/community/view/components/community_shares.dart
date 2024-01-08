part of '../community_view.dart';

class CommunityShares extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CommunityShares({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
    return RefreshIndicator(
      onRefresh: () async => await viewModel.getFirstPosts(),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
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
          ),
        ),
      ),
    );
  }

  Widget buildPostList(CommunityViewModel viewModel) {
    return Observer(
      builder: (context) {
        return NotificationListener(
          onNotification: (ScrollNotification notification) {
            viewModel.addPageFinishListener(notification);
            return true;
          },
          child: RefreshIndicator(
            backgroundColor: ColorConsts.instance.lightGray,
            color: ColorConsts.instance.orange,
            onRefresh: () async => await viewModel.getFirstPosts(),
            child: ListView.builder(
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
              },
            ),
          ),
        );
      },
    );
  }
}
