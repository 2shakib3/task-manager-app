import 'package:get/get.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';

class AddTaskController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.creatTask, requestBody);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
