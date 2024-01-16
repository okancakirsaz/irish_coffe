class PostIdSendRequestModel {
  String? postId;
  String? token;

  PostIdSendRequestModel({this.postId, this.token});

  PostIdSendRequestModel copyWith({
    String? postId,
    String? token,
  }) {
    return PostIdSendRequestModel(
      postId: postId ?? this.postId,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {'postId': postId, 'token': token};
  }

  factory PostIdSendRequestModel.fromJson(Map<String, dynamic> json) {
    return PostIdSendRequestModel(
        postId: json['postId'] as String?, token: json['token'] as String?);
  }

  @override
  String toString() => "PostIdSendRequestModel(postId: $postId)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostIdSendRequestModel &&
          runtimeType == other.runtimeType &&
          postId == other.postId;
}
