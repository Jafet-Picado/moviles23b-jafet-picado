import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/infrastructure/datasources/superhero_datasource.dart';
import 'package:hero_cards/infrastructure/repositories/hero_repository.dart';

part 'hero_state.dart';

class HeroCubit extends Cubit<HeroState> {
  HeroCubit() : super(const HeroState());

  //Obtiene la información mínima de un héroe de forma aleatoria y actualiza
  //el estado para tener la información disponible
  Future<void> getHeroMinimalRandom() async {
    try {
      emit(state.copyWith(isLoading: true));
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      HeroInfoMinimal hero = await repo.getRandomHero();

      emit(state.copyWith(
        isLoading: false,
        heroMinimal: hero,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }

  //Obtiene la información detallada de un héroe por medio de su ID y actualiza
  //el estado para tener su información disponible
  Future<void> getHeroDetailedById({required int id}) async {
    try {
      emit(state.copyWith(isLoading: true));
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      HeroInfoDetailed hero = await repo.getHeroDetailed(id: id);
      emit(state.copyWith(
        isLoading: false,
        heroDetailed: hero,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }

  //Obtiene la información detallada de una lista de héroes y actualiza el estado
  //para tener la información disponible
  Future<void> getHeroesDetailedByList({required List<int> heroes}) async {
    try {
      emit(state.copyWith(isLoading: true));
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      List<HeroInfoDetailed> heroesList = [];
      for (int id in heroes) {
        await repo
            .getHeroDetailed(id: id)
            .then((value) => heroesList.add(value));
      }

      emit(state.copyWith(
        isLoading: false,
        heroesDetailed: heroesList,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }

  //Obtiene la información mínima de una lista de héroes y actualiza el estado
  //para tener la información disponible
  Future<void> getHeroesMinimalByList({required List<int> heroes}) async {
    try {
      emit(state.copyWith(isLoading: true));
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      List<HeroInfoMinimal> heroesList = [];
      for (int id in heroes) {
        await repo
            .getHeroMinimal(id: id)
            .then((value) => heroesList.add(value));
      }

      emit(state.copyWith(
        isLoading: false,
        heroesMinimal: heroesList,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }

  //Obtiene la información de una lista de héroes aleatorios y actualiza el
  //estado para tener la información disponible
  Future<void> getRandomHeroesMinimal({int quantity = 8}) async {
    try {
      emit(state.copyWith(isLoading: true));
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      List<HeroInfoMinimal> heroesList = [];
      for (int index = 0; index < quantity; index++) {
        await repo.getRandomHero().then((value) => heroesList.add(value));
      }

      emit(state.copyWith(
        isLoading: false,
        heroesMinimal: heroesList,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
