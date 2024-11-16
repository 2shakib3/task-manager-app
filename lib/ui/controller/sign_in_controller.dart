import 'package:get/get.dart';
import 'package:task_management_app/data/models/list_model.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';

class SignInController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress; 
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  

  Future<bool> signInSystem(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {"email": email, "password": password};

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, requestBody);

    if (response.isSuccess) {
      print('ResponseData : ${response.responseData}');
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token.toString());
      await AuthController.saveUserData(loginModel.data!);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
