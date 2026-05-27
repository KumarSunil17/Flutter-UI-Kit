class CreateOTPResponse {
  String status;
  CreateOTPResponse({required this.status});

  CreateOTPResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String;
}

class OTPResponse {
  String status;
  OTPData data;
  OTPResponse({required this.status, required this.data});

  OTPResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String,
        data = OTPData.fromJson(json['data'] as Map<String, dynamic>);
}

class OTPData {
  final String authToken;
  final String userId;
  const OTPData({required this.authToken, required this.userId});

  OTPData.fromJson(Map<String, dynamic> json)
      : authToken = json['authToken'] as String,
        userId = json['userId'] as String;
}
