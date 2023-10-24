part of 'professor_cubit.dart';

class ProfessorState extends Equatable {
  final List<Professor> professors;
  final List<Course> courses;
  final int id;
  final String firstName;
  final String lastName;

  const ProfessorState(
      {this.professors = const [],
      this.courses = const [],
      this.id = -1,
      this.firstName = '',
      this.lastName = ''});

  ProfessorState copyWith(
          {List<Professor>? professors,
          List<Course>? courses,
          int? id,
          String? firstName,
          String? lastName}) =>
      ProfessorState(
          professors: professors ?? this.professors,
          courses: courses ?? this.courses,
          id: id ?? this.id,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName);

  @override
  List<Object> get props => [professors, courses, id, firstName, lastName];
}
