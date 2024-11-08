import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management_app/ui/screens/signin_screen.dart';
import 'package:task_management_app/ui/utils/assets_path.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SigninScreen(),
      ),
    );
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
              AssetsPath.logoSvg,
              width: 120,
            )
          ],
        ),
      ),
    ));
  }
}