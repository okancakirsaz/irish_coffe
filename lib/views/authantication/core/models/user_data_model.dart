import '../../../community/models/post_model.dart';
import '../../../profile/models/favorite_foods_model.dart';
import '../../../profile/models/scores_model.dart';

class UserDataModel {
  String? email;
  String? password;
  String? token;
  String? uid;
  String? name;
  String? gender;
  String? profileImage;
  String? phoneNumber;
  List<PostModel>? posts;
  List<ScoresModel>? scores;
  List<FavoreiteFoodsModel>? favoriteFoods;
  bool? isAnonym;

  UserDataModel(
      {this.email,
      this.password,
      this.token,
      this.uid,
      this.name,
      this.gender,
      this.profileImage,
      this.phoneNumber,
      this.posts,
      this.scores,
      this.favoriteFoods,
      this.isAnonym});

  UserDataModel copyWith(
      {String? email,
      String? password,
      String? token,
      String? uid,
      String? name,
      String? gender,
      String? profileImage,
      String? phoneNumber,
      List<PostModel>? posts,
      List<ScoresModel>? scores,
      List<FavoreiteFoodsModel>? favoriteFoods,
      bool? isAnonym}) {
    return UserDataModel(
        email: email ?? this.email,
        password: password ?? this.password,
        token: token ?? this.token,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        profileImage: profileImage ?? this.profileImage,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        posts: posts ?? this.posts,
        scores: scores ?? this.scores,
        favoriteFoods: favoriteFoods ?? this.favoriteFoods,
        isAnonym: isAnonym ?? this.isAnonym);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
      'uid': uid,
      'name': name,
      'gender': gender,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'posts': posts,
      'scores': scores,
      'favoriteFoods': favoriteFoods,
      'isAnonym': isAnonym
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        email: json['email'] as String?,
        password: json['password'] as String?,
        token: json['token'] as String?,
        uid: json['uid'] as String?,
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
            ?.map(
                (e) => FavoreiteFoodsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        isAnonym: json['isAnonym'] as bool?);
  }

  @override
  String toString() =>
      "UserDataModel(email: $email,password: $password,token: $token,name: $name,gender: $gender,profileImage: $profileImage,phoneNumber: $phoneNumber,posts: $posts,scores: $scores,favoriteFoods: $favoriteFoods)";

  @override
  int get hashCode => Object.hash(email, password, token, name, gender,
      profileImage, phoneNumber, posts, scores, favoriteFoods);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
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
