part of '../profile_view.dart';

class OpenedPost extends StatelessWidget {
  final PostModel postData;
  final ProfileViewModel viewModel;
  const OpenedPost(
      {super.key, required this.postData, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: PaddingConsts.instance.all10,
                child: Text(
                  postData.user!.name!,
                  style: TextConsts.instance.regularWhite20Bold,
                ),
              ),
              viewModel.checkIsProfileMine(postData.user!.token!)
                  ? IconButton(
                      onPressed: () async =>
                          await viewModel.deletePost(postData.id!),
                      icon: Icon(
                        Icons.delete,
                        size: 30,
                        color: ColorConsts.instance.red,
                      ))
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
}
