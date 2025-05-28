import 'package:flutter/material.dart';
import 'dart:async';
import '../util/colors.dart';
import 'howtouse.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HowToUseScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: AppColors.green,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isPortrait ? screenWidth * 0.1 : screenWidth * 0.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              SizedBox(height: screenHeight * 0.05),


              Image.asset(
                'assets/images/recycle.png',
                width: shortestSide * 0.3,
                height: shortestSide * 0.3,
                fit: BoxFit.contain,
              ),
              SizedBox(height: screenHeight * 0.03),


              Text(
                'RECYCLE',
                style: TextStyle(
                  fontSize: shortestSide * 0.1,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkPrimaryColor,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),


              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: shortestSide * 0.05,
                    color: AppColors.darkPrimaryColor,
                  ),
                  children: const [
                    TextSpan(text: 'Recycle today, for a better\n'),
                    TextSpan(
                      text: 'tomorrow!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}