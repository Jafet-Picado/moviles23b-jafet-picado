import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ucr_lists/domain/schemas.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([ProfessorSchema, CourseSchema],
          directory: dir.path);
    }
    return await Future.value(Isar.getInstance());
  }

  Future<void> addProfessor(Professor professor) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.professors.put(professor);
    });
  }

  Future<List<Professor>> getProfessors() async {
    final isar = await db;
    return await isar.professors.where().findAll();
  }
}
