import 'package:irish_coffe/views/community/models/currently_in_irish_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';

class CommunityMockService {
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    List<PostModel> modelList = [];
    for (var data in posts) {
      modelList.add(PostModel.fromJson(data));
    }
    return modelList;
  }

  Future<List<PostModel>> getMorePosts(String date) async {
    List<PostModel> modelList = [];
    for (var data in gettedMorePosts) {
      modelList.add(PostModel.fromJson(data));
    }
    return modelList;
  }

  postNewPost(PostModel data) {
    //Nothing.
  }

  Future<List<CurrentlyInIrishModel>>? getWhoInIrishData() async {
    await Future.delayed(const Duration(seconds: 1));
    List<CurrentlyInIrishModel> modelList = [];
    for (var data in currentlyInIrish) {
      modelList.add(CurrentlyInIrishModel.fromJson(data));
    }
    return modelList;
  }

  static List<Map<String, dynamic>> posts = [
    {
      "user": {
        "token": "UFC123JAOKF0P0ICdas",
        "name": "İrem Abdestsizyatmazoğulları",
        "profileImage": null,
        "gender": "Kadın"
      },
      "description": "Slayy",
      "apiImage":
          "https://i.pinimg.com/736x/e2/6f/c2/e26fc2050cd0ef606112ca18388a7264.jpg",
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
    {
      "user": {
        "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
        "name": "Volkan Konak",
        "profileImage":
            "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg",
        "gender": "Erkek"
      },
      "description": "Merhaba ben Volkan Konak",
      "apiImage":
          "https://i.pinimg.com/236x/e9/f8/60/e9f860c5f3c43baf6eaf408cb58a63c0.jpg",
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdsadas"
    },
  ];

  static List<Map<String, dynamic>> gettedMorePosts = [
    {
      "user": {
        "token": "UFC123JAOKF0P0ICdas",
        "name": "İrem Abdestsizyatmazoğulları",
        "profileImage": null,
        "gender": "Kadın"
      },
      "description": "Child Predator Slayyy",
      "apiImage":
          "https://images1.memedroid.com/images/UPLOADED6/506600d9db297.jpeg",
      "time": "12.11.2023 16:23",
      "id": "sdsds-dasdsa-dasdsa-dafdsfdsfhsssdas"
    },
    {
      "user": {
        "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
        "name": "Volkan Konak",
        "profileImage":
            "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg",
        "gender": "Erkek"
      },
      "description": "2. Dünya Savaşında bir yahudi",
      "apiImage":
          "https://apelasyon.com/images/icerikler/sabun-apelasyon-60b2b4955cdd2.jpg",
      "time": "05.11.2023 13:00",
      "id": "sdsds-dasdsa-dasdsa-dasdgdhshdas"
    }
  ];

  static List<Map<String, dynamic>> currentlyInIrish = [
    {
      "name": "Volkan Konak",
      "gender": "Erkek",
      "index": 1,
      "isAnonym": false,
      "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
      "profileImage":
          "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg"
    },
    {
      "name": "İrem Abdestsizyatmazoğulları",
      "gender": "Kadın",
      "index": 2,
      "isAnonym": false,
      "token": "UFC123JAOKF0P0ICdas",
      "profileImage": null
    },
    {
      "name": "Süleyman Soyluluğutartışılıroğulları",
      "gender": "Belirtmek İstemiyorum",
      "index": 3,
      "isAnonym": false,
      "token": "orspıucocy",
      "profileImage": null
    },
    {
      "name": "Volkan Konak",
      "gender": "Erkek",
      "index": 1,
      "isAnonym": false,
      "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
      "profileImage":
          "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg"
    },
    {
      "name": "İrem Abdestsizyatmazoğulları",
      "gender": "Kadın",
      "index": 2,
      "isAnonym": false,
      "token": "UFC123JAOKF0P0ICdas",
      "profileImage": null
    },
    {
      "name": "Süleyman Soyluluğutartışılıroğulları",
      "gender": "Belirtmek İstemiyorum",
      "index": 3,
      "isAnonym": false,
      "token": "orspıucocy",
      "profileImage": null
    },
    {
      "name": "Keziban Materyılgörloğulları",
      "gender": "Kadın",
      "index": 4,
      "isAnonym": true,
      "token": "saodsajfıhsaofp",
      "profileImage": null
    },
    {
      "name": "Bernand Redflag",
      "gender": "Belirtmek İstemiyorum",
      "index": 5,
      "isAnonym": false,
      "token": "anasınıs2ktinekonominin",
      "profileImage": "https://abcgazetesi.com/d/news/8331.jpg"
    },
    {
      "name": "Adnan Arrowtar",
      "gender": "Erkek",
      "index": 6,
      "isAnonym": true,
      "token": "u0p",
      "profileImage": null
    },
    {
      "name": "Hacer Hacıyatmaz",
      "gender": "Kadın",
      "index": 7,
      "isAnonym": false,
      "token": "dsadsadsadsa",
      "profileImage": null
    },
    {
      "name": "Sümeyye Redflag",
      "gender": "Kadın",
      "index": 8,
      "isAnonym": false,
      "token": "ıoFJPOS",
      "profileImage": "https://abcgazetesi.com/d/news/8331.jpg"
    }
  ];

  static List emptyList = [];
}
