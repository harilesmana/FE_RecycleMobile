import 'package:flutter/material.dart';
import 'package:recycle_mobile/util/colors.dart';
import 'package:recycle_mobile/screens/rulesScreen.dart';
import 'dart:async';

class ScanBarcodeScreen extends StatefulWidget {
  const ScanBarcodeScreen({super.key});

  @override
  State<ScanBarcodeScreen> createState() => _ScanBarcodeScreenState();
}

class _ScanBarcodeScreenState extends State<ScanBarcodeScreen> {
  int dotCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
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
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Scan Barcode',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Place a bottle or can in the scanning area',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scanner.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Scanning${'.' * dotCount}',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RulesScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle next action
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.lightGreen,
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.darkPrimaryColor,
                        size: 30, // Icon size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}