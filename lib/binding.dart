import 'package:get/get.dart';
import 'package:task_management_app/ui/controller/add_task_controller.dart';
import 'package:task_management_app/ui/controller/canceled_taskData_controller.dart';
import 'package:task_management_app/ui/controller/complete_screen_controller.dart';
import 'package:task_management_app/ui/controller/get_status_count_controller.dart';
import 'package:task_management_app/ui/controller/new_taskList_controller.dart';
import 'package:task_management_app/ui/controller/progress_screen_controller.dart';
import 'package:task_management_app/ui/controller/reset_password_controller.dart';
import 'package:task_management_app/ui/controller/send_OTP_controller.dart';
import 'package:task_management_app/ui/controller/sign_in_controller.dart';
import 'package:task_management_app/ui/controller/sign_up_controller.dart';
import 'package:task_management_app/ui/controller/update_profile_controller.dart';
import 'package:task_management_app/ui/controller/varification_controller.dart';

class StateBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(GetStatusCountController());
    Get.put(CanceledTaskdataController());
    Get.put(CompleteScreenController());
    Get.put(ProgressScreenController());
    Get.put(SignUpController());
    Get.put(UpdateProfileController());
    Get.put(SendOtpController());
    Get.put(VarificationController());
    Get.put(ResetPasswordController());
    Get.put(AddTaskController());

  }
  
}