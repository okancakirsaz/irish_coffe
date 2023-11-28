part of '../community_view.dart';

class CreatePost extends StatelessWidget {
  final TextEditingController controller;
  final Uint8List pickedImage;
  const CreatePost(
      {super.key, required this.controller, required this.pickedImage});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Image.memory(
            pickedImage,
            width: double.infinity,
            height: 400,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: PaddingConsts.instance.all5,
            child: TextField(
              style: TextConsts.instance.regularBlack18,
              decoration: InputDecoration(
                hintText: "Açıklama girebilirsiniz",
                hintStyle: TextConsts.instance.regularBlack18,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConsts.instance.green),
                ),
              ),
              controller: controller,
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
            onPressed: () {},
            style: TextConsts.instance.regularBlack18,
            text: "Paylaş",
            width: 150,
            height: 50,
          ),
        ],
      ),
    );
  }
}
