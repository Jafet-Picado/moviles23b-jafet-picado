import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ucr_lists/domain/schemas.dart';
import 'package:ucr_lists/infrastructure/database/isar_service.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final isarService = IsarService();

  StudentCubit() : super(const StudentState());

  Future<void> addStudent(Student student, List<Course> newCourses) async {
    isarService.addStudent(student, newCourses);
  }

  Future<void> getStudents() async {
    List<Student> students = await isarService.getStudents();
    emit(state.copyWith(students: students));
  }

  Future<void> getStudent(int id) async {
    Student? student = await isarService.getStudent(id);
    if (student == null) return;
    await student.courses.load();
    emit(state.copyWith(
      id: student.id,
      firstName: student.firstName,
      lastName: student.lastName,
      carnet: student.carnet,
      email: student.email,
      courses: student.courses.toList(),
    ));
  }

  Future<void> deleteStudent(int id) async {
    isarService.deleteStudent(id);
  }
}
