import 'package:isar/isar.dart';
import 'package:ucr_lists/domain/schemas.dart';

part 'professor.g.dart';

@collection
class Professor {
  Id? id = Isar.autoIncrement;
  String? firstName;
  String? lastName;

  @Backlink(to: 'professor')
  final courses = IsarLinks<Course>();
}
