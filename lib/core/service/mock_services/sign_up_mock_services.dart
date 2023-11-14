import 'package:irish_coffe/core/service/mock_services/login_mock_services.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

class SignUpMockServices {
  post(UserDataModel dataModel) {
    LoginMockServices.dataSet.add(dataModel.toJson());
  }
}
