import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    // Prefill the form fields with user data
    _emailTEController.text = AuthController.userData?.email ?? 'email@mail.com';
    _firstNameTEController.text = AuthController.userData?.firstName ?? 'First Name';
    _lastNameTEController.text = AuthController.userData?.lastName ?? 'Last Name';
    _mobileTEController.text = AuthController.userData?.mobile ?? '01828066845';
  }

  Future<void> _pickImage() async {
    // Pick an image from the gallery or camera
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Change to ImageSource.camera for camera
      maxWidth: 400,
      maxHeight: 400,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
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
                controller: _firstNameTEController,
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
                obscureText: true,
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

  // Photo picker widget that allows the user to select a photo
  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        alignment: Alignment.center,
        child: _profileImage == null
            ? const Text(
          'photo',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            _profileImage!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton() async {
    final updatedProfileData = {
      'email': _emailTEController.text,
      'firstName': _firstNameTEController.text,
      'lastName': _lastNameTEController.text,
      'mobile': _mobileTEController.text,
    };

    // Only add the password if it is not empty
    if (_passwordController.text.isNotEmpty) {
      updatedProfileData['password'] = _passwordController.text;
    }

    // Include the profile image if it is updated
    if (_profileImage != null) {
      updatedProfileData['profileImage'] = (await _getImageBytes())!;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.profileUpdate,
      body: updatedProfileData,
    );

    if (response.isSuccess) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated')),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.errorMessage}')),
      );
    }
  }

  Future<String?> _getImageBytes() async {
    if (_profileImage != null) {
      final bytes = await _profileImage!.readAsBytes();
      return base64Encode(bytes);
    }
    return null;
  }
}
