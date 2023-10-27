import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ucr_lists/domain/schemas.dart';
import 'package:ucr_lists/presentation/blocs.dart';

class StudentDetailsScreen extends StatelessWidget {
  final int id;

  const StudentDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StudentCubit()),
      ],
      child: _StudentDetailsView(id: id),
    );
  }
}

class _StudentDetailsView extends StatefulWidget {
  final int id;

  const _StudentDetailsView({
    required this.id,
  });

  @override
  State<_StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<_StudentDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getStudent(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final String firstName = context.watch<StudentCubit>().state.firstName;
    final String lastName = context.watch<StudentCubit>().state.lastName;
    final String email = context.watch<StudentCubit>().state.email;
    final String carnet = context.watch<StudentCubit>().state.carnet;
    final List<Course> courses = context.watch<StudentCubit>().state.courses;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('$firstName $lastName')),
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
                    'Correo electrónico',
                    style: TextStyle(fontSize: 20, color: colors.primary),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      const Icon(Icons.email_rounded),
                      const SizedBox(width: 10),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Carnet',
                    style: TextStyle(fontSize: 20, color: colors.primary),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      const Icon(Icons.account_box_rounded),
                      const SizedBox(width: 10),
                      Text(
                        carnet,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Cursos matriculados',
                    style: TextStyle(fontSize: 20, color: colors.primary),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: (courses.isNotEmpty)
                ? ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) => ListTile(
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded),
                            const SizedBox(width: 5),
                            Text(
                              '${courses[index].name}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        '${courses[index].code}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const Text(
                    'No se encuentra matriculado en ningún curso actualmente',
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }
}
