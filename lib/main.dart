import 'package:aplikasi_keuanganku/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Keuangan',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Ikuti pengaturan sistem (gelap/terang)
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF3F91F3),
          secondary: const Color(0xFF2CA69A),
          surface: const Color(0xFFF5F7FA),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF3F91F3),
          secondary: const Color(0xFF2CA69A),
          surface: const Color(0xFF1A1A2E),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
