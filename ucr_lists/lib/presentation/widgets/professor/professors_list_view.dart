import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfessorsListView extends StatelessWidget {
  const ProfessorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(children: [
      const SizedBox(
        height: 15,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(
              'Lista de profesores',
              style: TextStyle(fontSize: 22, color: colors.primary),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      const Expanded(
        child: SizedBox(),
      ),
      FilledButton.icon(
          onPressed: () {
            context.push('/add-professor');
          },
          icon: const Icon(Icons.add),
          label: const Text('Agregar profesor')),
      const SizedBox(
        height: 15,
      ),
    ]);
  }
}
