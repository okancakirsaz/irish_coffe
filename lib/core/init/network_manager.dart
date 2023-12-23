import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkManager {
  NetworkManager() {
    fetchBaseUrl();
  }
  final Dio network = Dio();
  final String baseUrlDev =
      "https://3b95b97c-5ed8-4a42-b107-f72eef4d706c.mock.pstmn.io";

  //TODO: Use base product url
  final String baseUrlProduct =
      "https://3b95b97c-5ed8-4a42-b107-f72eef4d706c.mock.pstmn.io";

  fetchBaseUrl() {
    if (kDebugMode) {
      network.options.baseUrl = baseUrlDev;
    } else {
      network.options.baseUrl = baseUrlProduct;
    }
  }
}
