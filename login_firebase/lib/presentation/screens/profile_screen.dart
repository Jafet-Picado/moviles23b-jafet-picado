import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/presentation/blocs.dart';
import 'package:login_firebase/presentation/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final authCubit = context.watch<AuthCubit>();
    final email = context.watch<AuthCubit>().state.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Icon(
              Icons.person,
              color: colors.primary,
              size: 70,
            ),
            const SizedBox(height: 10),
            Text(
              email,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.secondary,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'Acerca de mi',
              style: TextStyle(
                color: colors.secondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextBox(
              fieldTitle: 'Nombre de usuario',
              fieldData: 'Jafet',
              onEditPressed: () {},
            ),
            const SizedBox(height: 15),
            CustomTextBox(
              fieldTitle: 'Biografía',
              fieldData: 'Soy un estudiante y me gusta Flutter!',
              onEditPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
