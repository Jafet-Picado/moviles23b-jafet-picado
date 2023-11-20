import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_firebase/presentation/blocs.dart';
import 'package:login_firebase/presentation/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void editFieldDialog(
      String text, AuthCubit authCubit, String field, String email) {
    String newValue = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Editar $text',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Modifique el $text',
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                authCubit.updateUserData(email, field, newValue);
                context.pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final authCubit = context.watch<AuthCubit>();
    final email = context.watch<AuthCubit>().state.email;
    final username = context.watch<AuthCubit>().state.username;
    final bio = context.watch<AuthCubit>().state.bio;

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
              fieldData: username,
              onEditPressed: () {
                editFieldDialog(
                  'nombre de usuario',
                  authCubit,
                  'username',
                  email,
                );
              },
            ),
            const SizedBox(height: 15),
            CustomTextBox(
              fieldTitle: 'Biografía',
              fieldData: bio,
              onEditPressed: () {
                editFieldDialog(
                  'biografía',
                  authCubit,
                  'bio',
                  email,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
