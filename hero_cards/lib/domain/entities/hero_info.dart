class HeroInfo {
  String id;
  String name;
  EntityPowerstats powerstats;
  EntityBiography biography;
  EntityAppearance appearance;
  EntityWork work;
  EntityConnections connections;
  EntityImage image;

  HeroInfo({
    required this.id,
    required this.name,
    required this.powerstats,
    required this.biography,
    required this.appearance,
    required this.work,
    required this.connections,
    required this.image,
  });
}

class EntityAppearance {
  String gender;
  String race;
  List<String> height;
  List<String> weight;
  String eyeColor;
  String hairColor;

  EntityAppearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });
}

class EntityBiography {
  String fullName;
  String alterEgos;
  List<String> aliases;
  String placeOfBirth;
  String firstAppearance;
  String publisher;
  String alignment;

  EntityBiography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });
}

class EntityConnections {
  String groupAffiliation;
  String relatives;

  EntityConnections({
    required this.groupAffiliation,
    required this.relatives,
  });
}

class EntityImage {
  String url;

  EntityImage({
    required this.url,
  });
}

class EntityPowerstats {
  String intelligence;
  String strength;
  String speed;
  String durability;
  String power;
  String combat;

  EntityPowerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });
}

class EntityWork {
  String occupation;
  String base;

  EntityWork({
    required this.occupation,
    required this.base,
  });
}
