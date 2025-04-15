import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:5000'; // Ganti dengan IP server kalau bukan emulator

Future<List<Map<String, dynamic>>> fetchTransactions() async {
  final response = await http.get(Uri.parse('$baseUrl/transactions'));
  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Failed to load transactions');
  }
}

Future<void> addTransaction(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('$baseUrl/transactions'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to add transaction');
  }
}
