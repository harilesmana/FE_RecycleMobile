import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recycle_mobile/util/colors.dart';
import 'rulesScreen.dart';

class DuitScreen extends StatelessWidget {
  const DuitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BalanceScreen();
  }
}

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  String userName = '';
  int balance = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Simulasi ambil data dari backend dengan delay 1 detik
    await Future.delayed(const Duration(seconds: 1));

    // Ganti sama api call 
    setState(() {
      userName = 'Andi';
      balance = 1000;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.02),
              UserGreetingCard(userName: userName),
              SizedBox(height: size.height * 0.04),
              BalanceCard(balance: balance),
              const Spacer(),
              const NextButton(),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

class UserGreetingCard extends StatelessWidget {
  final String userName;
  const UserGreetingCard({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        'Halo $userName,',
        style: TextStyle(
          fontSize: size.width * 0.07,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final int balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.04,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            'Account balance',
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            currency.format(balance),
            style: TextStyle(
              fontSize: size.width * 0.08,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          const Text(
            'Minimum balance Rp5.000,00',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RulesScreen()),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015,
          ),
          child: Text(
            'Next',
            style: TextStyle(
              color: Colors.black87,
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
