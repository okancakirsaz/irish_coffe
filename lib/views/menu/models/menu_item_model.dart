class MenuItemModel {
  String? image;
  String? name;
  String? price;
  List<String>? materials;

  MenuItemModel({
    this.image,
    this.name,
    this.price,
    this.materials,
  });

  MenuItemModel copyWith({
    String? image,
    String? name,
    String? price,
    List<String>? materials,
  }) {
    return MenuItemModel(
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      materials: materials ?? this.materials,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'materials': materials,
    };
  }

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      image: json['image'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  @override
  String toString() =>
      "MenuItemModel(image: $image,name: $name,price: $price,materials: $materials)";

  @override
  int get hashCode => Object.hash(image, name, price, materials);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemModel &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          name == other.name &&
          price == other.price &&
          materials == other.materials;
}
