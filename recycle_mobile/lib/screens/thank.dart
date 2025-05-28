  import 'package:flutter/material.dart';
  import '../util/colors.dart';
  import 'list.dart';

  class ThankYouScreen extends StatelessWidget {
    const ThankYouScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final media = MediaQuery.of(context);
      final screenWidth = media.size.width;
      final screenHeight = media.size.height;
      final shortestSide = media.size.shortestSide;
      final isPortrait = media.orientation == Orientation.portrait;

      final titleFontSize = ((shortestSide * 0.12).clamp(24, 32)).toDouble();
      final bodyFontSize = ((shortestSide * 0.07).clamp(14, 18)).toDouble();
      final imageSize = shortestSide * 0.4;
      final paddingHorizontal = screenWidth * (isPortrait ? 0.06 : 0.15);
      final paddingVertical = screenHeight * (isPortrait ? 0.05 : 0.02);
      final buttonVerticalPadding = screenHeight * 0.025;

      return Scaffold(
        backgroundColor: AppColors.green,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Column(
              children: [
                SizedBox(height: paddingVertical),

                Text(
                  'thank you',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkPrimaryColor,
                  ),
                ),

                SizedBox(height: paddingVertical * 0.5),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.07,
                        horizontal: screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'your waste has been\nsuccessfully processed and\nthanks for contributing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: AppColors.darkPrimaryColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -imageSize * 0.4,
                      right: -imageSize * 0.4,
                      child: Image.asset(
                        'assets/images/earth.png',
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  AcceptedItemsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightGreen,
                      foregroundColor: AppColors.darkPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: buttonVerticalPadding),
                    ),
                    child: Text(
                      'Back to home',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: bodyFontSize,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: paddingVertical),
              ],
            ),
          ),
        ),
      );
    }
  }
