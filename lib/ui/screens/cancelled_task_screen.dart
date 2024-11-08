import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/models/task_list_model.dart';
import 'package:task_management_app/data/models/task_model.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';
import 'package:task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:task_management_app/ui/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !_getCancelledTaskListInProgress,
        replacement: const CircularProgressIndicator(),
      child: ListView.separated(
        itemCount: _cancelledTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskModel: _cancelledTaskList[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }


  Future<void> _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskListInProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.cancelledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      ShowSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
