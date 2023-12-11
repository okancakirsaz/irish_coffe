import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/service/mock_services/Games_mock_services.dart';
import 'package:irish_coffe/views/games/models/event_model.dart';
import 'package:irish_coffe/views/games/view/games_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'games_viewmodel.g.dart';

class GamesViewModel = _GamesViewModelBase with _$GamesViewModel;

abstract class _GamesViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    if (eventsAsWidget.isEmpty) {
      isEventsFetched = false;
    }
  }

  final PageController pageController = PageController();
  final GamesMockService service = GamesMockService();
  bool isEventsFetched = false;
  late final TabController tabController;

  //TODO: Do remove event in overdue logic
  final List<Widget> eventsAsWidget = [];

  navigateToIndexedPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  initializeTabController(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
  }

  whenPageChangedWithHand(int index) {
    tabController.animateTo(index);
  }

  Future<List<EventModel>> getEvents() async {
    final List<EventModel> response = await service.getEvents();
    return response;
  }

  Future<List<Widget>> fetchEventsToWidget() async {
    if (!isEventsFetched) {
      final List<EventModel> events = await getEvents();
      fetchPysicalEvents(events);
      fetchVirtualEvents(events);
      isEventsFetched = true;
    }
    return eventsAsWidget;
  }

  fetchPysicalEvents(List<EventModel> events) {
    for (EventModel event in events) {
      if (event.isPysicalEvent!) {
        eventsAsWidget
            .add(EventsElement(name: event.eventName!, time: event.eventTime!));
      }
    }
  }

  fetchVirtualEvents(List<EventModel> events) {
    for (EventModel event in events) {
      if (!event.isPysicalEvent!) {
        switch (event.gameType) {
          case "snake":
            eventsAsWidget.add(SnakeGame(
              onPressed: () {},
              time: event.eventTime,
            ));
            break;

          case "quiz":
            eventsAsWidget.add(
              QuizGame(
                onPressed: () {},
                time: event.eventTime,
              ),
            );
            break;
        }
      }
    }
  }
}
