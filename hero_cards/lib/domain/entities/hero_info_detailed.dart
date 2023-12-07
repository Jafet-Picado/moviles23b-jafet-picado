//Clase encargada de modelar la información detallada de un héroe,
//Cada instancia contiene propiedades que describen caracteristicas especificas
//de un héroe.
class HeroInfoDetailed {
  String aliases;
  dynamic birth;
  List<EntityFirstAppearedInIssue> characterEnemies;
  List<EntityFirstAppearedInIssue> characterFriends;
  String deck;
  int gender;
  int id;
  EntityImage image;
  String name;
  EntityFirstAppearedInIssue origin;
  List<EntityFirstAppearedInIssue> powers;
  EntityFirstAppearedInIssue publisher;
  String realName;
  List<EntityFirstAppearedInIssue> teamEnemies;
  List<EntityFirstAppearedInIssue> teamFriends;
  List<EntityFirstAppearedInIssue> teams;

  HeroInfoDetailed({
    required this.aliases,
    required this.birth,
    required this.characterEnemies,
    required this.characterFriends,
    required this.deck,
    required this.gender,
    required this.id,
    required this.image,
    required this.name,
    required this.origin,
    required this.powers,
    required this.publisher,
    required this.realName,
    required this.teamEnemies,
    required this.teamFriends,
    required this.teams,
  });
}

//Una clase que representa un par de valores, un identificador único y un nombre
class EntityFirstAppearedInIssue {
  int id;
  String? name;

  EntityFirstAppearedInIssue({
    required this.id,
    required this.name,
  });
}

//Una clase para albergar todas las diferentes URLs de las imagenes del héroe.
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
