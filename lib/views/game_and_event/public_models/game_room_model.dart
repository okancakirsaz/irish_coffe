class GameRoomModel {
  String challengerUserId;
  String challengerUserName;
  int? challengerUserScore;
  String challengedUserId;
  String challengedUserName;
  int? challengedUserScore;
  String gameId;

  GameRoomModel({
    required this.challengerUserId,
    required this.challengerUserName,
    required this.challengerUserScore,
    required this.challengedUserId,
    required this.challengedUserName,
    required this.challengedUserScore,
    required this.gameId,
  });

  Map<String, dynamic> toJson() {
    return {
      'challengerUserId': challengerUserId,
      'challengerUserName': challengerUserName,
      'challengerUserScore': challengerUserScore,
      'challengedUserId': challengedUserId,
      'challengedUserName': challengedUserName,
      'challengedUserScore': challengedUserScore,
      'gameId': gameId,
    };
  }

  factory GameRoomModel.fromJson(Map<String, dynamic> json) {
    return GameRoomModel(
      challengerUserId: json['challengerUserId'] as String,
      challengerUserName: json['challengerUserName'] as String,
      challengerUserScore: json['challengerUserScore'] as int?,
      challengedUserId: json['challengedUserId'] as String,
      challengedUserName: json['challengedUserName'] as String,
      challengedUserScore: json['challengedUserScore'] as int?,
      gameId: json['gameId'] as String,
    );
  }

  @override
  String toString() =>
      "GameRoomModel(challengerUserId: $challengerUserId,challengerUserName: $challengerUserName,challengerUserScore: $challengerUserScore,challengedUserId: $challengedUserId,challengedUserName: $challengedUserName,challengedUserScore: $challengedUserScore,gameId: $gameId)";

  @override
  int get hashCode => Object.hash(
      challengerUserId,
      challengerUserName,
      challengerUserScore,
      challengedUserId,
      challengedUserName,
      challengedUserScore,
      gameId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameRoomModel &&
          runtimeType == other.runtimeType &&
          challengerUserId == other.challengerUserId &&
          challengerUserName == other.challengerUserName &&
          challengerUserScore == other.challengerUserScore &&
          challengedUserId == other.challengedUserId &&
          challengedUserName == other.challengedUserName &&
          challengedUserScore == other.challengedUserScore &&
          gameId == other.gameId;
}
