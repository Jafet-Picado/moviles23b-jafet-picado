import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseListView extends StatefulWidget {
  const CourseListView({super.key});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                'Lista de cursos',
                style: TextStyle(fontSize: 22, color: colors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Expanded(child: SizedBox()),
        const SizedBox(
          height: 15,
        ),
        FilledButton.icon(
            onPressed: () {
              context.push('/add-course').then((_) => Future.delayed(
                  const Duration(milliseconds: 250),
                  () => ())); //context.read<CourseCubit>().getProfessors()));
            },
            icon: const Icon(Icons.add),
            label: const Text('Agregar curso')),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
