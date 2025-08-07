import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/models/card_model.dart';

class CartaRemoteDataSource {
  static const String _baseUrl =
      'https://db.ygoprodeck.com/api/v7/cardinfo.php';

  Future<List<CartaModel>> apiGetCartas({
    int offset = 0,
    int limit = 10,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?num=$limit&offset=$offset',
    ); // Agrego parametros para la paginación
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List data = jsonBody['data'];
      return data.map((json) => CartaModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener cartas ${response.statusCode}');
    }
  }
}
