class EventModel {
  bool? isPysicalEvent;
  String? eventName;
  String? eventTime;
  String? eventId;
  String? gameType;

  EventModel({
    this.isPysicalEvent,
    this.eventName,
    this.eventTime,
    this.eventId,
    this.gameType,
  });

  EventModel copyWith({
    bool? isPysicalEvent,
    String? eventName,
    String? eventTime,
    String? eventId,
    String? gameType,
  }) {
    return EventModel(
      isPysicalEvent: isPysicalEvent ?? this.isPysicalEvent,
      eventName: eventName ?? this.eventName,
      eventTime: eventTime ?? this.eventTime,
      eventId: eventId ?? this.eventId,
      gameType: gameType ?? this.gameType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isPysicalEvent': isPysicalEvent,
      'eventName': eventName,
      'eventTime': eventTime,
      'eventId': eventId,
      'gameType': gameType,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      isPysicalEvent: json['isPysicalEvent'] as bool?,
      eventName: json['eventName'] as String?,
      eventTime: json['eventTime'] as String?,
      eventId: json['eventId'] as String?,
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
