import 'package:hero_cards/domain/entities/hero_info_minimal.dart';

//Clase encargada de mapear la respuesta del API (JSON) a la clase HeroInfoDetailed
class HeroInfoMinimalMapper {
  //Recibe un JSON con la información mínima de un héroe y convierte esa
  //información en una instancia de la clase HeroInfoMinimal al iterar por cada
  //campo y asignando los valores correspondientes.
  HeroInfoMinimal superheroToEntityJSON(Map<String, dynamic> json) =>
      HeroInfoMinimal(
        id: json['id'] ?? '',
        image: EntityImage(
          iconUrl: json['image']['icon_url'] ?? '',
          mediumUrl: json['image']['medium_url'] ?? '',
          screenUrl: json['image']['screen_url'] ?? '',
          screenLargeUrl: json['image']['screen_large_url'] ?? '',
          smallUrl: json['image']['small_url'] ?? '',
          superUrl: json['image']['super_url'] ?? '',
          thumbUrl: json['image']['thumb_url'] ?? '',
          tinyUrl: json['image']['tiny_url'] ?? '',
          originalUrl: json['image']['original_url'] ?? '',
          imageTags: json['image']['image_tags'] ?? '',
        ),
        name: json['name'] ?? '',
        publisher: (json['publisher'] != null) ? json['publisher']['name'] : '',
      );
}
