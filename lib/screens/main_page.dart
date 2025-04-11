import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // Calendar as default selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0), // Atur jarak dari bottom
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // FAB mengambang
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1E1E2C),
        // Hapus shape dan notchMargin agar FAB tidak menyatu
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.savings, "Goals", 0, isMain: true),
              _buildNavItem(Icons.calendar_today, "Calendar", 1, isMain: true),
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
      onTap:
          () => setState(() {
            _selectedIndex = index;
          }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration:
            isMain && isSelected
                ? BoxDecoration(
                  color: const Color(0xFF2A2A3D),
                  borderRadius: BorderRadius.circular(20),
                )
                : null,
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: isMain ? 24 : 22,
            ),
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
