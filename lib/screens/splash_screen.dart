// ignore_for_file: use_build_context_synchronously

import 'package:aplikasi_keuanganku/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 48,
                color: const Color.from(
                  alpha: 0.867,
                  red: 0.075,
                  green: 0.494,
                  blue: 0.424,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'MyWallet',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.from(
                    alpha: 0.867,
                    red: 0.075,
                    green: 0.494,
                    blue: 0.424,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Text(
            'Atur keuanganmu jadi lebih mudah',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),

          // Animasi Lottie
          Lottie.asset('assets/animation/ss2.json', width: 400, height: 400),
        ],
      ),
    );
  }
}
