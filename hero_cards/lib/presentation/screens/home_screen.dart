import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/screens.dart';
import 'package:hero_cards/presentation/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HeroCubit()),
      ],
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  int _selectedIndex = 1;
  late final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserCards();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Cards'),
        actions: [
          IconButton(
              onPressed: () {
                authCubit.signOutUser().then((value) {
                  context.go('/');
                });
              },
              icon: Icon(
                Icons.logout_rounded,
                color: colors.onBackground,
              ))
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          BigHeroCardScreen(),
          InventoryView(),
          Text('Jugadores'),
        ],
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.store_rounded), label: 'Tienda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage_rounded), label: 'Inventario'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded), label: 'Jugadores'),
        ],
        onTap: (value) => _pageController.jumpToPage(value),
      ),
    );
  }
}
