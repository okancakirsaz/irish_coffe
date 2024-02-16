part of '../games_view.dart';

class EventsElement extends StatelessWidget {
  final String name;
  final String time;
  const EventsElement({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.all10,
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: RadiusConsts.instance.circularAll10,
          color: ColorConsts.instance.orange,
          boxShadow: ColorConsts.instance.shadow),
      child: ListTile(
        title: Text(
          name,
          style: TextConsts.instance.regularWhite20Bold,
        ),
        subtitle: Text(
          time,
          style: TextConsts.instance.regularWhite20,
        ),
      ),
    );
  }
}
