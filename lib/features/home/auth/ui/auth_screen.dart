import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/app_bottom.dart';
import 'package:todo/core/theme/app_text_style.dart';
import 'package:todo/core/utils/app_constant.dart';
import 'package:todo/core/widgets/custom_text_form_feild.dart';
import 'package:todo/features/home/auth/data/models/user_model.dart';
import 'package:todo/features/home/auth/ui/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final picker = ImagePicker();
  XFile? image;

  void pickfromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void pickfromCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Select Image"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  pickfromCamera();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                              ),
                              IconButton(
                                onPressed: () {
                                  pickfromGallery();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.browse_gallery),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: image != null
                        ? FileImage(File(image!.path))
                        : null,
                    child: image != null
                        ? null
                        : const Icon(Icons.person, size: 60),
                  ),
                ),
                const SizedBox(height: 30),
                Text("Create Your Profile", style: AppTextStyle.headlineStyle),
                const SizedBox(height: 15),
                const Text(
                  "Add your name and a profile picture",
                ),
                const SizedBox(height: 30),
                CustomTextFormFeild(
                  controller: nameController,
                  title: "Full Name",
                  hintText: "Enter your name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                AppBottom(
                  title: "continue",
                  onTap: () async {
                    if (image == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                              "Please select a profile picture",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    if (formKey.currentState?.validate() ?? false) {
                      try {
                        final newUser = UserModel(
                          image: image!.path,
                          name: nameController.text,
                        );
                        await Hive.box<UserModel>(
                          AppConstant.UserBox,
                        ).add(newUser);
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      } catch (error) {
                        debugPrint("Error writing to Hive: $error");
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}