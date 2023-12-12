import 'dart:typed_data';

import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

class PostModel {
  UserDataModel? user;
  String? description;
  Uint8List? image;
  String? apiImage;
  String? time;
  String? id;

  PostModel({
    this.user,
    this.description,
    this.image,
    this.apiImage,
    this.time,
    this.id,
  });

  PostModel copyWith({
    UserDataModel? user,
    String? description,
    Uint8List? image,
    String? apiImage,
    String? time,
    String? id,
  }) {
    return PostModel(
      user: user ?? this.user,
      description: description ?? this.description,
      image: image ?? this.image,
      time: time ?? this.time,
      apiImage: apiImage ?? this.apiImage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'description': description,
      'image': image,
      'time': time,
      'apiImage': apiImage,
      'id': id,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      user: json['user'] as UserDataModel?,
      description: json['description'] as String?,
      image: json['image'] as Uint8List,
      apiImage: json['apiImage'] as String?,
      time: json['time'] as String?,
      id: json['id'] as String?,
    );
  }

  @override
  String toString() =>
      "PostModel(user: $user,description: $description,image: $image,time: $time,id: $id)";

  @override
  int get hashCode => Object.hash(user, description, image, time, id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          description == other.description &&
          image == other.image &&
          time == other.time &&
          id == other.id;
}
