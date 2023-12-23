import 'dart:typed_data';
import 'package:irish_coffe/core/init/model/lite_user_data_model.dart';

class PostModel {
  LiteUserDataModel? user;
  String? description;
  String? apiImage;
  String? time;
  String? id;

  PostModel({
    this.user,
    this.description,
    this.apiImage,
    this.time,
    this.id,
  });

  PostModel copyWith({
    LiteUserDataModel? user,
    String? description,
    Uint8List? image,
    String? apiImage,
    String? time,
    String? id,
  }) {
    return PostModel(
      user: user ?? this.user,
      description: description ?? this.description,
      time: time ?? this.time,
      apiImage: apiImage ?? this.apiImage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'description': description,
      'time': time,
      'apiImage': apiImage,
      'id': id,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      user: LiteUserDataModel.fromJson(json['user'] as Map<String, dynamic>),
      description: json['description'] as String?,
      apiImage: json['apiImage'] as String?,
      time: json['time'] as String?,
      id: json['id'] as String?,
    );
  }

  @override
  String toString() =>
      "PostModel(user: $user,description: $description,time: $time,id: $id)";

  @override
  int get hashCode => Object.hash(user, description, time, id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          description == other.description &&
          time == other.time &&
          id == other.id;
}
