import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool useFingerprint = false;

  @override
  void initState() async {
    super.initState();
    final SharedPreferences prefs = await _preferences;
    useFingerprint = prefs.getBool('useFingerprint') ?? false;
  }

  void signIn(BuildContext context, AuthCubit authCubit) {
    authCubit
        .signInUser(
      _emailController.text,
      _passwordController.text,
    )
        .then((value) {
      if (authCubit.state.error) {
        showDialog(
          context: context,
          builder: (context) {
            String e = authCubit.state.errorMessage;
            authCubit.reset();
            return AlertDialog(
              title: Text(e),
            );
          },
        );
      } else {
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authCubit = context.watch<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingresar',
          textAlign: TextAlign.center,
        ),
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
                        '¡Bienvenido de vuelta!',
                        style: TextStyle(color: colors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  (!useFingerprint)
                      ? CustomTextField(
                          hintText: 'Correo',
                          controller: _emailController,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15),
                  (!useFingerprint)
                      ? CustomTextField(
                          hintText: 'Contraseña',
                          obscureText: true,
                          controller: _passwordController,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15),
                  (!useFingerprint)
                      ? CustomButton(
                          title: 'Ingresar',
                          onTap: () async {
                            signIn(context, authCubit);
                            if (useFingerprint) {
                              final SharedPreferences prefs =
                                  await _preferences;
                              prefs.setBool('useFingerprint', useFingerprint);
                              prefs.setString('email', _emailController.text);
                              prefs.setString(
                                  'password', _passwordController.text);
                            }
                          },
                        )
                      : CustomButton(
                          title: 'Ingresar',
                          icon: true,
                          onTap: () {},
                        ),
                  const SizedBox(height: 20),
                  Text(
                    'Iniciar sesión con datos biométricos: ',
                    style: TextStyle(
                        color: colors.secondary, fontWeight: FontWeight.bold),
                  ),
                  Switch.adaptive(
                    value: useFingerprint,
                    onChanged: (value) =>
                        setState(() => useFingerprint = !useFingerprint),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No eres miembro?',
                        style: TextStyle(color: colors.secondary),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          authCubit.isCreatingAccount();
                          context.go('/register');
                        },
                        child: Text(
                          'Registrate ya!',
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
