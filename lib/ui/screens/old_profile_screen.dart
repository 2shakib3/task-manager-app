import 'package:flutter/material.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/widgets/tm_app_bar.dart';
import 'package:task_management_app/data/service/network_caller.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/data/utils/urls.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fristNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    // Fetch the user's data and prefill the form fields
    _emailTEController.text = AuthController.userData?.email ?? 'email@mail.com';
    _fristNameTEController.text = AuthController.userData?.firstName ?? 'First Name';
    _lastNameTEController.text = AuthController.userData?.lastName ?? 'Last Name';
    _mobileTEController.text = AuthController.userData?.mobile ?? '01828066845';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                'Update Profile',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              _buildPhotoPicker(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fristNameTEController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _lastNameTEController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mobileTEController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onTapUpdateButton,
                child: const Icon(Icons.arrow_circle_right_outlined),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Placeholder for the photo picker widget
  Widget _buildPhotoPicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Photo',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          const Text('Selected Photo'),
        ],
      ),
    );
  }

  // Update button action
  void _onTapUpdateButton() async {
    // Collect updated data from the form fields
    final updatedProfileData = {
      'email': _emailTEController.text,
      'firstName': _fristNameTEController.text,
      'lastName': _lastNameTEController.text,
      'mobile': _mobileTEController.text,
      'password': _passwordController.text,
    };

    // Call the API to update the profile using the NetworkCaller
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.profileUpdate, // Profile update API
      body: updatedProfileData,
    );

    if (response.isSuccess) {
      // On success, show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated')));
    } else {
      // On failure, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.errorMessage}')));
    }
  }
}
