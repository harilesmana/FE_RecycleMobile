import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import '../util/colors.dart';
import 'list.dart';

class ScanBarcodeScreen extends StatefulWidget {
  final List cartItems; // Tambahkan parameter jika perlu

  const ScanBarcodeScreen({super.key, this.cartItems = const []});

  @override
  State<ScanBarcodeScreen> createState() => _ScanBarcodeScreenState();
}

class _ScanBarcodeScreenState extends State<ScanBarcodeScreen> {
  int dotCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    final titleFontSize = shortestSide * 0.07;
    final subtitleFontSize = shortestSide * 0.05;
    final scanningFontSize = shortestSide * 0.07;

    final scannerImageSize = shortestSide * 0.18;
    final bottleImageSize = shortestSide * 0.36;

    final edgePadding = isPortrait ? screenWidth * 0.05 : screenWidth * 0.1;

    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: screenHeight * 0.03,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Back",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AcceptedItemsScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF7C6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black45,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(edgePadding),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Scan Barcode',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPrimaryColor,
                    ),
                  ),
                  SizedBox(height: shortestSide * 0.03),
                  Text(
                    'Place a bottle or can in the scanning area',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 25 * math.pi / 180,
                            child: Image.asset(
                              'assets/images/scanner.png',
                              width: scannerImageSize,
                              height: scannerImageSize,
                              semanticLabel: 'Scanner illustration',
                            ),
                          ),
                          SizedBox(width: shortestSide * 0.02),
                          Image.asset(
                            'assets/images/botol.png',
                            width: bottleImageSize,
                            height: bottleImageSize,
                            semanticLabel: 'Bottle image',
                          ),
                        ],
                      ),
                      SizedBox(height: shortestSide * 0.07),
                      Text(
                        'Scanning${'.' * dotCount}',
                        style: TextStyle(
                          fontSize: scanningFontSize,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
