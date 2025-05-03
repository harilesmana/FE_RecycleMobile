import 'package:flutter/material.dart';
import 'package:recycle_mobile/util/colors.dart';
import 'package:recycle_mobile/screens/welcomeScreen.dart';
import 'package:recycle_mobile/screens/howToUse.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/images/recycle.png'),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Explore the app',
                    style: TextStyle(
                      fontSize: 34,
                      color: AppColors.darkPrimaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Recycle today, for a better\ntomorrow!',
                    style: TextStyle(
                        fontSize: 28,
                        color: AppColors.darkPrimaryColor,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.darkPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HowToUseScreen()),
                  );
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.lightGreen,
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.darkPrimaryColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}