import 'package:irish_coffe/core/init/model/lite_user_data_model.dart';

class PostModel {
  LiteUserDataModel? user;
  String? description;
  String? apiImage;
  String? time;
  String? timestamp;
  String? imageAsByte;
  String? id;

  PostModel({
    this.user,
    this.description,
    this.apiImage,
    this.time,
    this.timestamp,
    this.imageAsByte,
    this.id,
  });

  PostModel copyWith({
    LiteUserDataModel? user,
    String? description,
    String? apiImage,
    String? time,
    String? timestamp,
    String? imageAsByte,
    String? id,
  }) {
    return PostModel(
      user: user ?? this.user,
      description: description ?? this.description,
      time: time ?? this.time,
      timestamp: timestamp ?? this.timestamp,
      apiImage: apiImage ?? this.apiImage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'description': description,
      'time': time,
      'timestamp': timestamp,
      'imageAsByte': imageAsByte,
      'apiImage': apiImage,
      'id': id,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      user: LiteUserDataModel.fromJson(json['user'] as Map<String, dynamic>),
      description: json['description'] as String?,
      apiImage: json['apiImage'] as String?,
      imageAsByte: json['imageAsByte'] as String?,
      time: json['time'] as String?,
      timestamp: json['timestamp'] as String?,
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
