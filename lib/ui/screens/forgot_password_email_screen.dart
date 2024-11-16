import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';
import 'package:task_management_app/ui/screens/forgot_password_otp_screen.dart';
import 'package:task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  bool _inProgress = false;

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    _inProgress = true;
    setState(() {});

    final String url = Urls.sendOTP(_emailTEController.text.trim());
    NetworkResponse response = await NetworkCaller.getRequest(url: url);

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      ShowSnackBarMessage(context, 'OTP sent successfully!', false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordOtpScreen(
            email: _emailTEController.text.trim(),
          ),
        ),
      );
    } else {
      ShowSnackBarMessage(
          context, response.errorMessage ?? 'Failed to send OTP', true);
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
                  'Forgot Password',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email Address'),
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: !_inProgress,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _sendOtp,
                    child: const Text('Send OTP'),
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
    _emailTEController.dispose();
    super.dispose();
  }
}
