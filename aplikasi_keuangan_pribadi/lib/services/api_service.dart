// TODO Implement this library.import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000';

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final url = Uri.parse('$baseUrl/transactions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Gagal memuat data transaksi');
    }
  }
}
