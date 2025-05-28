import 'package:flutter/material.dart';
import 'welcome.dart';
import '../util/colors.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How to use?",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildVerticalStepCard(
                    context: context,
                    imagePath: 'assets/images/log.png',
                    title: "Identification",
                    description: "Login or Sign Up to use the app.",
                  ),
                  const SizedBox(height: 20),
                  _buildVerticalStepCard(
                    context: context,
                    imagePath: 'assets/images/scanner.png',
                    title: "Scan Barcode",
                    description: "Place a bottle or can in the scanning area.",
                  ),
                  const SizedBox(height: 20),
                  _buildVerticalStepCard(
                    context: context,
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
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
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
    required BuildContext context,
    required String imagePath,
    required String title,
    required String description,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
