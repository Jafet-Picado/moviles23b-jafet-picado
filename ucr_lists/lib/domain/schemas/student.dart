import 'package:isar/isar.dart';
import 'package:ucr_lists/domain/schemas.dart';

part 'student.g.dart';

@collection
class Student {
  Id? id = Isar.autoIncrement;

  @Index(unique: true)
  String? carnet;

  @Index(unique: true)
  String? email;

  String? firstName;
  String? lastName;

  @Backlink(to: 'students')
  final courses = IsarLinks<Course>();
}
