part of '../community_view.dart';

class SharedPost extends StatelessWidget {
  final PostModel data;
  const SharedPost({super.key, required this.data});
  //TODO: Use NetworkImage when you changed real services
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConsts.instance.all10,
      child: Column(
        children: <Widget>[
          infoBar(),
          postImage(),
          descriptionBar(),
        ],
      ),
    );
  }

  Widget profileImage() {
    return data.user!.profileImage != ""
        ? Container(
            margin: PaddingConsts.instance.left10,
            width: 45,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: RadiusConsts.instance.circularAll100,
              image: DecorationImage(
                  image: NetworkImage(
                    data.user!.profileImage!,
                  ),
                  fit: BoxFit.fitWidth),
            ),
          )
        : Padding(
            padding: PaddingConsts.instance.left10,
            child:
                CircleAvatar(child: SvgPicture.asset(AssetConsts.instance.man)),
          );
  }

  Widget infoBar() {
    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularTop10,
        color: ColorConsts.instance.green,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.all5,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: PaddingConsts.instance.right10,
                  child: profileImage(),
                ),
                InkWell(
                  child: Text(
                    data.user!.name,
                    style: TextConsts.instance.regularWhite16Bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.left10,
            child: Text(
              data.time!,
              style: TextConsts.instance.regularWhite16,
            ),
          ),
        ],
      ),
    );
  }

  Widget postImage() {
    return Container(
      width: 450,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: MemoryImage(
              data.image!,
            ),
            fit: BoxFit.fitHeight),
      ),
    );
  }

  Widget descriptionBar() {
    return data.description!.isNotEmpty
        ? Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: RadiusConsts.instance.circularBottom10,
              color: ColorConsts.instance.green,
            ),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Text(
                  data.description!,
                  style: TextConsts.instance.regularWhite16,
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
