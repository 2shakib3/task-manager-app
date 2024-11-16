import 'package:get/get.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/models/task_list_model.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';

class ProgressScreenController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List _progressTaskList = [];

  List get progressTaskList => _progressTaskList;

  Future<bool> progressedTaskData() async {
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.showProgressedTask);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _progressTaskList = taskListModel.tasklist ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
