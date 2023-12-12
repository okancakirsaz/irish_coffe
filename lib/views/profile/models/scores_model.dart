class ScoresModel {
  String userName;
  String challengedUserName;
  bool isWinned;
  String game;

  ScoresModel({
    required this.userName,
    required this.challengedUserName,
    required this.isWinned,
    required this.game,
  });

  ScoresModel copyWith({
    String? userName,
    String? challengedUserName,
    bool? isWinned,
    String? game,
  }) {
    return ScoresModel(
      userName: userName ?? this.userName,
      challengedUserName: challengedUserName ?? this.challengedUserName,
      isWinned: isWinned ?? this.isWinned,
      game: game ?? this.game,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'challengedUserName': challengedUserName,
      'isWinned': isWinned,
      'game': game,
    };
  }

  factory ScoresModel.fromJson(Map<String, dynamic> json) {
    return ScoresModel(
      userName: json['userName'] as String,
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
