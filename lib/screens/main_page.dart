import 'package:aplikasi_keuanganku/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'add_transaction_page.dart'; // ← pastikan file ini udah dibuat

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  Widget _buildBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return Center(child: Text("Goals Page"));
      case 1:
        return const HomePage();
      case 2:
        return Center(child: Text("Wallet Page"));
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        icon: Icons.add, // Tetep pakai icon plus
        activeIcon: Icons.close,
        backgroundColor: const Color(0xFF3F91F3),
        foregroundColor: Colors.white,
        overlayOpacity: 0.3,
        spacing: 12,
        spaceBetweenChildren: 8,
        elevation: 8,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTransactionPage(type: 'Expense'),
                ),
              );
            },
            backgroundColor: Colors.white,
            labelWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3F91F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_down, color: Colors.red, size: 20),
                  SizedBox(width: 6),
                  Text(
                    "Expense",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTransactionPage(type: 'Income'),
                ),
              );
            },
            backgroundColor: Colors.white,
            labelWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3F91F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_up, color: Colors.green, size: 20),
                  SizedBox(width: 6),
                  Text(
                    "Income",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            color: const Color(0xFF3B1D71),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    print("Notifikasi ditekan");
                  },
                ),
                Text(
                  "MyWallet APP",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () {
                    print("Profile ditekan");
                  },
                ),
              ],
            ),
          ),
          CalendarAppBar(
            backButton: false,
            black: const Color(0xFF3B1D71),
            accent: const Color(0xFF3B1D71),
            locale: "id",
            onDateChanged: (value) => print(value),
            firstDate: DateTime.now().subtract(const Duration(days: 140)),
            lastDate: DateTime.now(),
          ),
          Expanded(child: _buildBodyContent()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF3B1D71),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.savings, "Goals", 0, isMain: true),
              _buildNavItem(Icons.home, "Home", 1, isMain: true),
              _buildNavItem(
                Icons.account_balance_wallet,
                "Wallet",
                2,
                isMain: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index, {
    bool isMain = false,
  }) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedIndex = index;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: isMain && isSelected
            ? BoxDecoration(
                color: const Color(0xFF2CA69A),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: isMain ? 24 : 22),
            if (isMain && isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
