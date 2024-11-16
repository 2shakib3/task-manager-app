import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';
import 'package:task_management_app/ui/screens/signin_screen.dart';
import 'package:task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    _inProgress = true;
    setState(() {});

    final Map<String, dynamic> body = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text.trim(),
    };

    NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.resetPassword, body: body);

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      ShowSnackBarMessage(context, 'Password reset successfully!', false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SigninScreen()),
            (_) => false,
      );
    } else {
      ShowSnackBarMessage(
          context, response.errorMessage ?? 'Password reset failed', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration:
                  const InputDecoration(hintText: 'Enter new password'),
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Enter a valid password' : null,
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: !_inProgress,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _resetPassword,
                    child: const Text('Reset Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    super.dispose();
  }
}
