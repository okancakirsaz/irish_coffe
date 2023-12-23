class PostIdSendRequestModel {
  String? postId;

  PostIdSendRequestModel({
    this.postId,
  });

  PostIdSendRequestModel copyWith({
    String? postId,
  }) {
    return PostIdSendRequestModel(
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
    };
  }

  factory PostIdSendRequestModel.fromJson(Map<String, dynamic> json) {
    return PostIdSendRequestModel(
      postId: json['postId'] as String?,
    );
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
