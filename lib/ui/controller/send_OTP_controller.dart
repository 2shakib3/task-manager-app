import 'package:get/get.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';

class SendOtpController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  String? userEmail;
  Future<bool> sendOTP(String email) async {
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.recoveryVarifiedEmail(email));

    if (response.isSuccess) {
      userEmail = email;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = true;
    update();

    return isSuccess;
  }
}
