import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/infrastructure/datasources/superhero_datasource.dart';
import 'package:hero_cards/infrastructure/repositories/hero_repository.dart';

part 'hero_state.dart';

class HeroCubit extends Cubit<HeroState> {
  HeroCubit() : super(const HeroState());

  Future<void> getHeroById({required int id}) async {
    try {
      emit(state.copyWith(isLoading: true));
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      HeroInfo? hero;
      await repo.getHero(id: id).then((value) => hero = value);

      emit(state.copyWith(
        isLoading: false,
        hero: hero,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
