part of '../community_view.dart';

class CreatePost extends StatelessWidget {
  final TextEditingController controller;
  final Uint8List pickedImage;
  final VoidCallback onPressed;
  const CreatePost(
      {super.key,
      required this.controller,
      required this.pickedImage,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Image.memory(
            pickedImage,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: PaddingConsts.instance.all5,
            child: TextField(
              maxLength: 35,
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
          const SizedBox(height: 5),
          CustomButton(
            onPressed: () async => onPressed(),
            style: TextConsts.instance.regularBlack18,
            text: "Paylaş",
            width: 150,
            height: 45,
          ),
        ],
      ),
    );
  }
}
