import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //Método llamado para registrar al usuario con el correo eléctronico y contraseña
  //brindados para posteriormente enviarlo a la pantalla inicial de la aplicación
  void signUp(BuildContext context, AuthCubit authCubit) {
    if (_passwordController.text == _confirmPasswordController.text) {
      authCubit
          .signUpUser(
        _emailController.text,
        _passwordController.text,
      )
          .then(
        (value) {
          if (authCubit.state.error) {
            showDialog(
              context: context,
              builder: (context) {
                String e = authCubit.state.errorMessage;
                authCubit.isCreatingAccount();
                return AlertDialog(
                  title: Text(e),
                );
              },
            );
          } else {
            context.go('/');
          }
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Contraseña no coincide'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authCubit = context.watch<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Icon(
                    Icons.account_circle_sharp,
                    color: colors.primary,
                    size: 50,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¡Registrate ya!',
                        style: TextStyle(color: colors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    hintText: 'Correo',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Contraseña',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Confirmar contraseña',
                    obscureText: true,
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    title: 'Crear cuenta',
                    onTap: () => signUp(context, authCubit),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya eres miembro?',
                        style: TextStyle(color: colors.secondary),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          authCubit.reset();
                          context.go('/');
                        },
                        child: Text(
                          'Ingresa ya!',
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
