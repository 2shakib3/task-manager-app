import 'package:flutter/material.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/screens/profile_screen.dart';
import 'package:task_management_app/ui/screens/signin_screen.dart';
import 'package:task_management_app/ui/utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.isProfileScreenOpen = false});

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Md Shakib Hasan',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'shakibspostbox@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                await AuthController.clearUserToken();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninScreen(),
                  ),
                  (_) => false,
                );
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement createElement
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
