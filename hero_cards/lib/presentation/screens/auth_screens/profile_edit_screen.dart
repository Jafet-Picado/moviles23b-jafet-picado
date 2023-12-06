import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  void saveChanges(AuthCubit authCubit) {
    showDialog(
      context: context,
      builder: (context) {
        authCubit.updateUserData(
          authCubit.state.email,
          'username',
          _usernameController.text,
        );
        authCubit.updateUserData(
          authCubit.state.email,
          'bio',
          _bioController.text,
        );
        return const AlertDialog(
          icon: Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
            size: 50,
          ),
          content: Text(
            'Los datos se guardaron correctamente',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    _usernameController.text = authCubit.state.username;
    _bioController.text = authCubit.state.bio;

    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Nombre de usuario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
              ),
              const SizedBox(height: 24),
              const Text(
                'Biografía',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _bioController,
                maxLines: 6,
              ),
              const SizedBox(height: 30),
              CustomButton(
                title: 'Guardar',
                onTap: () {
                  saveChanges(authCubit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
