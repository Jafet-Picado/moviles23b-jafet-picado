import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_firebase/presentation/blocs.dart';
import 'package:login_firebase/presentation/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().getPosts('users_posts');
  }

  void onProfileTap() {
    context.pop();
    context.push('/profile');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final authCubit = context.read<AuthCubit>();
    final postsCubit = context.read<PostsCubit>();

    final posts = context.watch<PostsCubit>().state.posts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizarra de mensajes'),
        actions: [
          IconButton(
            onPressed: () {
              authCubit.signOutUser().then((value) => context.go('/'));
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onHomeTap: () {},
        onProfileTap: onProfileTap,
        onLogoutTap: () {},
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return CustomPost(
                      user: post['email'],
                      message: post['message'],
                      postId: post['id'],
                      likes: List<String>.from(post['likes'] ?? []),
                      collectionPath: 'users_posts',
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Escribe un mensaje',
                      controller: _messageController,
                    ),
                  ),
                  const SizedBox(width: 15),
                  IconButton.filled(
                    onPressed: () {
                      postsCubit.addPost(
                        'users_posts',
                        authCubit.state.email,
                        _messageController.text,
                      );
                      _messageController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registrado como: ',
                    style: TextStyle(
                      color: colors.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    authCubit.state.email,
                    style: TextStyle(
                        color: colors.primary, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
