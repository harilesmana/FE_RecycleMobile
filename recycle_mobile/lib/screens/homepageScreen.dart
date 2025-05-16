import 'package:flutter/material.dart';
import 'package:recycle_mobile/util/colors.dart';
import 'package:recycle_mobile/screens/rulesScreen.dart';

class HomapageScreen extends StatefulWidget{
  const HomapageScreen({super.key});

  @override
  State<HomapageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomapageScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: SafeArea(

      ),
    );
  }
}