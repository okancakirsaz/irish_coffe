class FavoreiteFoodsModel {
  String foodName;
  int count;
  String photo;

  FavoreiteFoodsModel({
    required this.foodName,
    required this.count,
    required this.photo,
  });

  FavoreiteFoodsModel copyWith({
    String? foodName,
    int? count,
    String? photo,
  }) {
    return FavoreiteFoodsModel(
      foodName: foodName ?? this.foodName,
      count: count ?? this.count,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'count': count,
      'photo': photo,
    };
  }

  factory FavoreiteFoodsModel.fromJson(Map<String, dynamic> json) {
    return FavoreiteFoodsModel(
      foodName: json['foodName'] as String,
      count: json['count'] as int,
      photo: json['photo'] as String,
    );
  }

  @override
  String toString() =>
      "FavoreiteFoodsModel(foodName: $foodName,count: $count,photo: $photo)";

  @override
  int get hashCode => Object.hash(foodName, count, photo);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoreiteFoodsModel &&
          runtimeType == other.runtimeType &&
          foodName == other.foodName &&
          count == other.count &&
          photo == other.photo;
}
