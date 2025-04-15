import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart'; // pastikan file ini ada

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = ApiService.getTransactions();
  }

  double getTotal(List<Map<String, dynamic>> data, String type) {
    return data
        .where((tx) => tx['type'] == type)
        .fold(0.0, (sum, tx) => sum + (tx['amount'] as num).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _transactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final transactions = snapshot.data ?? [];
        final income = getTotal(transactions, 'Income');
        final expenses = getTotal(transactions, 'Expense');

        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Income & Expenses Summary
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Income
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.download, color: Colors.green),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Income",
                                    style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14)),
                                const SizedBox(height: 10),
                                Text(
                                  "Rp. ${income.toStringAsFixed(0)}",
                                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Expenses
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.upload, color: Colors.red),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Expenses",
                                    style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14)),
                                const SizedBox(height: 10),
                                Text(
                                  "Rp. ${expenses.toStringAsFixed(0)}",
                                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Transaction Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "TRANSACTION",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Transaction List
                ...transactions.map((tx) {
                  final isIncome = tx['type'] == 'Income';
                  final amountPrefix = isIncome ? '+' : '-';
                  final icon = isIncome ? Icons.download : Icons.upload;
                  final iconColor = isIncome ? Colors.green : Colors.red;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.delete),
                            SizedBox(width: 10),
                            Icon(Icons.edit),
                          ],
                        ),
                        title: Text("Rp. ${tx['amount'].toStringAsFixed(0)}"),
                        subtitle: Text(tx['description'] ?? '-'),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(icon, color: iconColor),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
