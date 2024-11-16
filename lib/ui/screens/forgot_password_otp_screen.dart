import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/utils/urls.dart';
import 'package:task_management_app/ui/screens/reset_password_screen.dart';
import 'package:task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:task_management_app/ui/widgets/screen_background.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordOtpScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();
  bool _inProgress = false;

  Future<void> _verifyOtp() async {
    _inProgress = true;
    setState(() {});

    final String url = Urls.verifyOTP(widget.email, _otpTEController.text.trim());

    // Call the NetworkCaller method without needing to pass token again
    NetworkResponse response = await NetworkCaller.getRequest(url: url);

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      ShowSnackBarMessage(context, 'OTP verified successfully!', false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
            email: widget.email,
            otp: _otpTEController.text.trim(),
          ),
        ),
      );
    } else {
      ShowSnackBarMessage(context, response.errorMessage ?? 'Invalid OTP', true);
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
                  'Verify OTP',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _otpTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Enter OTP'),
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Enter a valid OTP' : null,
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: !_inProgress,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    child: const Text('Verify OTP'),
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
    _otpTEController.dispose();
    super.dispose();
  }
}
