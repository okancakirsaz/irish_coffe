class DuelInviteModel {
  String itemName;
  int itemCount;
  String gameName;
  String challengedUserId;
  String challengedUserName;
  String? challengedUserProfileImage;
  String challengerUserName;
  String? challengerUserProfileImage;
  String challengerUserId;
  String challengerUserGender;
  String challengedUserGender;

  DuelInviteModel(
      {required this.itemName,
      required this.itemCount,
      required this.gameName,
      required this.challengedUserId,
      required this.challengedUserName,
      required this.challengedUserProfileImage,
      required this.challengerUserName,
      required this.challengerUserProfileImage,
      required this.challengerUserId,
      required this.challengerUserGender,
      required this.challengedUserGender});

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemCount': itemCount,
      'gameName': gameName,
      'challengedUserId': challengedUserId,
      'challengedUserName': challengedUserName,
      'challengedUserProfileImage': challengedUserProfileImage,
      'challengerUserName': challengerUserName,
      'challengerUserProfileImage': challengerUserProfileImage,
      'challengerUserId': challengerUserId,
      'challengerUserGender': challengerUserGender,
      'challengedUserGender': challengedUserGender
    };
  }

  factory DuelInviteModel.fromJson(Map<String, dynamic> json) {
    return DuelInviteModel(
        itemName: json['itemName'] as String,
        itemCount: json['itemCount'] as int,
        gameName: json['gameName'] as String,
        challengedUserId: json['challengedUserId'] as String,
        challengedUserName: json['challengedUserName'] as String,
        challengedUserProfileImage:
            json['challengedUserProfileImage'] as String?,
        challengerUserName: json['challengerUserName'] as String,
        challengerUserProfileImage:
            json['challengerUserProfileImage'] as String?,
        challengerUserId: json['challengerUserId'] as String,
        challengedUserGender: json['challengedUserGender'] as String,
        challengerUserGender: json['challengerUserGender'] as String);
  }

  @override
  String toString() =>
      "DuelInviteModel(itemName: $itemName,itemCount: $itemCount,gameName: $gameName,challengedUserId: $challengedUserId,challengedUserName: $challengedUserName,challengedUserProfileImage: $challengedUserProfileImage,challengerUserName: $challengerUserName,challengerUserProfileImage: $challengerUserProfileImage)";

  @override
  int get hashCode => Object.hash(
      itemName,
      itemCount,
      gameName,
      challengedUserId,
      challengedUserName,
      challengedUserProfileImage,
      challengerUserName,
      challengerUserProfileImage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DuelInviteModel &&
          runtimeType == other.runtimeType &&
          itemName == other.itemName &&
          itemCount == other.itemCount &&
          gameName == other.gameName &&
          challengedUserId == other.challengedUserId &&
          challengedUserName == other.challengedUserName &&
          challengedUserProfileImage == other.challengedUserProfileImage &&
          challengerUserName == other.challengerUserName &&
          challengerUserProfileImage == other.challengerUserProfileImage;
}
