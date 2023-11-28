part of '../community_view.dart';

class CommunityShares extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CommunityShares({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const SharedPost();
        });
  }
}
