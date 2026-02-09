import 'dart:async';
import 'package:evently_app/ui/screens/onboarding/onboarding_screen.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FF),
      body: Column(
        children: [
          const Spacer(flex: 1,),
          Center(
            child: Image.asset(AppAssets.appLogo,width: 400,height: 400,),
          ),
          const Spacer(flex: 1,),
          Image.asset(AppAssets.routeLogo, width: 100),
          const SizedBox(height: 6),
          const Text("Supervised by Mohamed Nabil"),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
