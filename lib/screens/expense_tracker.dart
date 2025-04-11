import 'package:flutter/material.dart';

class ExpenseTrackerPage extends StatefulWidget {
  const ExpenseTrackerPage({Key? key}) : super(key: key);

  @override
  _ExpenseTrackerPageState createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> {
  List<String> expenses = ['Makanan - \$20', 'Transportasi - \$10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Daftar Pengeluaran', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(expenses[index]));
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Menambahkan pengeluaran baru
                  expenses.add('Belanja - \$50');
                });
              },
              child: const Text('Tambah Pengeluaran'),
            ),
          ],
        ),
      ),
    );
  }
}
