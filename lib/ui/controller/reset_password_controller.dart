import 'package:get/get.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';

class ResetPasswordController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> changePassword(String email, String otp, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.recoverResetPassword, requestBody);

    if (response.isSuccess) {
     isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = true;
    update();

    return isSuccess;
  }
}
