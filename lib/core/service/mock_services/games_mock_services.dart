import 'package:irish_coffe/views/games/models/event_model.dart';

class GamesMockService {
  Future<List<EventModel>> getEvents() async {
    List<EventModel> modelList = [];
    for (var data in activeEvents) {
      modelList.add(EventModel.fromJson(data));
    }
    return modelList;
  }

  static List<Map<String, dynamic>> activeEvents = [
    {
      "isPysicalEvent": true,
      "eventName": "Stand-Up Gecesi",
      "eventTime": "19.11.2024/19.00",
      "eventId": "adsad-dasdas-dsadas",
      "gameType": null
    },
    {
      "isPysicalEvent": false,
      "eventName": "Bilgi Yarışması",
      "eventTime": "19.11.2024/19.00",
      "eventId": "adsad-dasdas-dsws",
      "gameType": "quiz"
    },
  ];
  static List<Map<String, dynamic>> emptyActiveEvents = [];
}
