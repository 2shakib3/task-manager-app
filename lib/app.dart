import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/ui/Utils/app_colors.dart';
import 'package:task_management_app/ui/screens/Forgot_Password_OTP_Screen.dart';
import 'package:task_management_app/ui/screens/Home_New_screen.dart';
import 'package:task_management_app/ui/screens/cancelled_task_screen.dart';
import 'package:task_management_app/ui/screens/completed_task_screen.dart';
import 'package:task_management_app/ui/screens/forgot_password_email_screen.dart';
import 'package:task_management_app/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_management_app/ui/screens/new_task_screen.dart';
import 'package:task_management_app/ui/screens/profile_screen.dart';
import 'package:task_management_app/ui/screens/progress_task_screen.dart';
import 'package:task_management_app/ui/screens/reset_password_screen.dart';
import 'package:task_management_app/ui/screens/signin_screen.dart';
import 'package:task_management_app/ui/screens/signup_screen.dart';
import 'package:task_management_app/ui/screens/splash_screen.dart';

import 'binding.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});
  
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StateBinder(),
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(  
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: inputDecoration(),
        elevatedButtonTheme: elevatedBottunThemeData()
        
      ),
      initialRoute: '/',
      routes: {
         
         SplashScreen.splashScreen:  (context) => const SplashScreen(),
         SignInScreen.signInScreen:  (context) => const SignInScreen(),
         SignUpScreen.signUpScreen:  (context) => const SignUpScreen(),
         FotgotPasswordOtpScreen.varificationScreen:  (context) => FotgotPasswordOtpScreen(),
         FotgotPasswordEmailScreen.otpScreen:  (context) =>  FotgotPasswordEmailScreen(),
         ResetPasswordScreen.resetPasswordScreen:  (context) =>  ResetPasswordScreen(),
         ProfileScreen.updateProfileScreen:  (context) =>  const ProfileScreen(),
         
         
         MainButtonNavbarScreen.homeScreen:  (context) => const MainButtonNavbarScreen(),
         NewScreen.newScreen:  (context) => const NewScreen(),
         CompletedScreen.completedScreen:  (context) => const CompletedScreen(),
         CancelScreen.canceledScreen:  (context) => const CancelScreen(),
         ProgressScreen.progressScreen:  (context) => const ProgressScreen(),       
         NewTaskScreen.addScreen:  (context) => const NewTaskScreen(),       

      },
    );
    
  }


  InputDecorationTheme inputDecoration() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(fontWeight: FontWeight.w300),
      fillColor: Colors.white,
      filled: true,
      border: inputBorder(),
      enabledBorder: inputBorder(),
      focusedBorder: inputBorder(),
      errorBorder: inputBorder(),
    );
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }

  
  ElevatedButtonThemeData elevatedBottunThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),
      );
  }
}
