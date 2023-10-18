import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  late final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas UCR'),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Center(
            child: Text('Cursos'),
          ),
          Center(
            child: Text('Profesores'),
          ),
          Center(
            child: Text('Estudiantes'),
          ),
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
              icon: Icon(Icons.calendar_month_rounded), label: 'Cursos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_rounded), label: 'Profeores'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: 'Estudiantes'),
        ],
        onTap: (value) => _pageController.jumpToPage(value),
      ),
    );
  }
}
