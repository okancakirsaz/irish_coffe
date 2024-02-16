import 'package:irish_coffe/core/service/mock_services/login_mock_services.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

class SignUpMockServices {
  //TODO: Real server turns user data model implement is
  Future<bool> post(UserDataModel dataModel) async {
    try {
      LoginMockServices.dataSet.add(dataModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
