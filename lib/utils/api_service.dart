import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';

class ApiService {
  static const String apiUrl =
      'https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage';

  static Future<List<ApiData>> fetchCards() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decode the JSON response
        var jsonData = json.decode(response.body);
        return List<ApiData>.from(
          jsonData.map((x) => ApiData.fromJson(x)),
        ); // Parse all items in the list and return
      } else {
        throw Exception('Failed to load cards');
      }
    } catch (e) {
      throw Exception('Failed to load cards due to error: $e');
    }
  }
}