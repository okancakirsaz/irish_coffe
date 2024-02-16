class EventModel {
  bool? isPysicalEvent;
  String? eventName;
  String? eventTime;
  String? eventId;
  String? award;
  String? winner;
  bool? isStarted;
  String? gameType;

  EventModel({
    this.isPysicalEvent,
    this.eventName,
    this.eventTime,
    this.eventId,
    this.award,
    this.winner,
    this.isStarted,
    this.gameType,
  });

  Map<String, dynamic> toJson() {
    return {
      'isPysicalEvent': isPysicalEvent,
      'eventName': eventName,
      'eventTime': eventTime,
      'eventId': eventId,
      'award': award,
      'winner': winner,
      'isStarted': isStarted,
      'gameType': gameType,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      isPysicalEvent: json['isPysicalEvent'] as bool?,
      eventName: json['eventName'] as String?,
      eventTime: json['eventTime'] as String?,
      eventId: json['eventId'] as String?,
      winner: json['winner'] as String?,
      award: json['award'] as String?,
      isStarted: json['isStarted'] as bool?,
      gameType: json['gameType'] as String?,
    );
  }

  @override
  String toString() =>
      "EventModel(isPysicalEvent: $isPysicalEvent,eventName: $eventName,eventTime: $eventTime,eventId: $eventId,gameType: $gameType)";

  @override
  int get hashCode =>
      Object.hash(isPysicalEvent, eventName, eventTime, eventId, gameType);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModel &&
          runtimeType == other.runtimeType &&
          isPysicalEvent == other.isPysicalEvent &&
          eventName == other.eventName &&
          eventTime == other.eventTime &&
          eventId == other.eventId &&
          gameType == other.gameType;
}
