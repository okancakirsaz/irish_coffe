part of '../profile_view.dart';

class ProfileImage extends StatelessWidget {
  final ProfileViewModel viewModel;
  const ProfileImage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: viewModel.pickImageForGender(viewModel.cameUserData?.token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: viewModel.profileImage != null
                      ? NetworkImage(viewModel.profileImage!)
                      : Svg(
                          snapshot.data!,
                        ) as ImageProvider<Object>,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
