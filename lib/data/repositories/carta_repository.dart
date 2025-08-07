import '../../domain/entities/carta_entity.dart';
import '../datasources/carta_remote_data_source.dart';
import '../../core/models/card_model.dart';

class CardRepository {
  final CartaRemoteDataSource remoteDataSource;

  CardRepository({required this.remoteDataSource});

  Future<List<CartaEntity>> getCartas({int offset = 0, int limit = 10}) async {
    final List<CartaModel> models = await remoteDataSource.apiGetCartas(
      offset: offset,
      limit: limit,
    );

    // Convertir los modelos a entidades
    return models.map((model) => model.toEntity()).toList();
  }
}
