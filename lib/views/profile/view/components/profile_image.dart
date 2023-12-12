part of '../profile_view.dart';

class ProfileImage extends StatelessWidget {
  final ProfileViewModel viewModel;
  const ProfileImage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: viewModel.profileImage!.isNotEmpty
              ? NetworkImage(viewModel.profileImage!)
              : Svg(
                  AssetConsts.instance.man,
                ) as ImageProvider<Object>,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
