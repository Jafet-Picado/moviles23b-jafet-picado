import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ucr_lists/domain/schemas.dart';
import 'package:ucr_lists/presentation/blocs.dart';

class CourseDetailsScreen extends StatelessWidget {
  final int id;

  const CourseDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfessorCubit()),
        BlocProvider(create: (context) => CourseCubit()),
      ],
      child: _CourseDetailsScreen(
        id: id,
      ),
    );
  }
}

class _CourseDetailsScreen extends StatefulWidget {
  final int id;

  const _CourseDetailsScreen({required this.id});

  @override
  State<_CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<_CourseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourse(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final String code = context.watch<CourseCubit>().state.code;
    final String name = context.watch<CourseCubit>().state.name;
    final Professor? professor = context.watch<CourseCubit>().state.professor;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            '$code $name',
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    'Profesor',
                    style: TextStyle(fontSize: 22, color: colors.primary),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    children: [
                      const Icon(Icons.person_2_rounded),
                      const SizedBox(width: 10),
                      Text(
                        (professor != null)
                            ? '${professor.firstName} ${professor.lastName}'
                            : 'Actualmente no tiene un profesor/a asignado/a',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Estudiantes',
                    style: TextStyle(fontSize: 22, color: colors.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
