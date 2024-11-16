import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/ui/controller/progress_screen_controller.dart';
import 'package:task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:task_management_app/ui/widgets/task_card.dart';


class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  static const String progressScreen = '/progress-screen';

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  final ProgressScreenController progressScreenController = Get.find<ProgressScreenController>();

  @override
  void initState() {
    super.initState();
    progressedTaskData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressScreenController>(builder: (controller) {
      return ListView.separated(
      itemCount: controller.progressTaskList.length,
      itemBuilder: (context, index) {
        return TaskCard(
          taskData: controller.progressTaskList[index], onRefreshList: progressedTaskData,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 8,
        );
      },
    );
    },);
  }

  Future<void> progressedTaskData() async {

    final bool result = await progressScreenController.progressedTaskData();

    if (result != true) {
      showSnackBarMessage(
          context, progressScreenController.errorMessage!, true);
    }
  }
  

}
