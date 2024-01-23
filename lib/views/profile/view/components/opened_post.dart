part of '../profile_view.dart';

class OpenedPost extends StatelessWidget {
  final PostModel postData;
  final ProfileViewModel viewModel;
  const OpenedPost(
      {super.key, required this.postData, required this.viewModel});
  //TODO: Make more beatiful UI
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: PaddingConsts.instance.all10,
                child: SizedBox(
                  width: 220,
                  child: Text(
                    postData.user!.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextConsts.instance.regularWhite16Bold,
                  ),
                ),
              ),
              viewModel.checkIsProfileMine(postData.user!.token!)
                  ? buildDeleteIconButton
                  : const SizedBox()
            ],
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: ColorConsts.instance.lightGray,
              image: DecorationImage(
                image: NetworkImage(postData.apiImage!),
                fit: BoxFit.contain,
              ),
            ),
          )),
          Padding(
            padding: PaddingConsts.instance.all10,
            child: Text(
              postData.description ?? "",
              textAlign: TextAlign.start,
              style: TextConsts.instance.regularWhite20,
            ),
          ),
        ],
      ),
    );
  }

  Widget get buildDeleteIconButton {
    return EasyButton(
      width: 40,
      buttonColor: Colors.transparent,
      onPressed: () async => await viewModel.deletePost(postData.id!),
      idleStateWidget: Icon(
        Icons.delete,
        size: 30,
        color: ColorConsts.instance.red,
      ),
      loadingStateWidget: Padding(
        padding: PaddingConsts.instance.all10,
        child: CircularProgressIndicator(
          color: ColorConsts.instance.lightGray,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
