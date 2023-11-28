part of '../community_view.dart';

class SharedPost extends StatelessWidget {
  const SharedPost({super.key});

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
    return Container(
      margin: PaddingConsts.instance.left10,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: RadiusConsts.instance.circularAll100,
          image: const DecorationImage(
            image: NetworkImage(
              "https://i.pinimg.com/564x/87/6a/46/876a4611f2c16465c4adc69626cb049b.jpg",
            ),
          )),
    );
  }

  Widget infoBar() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularTop10,
        color: ColorConsts.instance.green,
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.right10,
            child: profileImage(),
          ),
          InkWell(
            child: Text(
              "Volkan Konak(Şu an Irish'te)",
              style: TextConsts.instance.regularWhite16Bold,
            ),
          )
        ],
      ),
    );
  }

  Widget postImage() {
    return Container(
      width: 450,
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://i.pinimg.com/564x/d4/6c/54/d46c545effbcadc65546b9a6d3ba8697.jpg"),
            fit: BoxFit.fitWidth),
      ),
    );
  }

  Widget descriptionBar() {
    return Container(
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
            "Merhaba ben Volkan Konak",
            style: TextConsts.instance.regularWhite16,
          ),
        ],
      ),
    );
  }
}
