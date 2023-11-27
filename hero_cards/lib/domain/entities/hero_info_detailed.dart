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

class EntityFirstAppearedInIssue {
  int id;
  String? name;

  EntityFirstAppearedInIssue({
    required this.id,
    required this.name,
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
