import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatefulWidget {
  final String type; // 'Income' atau 'Expense'
  const AddTransactionPage({super.key, required this.type});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  final List<String> incomeCategories = ['Gaji', 'Bonus', 'Lainnya'];
  final List<String> expenseCategories = ['Makan', 'Transportasi', 'Belanja'];

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.type == 'Income';
    final categories = isIncome ? incomeCategories : expenseCategories;

    final Color backgroundColor = isIncome ? Colors.green : Colors.red;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Tambah ${widget.type}',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nominal
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nominal',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Isi nominal' : null,
              ),
              const SizedBox(height: 16),

              // Kategori
              DropdownButtonFormField<String>(
                dropdownColor: backgroundColor,
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                value: _selectedCategory,
                items:
                    categories
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator: (value) => value == null ? 'Pilih kategori' : null,
              ),
              const SizedBox(height: 16),

              // Deskripsi
              TextFormField(
                controller: _descController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tanggal
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Tanggal: ${DateFormat('dd MMM yyyy').format(_selectedDate)}',
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.calendar_today, color: Colors.white),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(
                      'Saved: ${_amountController.text}, $_selectedCategory, ${_descController.text}, $_selectedDate',
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
