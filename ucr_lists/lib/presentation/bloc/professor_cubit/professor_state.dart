part of 'professor_cubit.dart';

class ProfessorState extends Equatable {
  final List<Professor> professors;
  final String firstName;
  final String lastName;

  const ProfessorState(
      {this.professors = const [], this.firstName = '', this.lastName = ''});

  ProfessorState copyWith(
          {List<Professor>? professors, String? firstName, String? lastName}) =>
      ProfessorState(
          professors: professors ?? this.professors,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName);

  @override
  List<Object> get props => [professors, firstName, lastName];
}
