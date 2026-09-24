
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:lottie/lottie.dart';
import 'package:todo/core/utils/app_constant.dart';
import 'package:todo/features/home/auth/data/models/user_model.dart';
import 'package:todo/features/home/auth/ui/auth_screen.dart';
import 'package:todo/features/home/auth/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
  
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => _NextRoute()),
        );
      }
    });
  }

  
  Widget _NextRoute() {
   
    if(Hive.box<UserModel>(AppConstant.UserBox).isEmpty) {
      return AuthScreen();
    }else {
      return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/icons/splash.json"),
      ),
    );
  }
}