//Clase encargada de modelar la información mínica de un héroe,
//Cada instancia contiene propiedades básicas de un héroe
class HeroInfoMinimal {
  int id;
  EntityImage image;
  String name;
  String publisher;

  HeroInfoMinimal({
    required this.id,
    required this.image,
    required this.name,
    required this.publisher,
  });
}

class EntityImage {
  String iconUrl;
  String mediumUrl;
  String screenUrl;
  String screenLargeUrl;
  String smallUrl;
  String superUrl;
  String thumbUrl;
  String tinyUrl;
  String originalUrl;
  String imageTags;

  EntityImage({
    required this.iconUrl,
    required this.mediumUrl,
    required this.screenUrl,
    required this.screenLargeUrl,
    required this.smallUrl,
    required this.superUrl,
    required this.thumbUrl,
    required this.tinyUrl,
    required this.originalUrl,
    required this.imageTags,
  });
}
