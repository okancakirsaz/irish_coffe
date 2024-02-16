class UpdateProfileImageModel {
  String? uid;
  String? imageAsByte;
  String? profileImage;

  UpdateProfileImageModel({
    this.uid,
    this.imageAsByte,
    this.profileImage,
  });

  UpdateProfileImageModel copyWith({
    String? uid,
    String? imageAsByte,
    String? profileImage,
  }) {
    return UpdateProfileImageModel(
      uid: uid ?? this.uid,
      imageAsByte: imageAsByte ?? this.imageAsByte,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'imageAsByte': imageAsByte,
      'profileImage': profileImage,
    };
  }

  factory UpdateProfileImageModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileImageModel(
      uid: json['uid'] as String?,
      imageAsByte: json['imageAsByte'] as String?,
      profileImage: json['profileImage'] as String?,
    );
  }

  @override
  String toString() =>
      "UpdateProfileImageModel(uid: $uid,imageAsByte: $imageAsByte,profileImage: $profileImage)";

  @override
  int get hashCode => Object.hash(uid, imageAsByte, profileImage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateProfileImageModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          imageAsByte == other.imageAsByte &&
          profileImage == other.profileImage;
}
