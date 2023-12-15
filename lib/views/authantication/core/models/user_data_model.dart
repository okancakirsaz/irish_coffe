import '../../../community/models/post_model.dart';
import '../../../profile/models/favorite_foods_model.dart';
import '../../../profile/models/scores_model.dart';

class UserDataModel {
  String? eMail;
  String? password;
  String? token;
  String? name;
  String? gender;
  String? profileImage;
  String? phoneNumber;
  List<PostModel>? posts;
  List<ScoresModel>? scores;
  List<FavoreiteFoodsModel>? favoriteFoods;

  UserDataModel({
    this.eMail,
    this.password,
    this.token,
    this.name,
    this.gender,
    this.profileImage,
    this.phoneNumber,
    this.posts,
    this.scores,
    this.favoriteFoods,
  });

  UserDataModel copyWith({
    String? eMail,
    String? password,
    String? token,
    String? name,
    String? gender,
    String? profileImage,
    String? phoneNumber,
    List<PostModel>? posts,
    List<ScoresModel>? scores,
    List<FavoreiteFoodsModel>? favoriteFoods,
  }) {
    return UserDataModel(
      eMail: eMail ?? this.eMail,
      password: password ?? this.password,
      token: token ?? this.token,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      posts: posts ?? this.posts,
      scores: scores ?? this.scores,
      favoriteFoods: favoriteFoods ?? this.favoriteFoods,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'e_mail': eMail,
      'password': password,
      'token': token,
      'name': name,
      'gender': gender,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'posts': posts,
      'scores': scores,
      'favoriteFoods': favoriteFoods,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      eMail: json['e_mail'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      profileImage: json['profileImage'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      scores: (json['scores'] as List<dynamic>?)
          ?.map((e) => ScoresModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoriteFoods: (json['favoriteFoods'] as List<dynamic>?)
          ?.map((e) => FavoreiteFoodsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() =>
      "UserDataModel(eMail: $eMail,password: $password,token: $token,name: $name,gender: $gender,profileImage: $profileImage,phoneNumber: $phoneNumber,posts: $posts,scores: $scores,favoriteFoods: $favoriteFoods)";

  @override
  int get hashCode => Object.hash(eMail, password, token, name, gender,
      profileImage, phoneNumber, posts, scores, favoriteFoods);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModel &&
          runtimeType == other.runtimeType &&
          eMail == other.eMail &&
          password == other.password &&
          token == other.token &&
          name == other.name &&
          gender == other.gender &&
          profileImage == other.profileImage &&
          phoneNumber == other.phoneNumber &&
          posts == other.posts &&
          scores == other.scores &&
          favoriteFoods == other.favoriteFoods;
}
