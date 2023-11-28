part of '../community_view.dart';

class CustomerList extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CustomerList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 65,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text(
                "Masa ${index + 1}",
                style: TextConsts.instance.regularBlack18Bold,
              ),
              title: Text(
                "Volkan Konak",
                style: TextConsts.instance.regularBlack18,
              ),
            ),
          );
        });
  }
}
