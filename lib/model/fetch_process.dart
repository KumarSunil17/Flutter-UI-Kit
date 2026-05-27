import 'package:flutter_uikit/services/network_service_response.dart';

enum ApiType { performOTP, performLogin, getProductInfo }

class FetchProcess<T> {
  ApiType? type;
  bool loading;
  NetworkServiceResponse<T>? response;

  FetchProcess({this.loading = false, this.response, this.type});
}
