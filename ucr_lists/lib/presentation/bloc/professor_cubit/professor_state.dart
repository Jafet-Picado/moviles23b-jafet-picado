part of 'professor_cubit.dart';

class ProfessorState extends Equatable {
  final List<Professor> professors;
  final int id;
  final String firstName;
  final String lastName;

  const ProfessorState(
      {this.professors = const [],
      this.id = -1,
      this.firstName = '',
      this.lastName = ''});

  ProfessorState copyWith(
          {List<Professor>? professors,
          int? id,
          String? firstName,
          String? lastName}) =>
      ProfessorState(
          professors: professors ?? this.professors,
          id: id ?? this.id,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName);

  @override
  List<Object> get props => [professors, id, firstName, lastName];
}
