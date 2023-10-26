part of 'student_cubit.dart';

class StudentState extends Equatable {
  final List<Student> students;
  final int id;
  final String firstName;
  final String lastName;
  final String carnet;
  final String email;
  final List<Course> courses;

  const StudentState({
    this.students = const [],
    this.id = -1,
    this.firstName = '',
    this.lastName = '',
    this.carnet = '',
    this.email = '',
    this.courses = const [],
  });

  StudentState copyWith({
    List<Student>? students,
    int? id,
    String? firstName,
    String? lastName,
    String? carnet,
    String? email,
    List<Course>? courses,
  }) =>
      StudentState(
        students: students ?? this.students,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        carnet: carnet ?? this.carnet,
        email: email ?? this.email,
        courses: courses ?? this.courses,
      );

  @override
  List<Object> get props =>
      [students, firstName, lastName, carnet, email, courses];
}
