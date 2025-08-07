// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/card_model.dart';

// class ApiService {
//   static const String baseUrl = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';

//   Future<List<CardModel>> fetchCards({int offset = 0, int limit = 10}) async {
//     final url = Uri.parse('$baseUrl?num=$limit&offset=$offset');

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       final List data = jsonBody['data'];

//       return data.map((card) => CardModel.fromJson(card)).toList();
//     } else {
//       throw Exception('Error al obtener cartas: ${response.statusCode}');
//     }
//   }
// }
