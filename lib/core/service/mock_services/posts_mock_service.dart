import 'package:irish_coffe/views/community/models/post_model.dart';

class PostsMockService {
  Future<List<PostModel>> getPosts() async {
    List<PostModel> modelList = [];
    for (var data in dataSet) {
      modelList.add(PostModel.fromJson(data));
    }
    return modelList;
  }

  Future<void> postNewPost(PostModel data) async {
    dataSet.add(data.toJson());
  }

  static List<Map<String, dynamic>> dataSet = [];
}
