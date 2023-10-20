import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ucr_lists/domain/schemas.dart';
import 'package:ucr_lists/infrastructure/database/isar_service.dart';

part 'professor_state.dart';

class ProfessorCubit extends Cubit<ProfessorState> {
  final isarService = IsarService();

  ProfessorCubit() : super(const ProfessorState());

  Future<void> addProfessor(Professor professor) async {
    isarService.addProfessor(professor);
  }

  Future<void> getProfessors() async {
    List<Professor> professors = await isarService.getProfessors();
    emit(state.copyWith(professors: professors));
  }
}
