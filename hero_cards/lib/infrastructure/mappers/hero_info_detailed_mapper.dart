import 'package:hero_cards/domain/entities/hero_info_detailed.dart';

//Clase encargada de mapear la respuesta del API (JSON) a la clase HeroInfoDetailed
class HeroInfoDetailedMapper {
  //Recibe un JSON con la información detallada de un héroe y convierte esa
  //información en una instancia de la clase HeroInfoDetailed al iterar por cada
  //campo y asignando los valores correspondientes.
  HeroInfoDetailed superheroToEntityJSON(Map<String, dynamic> json) =>
      HeroInfoDetailed(
        aliases: json['aliases'] ?? '',
        birth: json['birth'] ?? '',
        characterEnemies: List<EntityFirstAppearedInIssue>.from(
          (json['character_enemies'] ?? []).map(
            (value) => EntityFirstAppearedInIssue(
              id: value['id'] ?? '',
              name: value['name'] ?? '',
            ),
          ),
        ),
        characterFriends: List<EntityFirstAppearedInIssue>.from(
          (json['character_friends'] ?? []).map(
            (value) => EntityFirstAppearedInIssue(
              id: value['id'] ?? '',
              name: value['name'] ?? '',
            ),
          ),
        ),
        deck: json['deck'] ?? '',
        gender: json['gender'] ?? '',
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
        origin: EntityFirstAppearedInIssue(
          id: json['origin']['id'] ?? '',
          name: json['origin']['name'] ?? '',
        ),
        powers: List<EntityFirstAppearedInIssue>.from(
          (json['powers'] ?? []).map(
            (value) => EntityFirstAppearedInIssue(
              id: value['id'] ?? '',
              name: value['name'] ?? '',
            ),
          ),
        ),
        publisher: EntityFirstAppearedInIssue(
          id: json['publisher']['id'] ?? '',
          name: json['publisher']['name'] ?? '',
        ),
        realName: json['real_name'] ?? '',
        teamEnemies: List<EntityFirstAppearedInIssue>.from(
          (json['team_enemies'] ?? []).map(
            (value) => EntityFirstAppearedInIssue(
              id: value['id'] ?? '',
              name: value['name'] ?? '',
            ),
          ),
        ),
        teamFriends: List<EntityFirstAppearedInIssue>.from(
          (json['team_friends'] ?? []).map(
            (value) => EntityFirstAppearedInIssue(
              id: value['id'] ?? '',
              name: value['name'] ?? '',
            ),
          ),
        ),
        teams: List<EntityFirstAppearedInIssue>.from(
          (json['teams'] ?? []).map(
            (value) => EntityFirstAppearedInIssue(
              id: value['id'] ?? '',
              name: value['name'] ?? '',
            ),
          ),
        ),
      );
}
