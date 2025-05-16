import 'package:flutter/material.dart';
import 'package:recycle_mobile/util/colors.dart';
import 'package:recycle_mobile/screens/scanBarcodeScreen.dart'; // Make sure this import is correct

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/recycleBottles.png',
                width: 120,
                height: 120,
              ),
              SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rules',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildRuleText('Rinse plastic bottles and cans to remove any liquid residue.'),
                    _buildRuleText('Ensure bottles and cans are clean before recycling.'),
                    _buildRuleText('Do not crush the bottles – keep them in original shape.'),
                    _buildRuleText('Do not remove the label – keep barcode visible.'),
                    SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate directly to ScanBarcodeScreen without using named routes
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScanBarcodeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.darkPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildRuleText(String rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(Icons.recycling, color: Color(0xFF388E3C)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              rule,
              style: TextStyle(fontSize: 16, color: Color(0xFF388E3C)),
            ),
          ),
        ],
      ),
    );
  }
}