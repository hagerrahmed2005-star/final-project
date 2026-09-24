import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/core/theme/app_text_style.dart';
import 'package:todo/core/utils/app_constant.dart';
import 'package:todo/features/home/auth/data/models/user_model.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<UserModel>(AppConstant.UserBox);
    final userData = userBox.isNotEmpty ? userBox.getAt(0) : null;
    final imagePath = userData?.image;

    final hasImage = imagePath != null && imagePath.isNotEmpty;

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: hasImage ? FileImage(File(imagePath)) : null,
          child: !hasImage
              ? const Icon(Icons.person, size: 45, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning👋",
                style: AppTextStyle.hintStyle,
              ),
              Text(
                userData?.name ?? "Guest",
                style: AppTextStyle.bodylargeStyle,
              ),
            ],
          ),
        ),
        const Icon(Icons.notifications_active_outlined, size: 30),
      ],
    );
  }
}