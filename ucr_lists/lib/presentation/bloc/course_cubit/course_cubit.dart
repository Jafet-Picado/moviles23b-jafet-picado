import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ucr_lists/domain/schemas.dart';
import 'package:ucr_lists/infrastructure/database/isar_service.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final isarService = IsarService();

  CourseCubit() : super(const CourseState());

  Future<void> addCourse(Course course) async {
    isarService.addCourse(course);
  }

  Future<void> getCourses() async {
    List<Course> courses = await isarService.getCourses();
    for (Course course in courses) {
      await course.professor.load();
    }
    emit(state.copyWith(courses: courses));
  }

  Future<void> getCourse(int id) async {
    Course? course = await isarService.getCourse(id);
    if (course == null) return;
    await course.professor.load();
    await course.students.load();
    emit(state.copyWith(
      id: course.id,
      code: course.code,
      name: course.name,
      professor: course.professor.value,
      students: course.students.toList(),
    ));
  }

  Future<void> deleteCourse(int id) async {
    isarService.deleteCourse(id);
  }
}
