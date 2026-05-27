import 'package:flutter_uikit/services/abstract/i_otp_service.dart';
import 'package:flutter_uikit/services/mock/mock_otp_service.dart';
import 'package:flutter_uikit/services/real/real_otp_service.dart';
import 'package:flutter_uikit/services/restclient.dart';

enum Flavor { mock, pro }

class Injector {
  static final Injector _singleton = Injector._internal();
  static late Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() => _singleton;

  Injector._internal();

  IOTPService get otpService {
    switch (_flavor) {
      case Flavor.mock:
        return MockOTPService();
      case Flavor.pro:
        return OTPService(RestClient());
    }
  }
}
