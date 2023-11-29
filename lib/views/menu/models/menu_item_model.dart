class MenuItemModel {
  String? img;
  String? name;
  String? price;
  List<String>? materials;

  MenuItemModel({
    this.img,
    this.name,
    this.price,
    this.materials,
  });

  MenuItemModel copyWith({
    String? img,
    String? name,
    String? price,
    List<String>? materials,
  }) {
    return MenuItemModel(
      img: img ?? this.img,
      name: name ?? this.name,
      price: price ?? this.price,
      materials: materials ?? this.materials,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'name': name,
      'price': price,
      'materials': materials,
    };
  }

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      img: json['img'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  @override
  String toString() =>
      "MenuItemModel(img: $img,name: $name,price: $price,materials: $materials)";

  @override
  int get hashCode => Object.hash(img, name, price, materials);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemModel &&
          runtimeType == other.runtimeType &&
          img == other.img &&
          name == other.name &&
          price == other.price &&
          materials == other.materials;
}
