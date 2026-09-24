
import 'package:flutter/material.dart';
import 'package:todo/features/splash/ui/splash_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Nunito"
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}