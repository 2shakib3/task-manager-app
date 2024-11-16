import 'package:get/get.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';

class VarificationController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String? userEmail;
  String? userOtp;

  Future<bool> varification(String email, String otp) async {
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.recoverVerifyOtp(email, otp));

    if (response.isSuccess) {
      userEmail = email;
      userOtp = otp;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = true;
    update();

    return isSuccess;
  }
}
