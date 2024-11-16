import 'dart:convert';

// Profile Update Models

class ProfileUpdateRequestModel {
  String email;
  String firstName;
  String lastName;
  String mobile;
  String password;

  ProfileUpdateRequestModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.password,
  });

  // To JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password,
    };
  }
}

class ProfileUpdateResponseModel {
  String status;
  dynamic data;

  ProfileUpdateResponseModel({required this.status, this.data});

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponseModel(
      status: json['status'],
      data: json['data'],
    );
  }
}

// Forgot Password Models

class ForgotPasswordRequestModel {
  String email;

  ForgotPasswordRequestModel({required this.email});

  // To JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class ForgotPasswordOtpVerificationModel {
  String email;
  String otp;

  ForgotPasswordOtpVerificationModel({
    required this.email,
    required this.otp,
  });

  // To JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'OTP': otp,
    };
  }
}

class ForgotPasswordResponseModel {
  String status;
  String data;

  ForgotPasswordResponseModel({required this.status, required this.data});

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      status: json['status'],
      data: json['data'],
    );
  }
}

class ResetPasswordRequestModel {
  String email;
  String otp;
  String newPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  // To JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'OTP': otp,
      'password': newPassword,
    };
  }
}
