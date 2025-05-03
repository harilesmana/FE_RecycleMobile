import 'package:flutter/material.dart';
import 'package:recycle_mobile/util/colors.dart';
import 'package:recycle_mobile/screens/welcomeScreen.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                children: [
                  const Text(
                    "How to use?",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildVerticalStepCard(
                    imagePath: 'assets/images/log.png',
                    title: "Identification",
                    description: "Login or Sign Up to use the app.",
                  ),
                  const SizedBox(height: 20),
                  _buildVerticalStepCard(
                    imagePath: 'assets/images/scanner.png',
                    title: "Scan Barcode",
                    description: "Place a bottle or can in the scanning area.",
                  ),
                  const SizedBox(height: 20),
                  _buildVerticalStepCard(
                    imagePath: 'assets/images/moneyBag.png',
                    title: "Reward",
                    description: "You will get reward points after recycling.",
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
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

  Widget _buildVerticalStepCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      height: 200,
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 75,
            height: 75,
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}