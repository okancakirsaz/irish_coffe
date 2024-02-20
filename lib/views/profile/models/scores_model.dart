class ScoresModel {
  String userName;
  String userId;
  String challengedUserName;
  bool isWinned;
  String game;

  ScoresModel({
    required this.userName,
    required this.userId,
    required this.challengedUserName,
    required this.isWinned,
    required this.game,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userId': userId,
      'challengedUserName': challengedUserName,
      'isWinned': isWinned,
      'game': game,
    };
  }

  factory ScoresModel.fromJson(Map<String, dynamic> json) {
    return ScoresModel(
      userName: json['userName'] as String,
      userId: json['userId'] as String,
      challengedUserName: json['challengedUserName'] as String,
      isWinned: json['isWinned'] as bool,
      game: json['game'] as String,
    );
  }

  @override
  String toString() =>
      "ScoresModel(userName: $userName,challengedUserName: $challengedUserName,isWinned: $isWinned,game: $game)";

  @override
  int get hashCode => Object.hash(userName, challengedUserName, isWinned, game);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoresModel &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          challengedUserName == other.challengedUserName &&
          isWinned == other.isWinned &&
          game == other.game;
}
