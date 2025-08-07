import '../../domain/entities/carta_entity.dart';

class CartaModel {
  final String name;
  final String type;
  final String desc;
  final String imageUrl;

  CartaModel({
    required this.name,
    required this.type,
    required this.desc,
    required this.imageUrl,
  });

  factory CartaModel.fromJson(Map<String, dynamic> json) {
    return CartaModel(
      name: json['name'],
      type: json['type'],
      desc: json['desc'],
      imageUrl:
          json['card_images'] != null &&
              (json['card_images'] as List).isNotEmpty
          ? json['card_images'][0]['image_url']
          : '',
    );
  }

  /// Convierte a entidad de dominio para desacoplar UI y lógica
  CartaEntity toEntity() {
    return CartaEntity(
      name: name,
      type: type,
      description: desc,
      imageUrl: imageUrl,
    );
  }
}
