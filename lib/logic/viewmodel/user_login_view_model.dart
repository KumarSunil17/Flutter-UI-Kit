import 'dart:async';

import 'package:flutter_uikit/di/dependency_injection.dart';
import 'package:flutter_uikit/model/login.dart';
import 'package:flutter_uikit/model/otp.dart';
import 'package:flutter_uikit/services/abstract/i_otp_service.dart';
import 'package:flutter_uikit/services/network_service_response.dart';

class UserLoginViewModel {
  String phonenumber;
  String? otp;
  bool otpResult = false;
  late NetworkServiceResponse apiResult;
  final IOTPService otpRepo = Injector().otpService;

  UserLoginViewModel({required this.phonenumber});

  UserLoginViewModel.withOTP({required this.phonenumber, required this.otp});

  Future<void> getOtp(String phoneNumber) async {
    final NetworkServiceResponse<CreateOTPResponse> result =
        await otpRepo.createOTP(phoneNumber);
    otpResult = result.success;
    apiResult = result;
  }

  Future<void> performLogin(UserLoginViewModel userLogin) async {
    final NetworkServiceResponse<OTPResponse> result =
        await otpRepo.fetchOTPLoginResponse(
            Login(phonenumber: userLogin.phonenumber, otp: userLogin.otp!));
    apiResult = result;
  }
}
