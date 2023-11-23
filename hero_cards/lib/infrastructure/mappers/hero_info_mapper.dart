import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/infrastructure/models/superhero_response.dart';

class HeroInfoMapper {
  HeroInfo superheroToEntity(SuperheroResponse superhero) => HeroInfo(
        id: superhero.id,
        name: superhero.name,
        powerstats: EntityPowerstats(
          intelligence: superhero.powerstats.intelligence,
          strength: superhero.powerstats.strength,
          speed: superhero.powerstats.speed,
          durability: superhero.powerstats.durability,
          power: superhero.powerstats.power,
          combat: superhero.powerstats.combat,
        ),
        biography: EntityBiography(
          fullName: superhero.biography.fullName,
          alterEgos: superhero.biography.alterEgos,
          aliases: superhero.biography.aliases,
          placeOfBirth: superhero.biography.placeOfBirth,
          firstAppearance: superhero.biography.firstAppearance,
          publisher: superhero.biography.publisher,
          alignment: superhero.biography.alignment,
        ),
        appearance: EntityAppearance(
          gender: superhero.appearance.gender,
          race: superhero.appearance.race,
          height: superhero.appearance.height,
          weight: superhero.appearance.weight,
          eyeColor: superhero.appearance.eyeColor,
          hairColor: superhero.appearance.hairColor,
        ),
        work: EntityWork(
          occupation: superhero.work.occupation,
          base: superhero.work.base,
        ),
        connections: EntityConnections(
          groupAffiliation: superhero.connections.groupAffiliation,
          relatives: superhero.connections.relatives,
        ),
        image: EntityImage(url: superhero.image.url),
      );
}
