import 'package:irish_coffe/views/menu/models/menu_item_model.dart';

class MenuMockServices {
  Future<List<MenuItemModel>> getMenu() async {
    List<MenuItemModel> menuList = [];
    for (var data in dataSet) {
      menuList.add(MenuItemModel.fromJson(data));
    }
    return menuList;
  }

  static final List<Map<String, dynamic>> dataSet = [
    {
      "img":
          "https://i.pinimg.com/236x/9f/dd/2e/9fdd2e13bb9c99d23350bb8b050db05e.jpg",
      "name": "Irish Pizza",
      "price": "90₺",
      "materials": ["margarita pizza"],
    },
    {
      "img":
          "https://i.pinimg.com/236x/7f/81/2f/7f812f50be9049539db0ce1f95f253c9.jpg",
      "name": "Irish Püre",
      "price": "70₺",
      "materials": ["patates", "süt"],
    },
    {
      "img":
          "https://i.pinimg.com/236x/f4/23/93/f423935974551590a30d651c3c915c5f.jpg",
      "name": "Irish Special",
      "price": "140₺",
      "materials": ["patates", "süt", "kabak"],
    },
    {
      "img":
          "https://i.pinimg.com/236x/9c/e7/d4/9ce7d4bdfc826989bdacc804525d8e21.jpg",
      "name": "Irish Coffe",
      "price": "50₺",
      "materials": ["patates", "süt", "kahve"],
    },
    {
      "img":
          "https://i.pinimg.com/236x/aa/30/f3/aa30f3ecca16ac719e23edb4837fa6cb.jpg",
      "name": "Irish Dondurma",
      "price": "90₺",
      "materials": ["dondurma", "çikolata"],
    },
    {
      "img":
          "https://i.pinimg.com/236x/23/42/43/23424317bb4bff6656941d675245bf6f.jpg",
      "name": "Cola",
      "price": "30₺",
      "materials": ["coca cola"],
    },
  ];
}
