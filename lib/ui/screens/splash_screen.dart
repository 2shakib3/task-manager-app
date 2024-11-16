import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_management_app/ui/utils/assets_path.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String splashScreen = '/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _movetoNewScreen();
    super.initState();
  }

  Future<void> _movetoNewScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    await AuthController.getAccessToken();
    await AuthController.getUserData();
    if (AuthController.isLoggedIn()) {
      Get.offNamed(MainButtonNavbarScreen.homeScreen);
    } else {
      Get.offNamed(MainButtonNavbarScreen.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetPath.logoPath,
              width: 150,
            ),
          ],
        ),
      ),
    ));
  }
}
