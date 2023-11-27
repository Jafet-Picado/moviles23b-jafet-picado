import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  bool showGrid = false;
  String dropDownValue = 'Lista';

  List<DropdownMenuEntry<bool>> filterTypes = [
    const DropdownMenuEntry(value: false, label: 'Lista'),
    const DropdownMenuEntry(value: true, label: 'Cuadricula'),
  ];

  void _loadCards() {
    context.read<AuthCubit>().getHeroesMinimalByList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            elevation: 5,
            onPressed: () => _loadCards(),
            backgroundColor: colors.primaryContainer,
            foregroundColor: colors.onPrimaryContainer,
            heroTag: null,
            child: const Icon(Icons.sync_rounded),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            elevation: 5,
            onPressed: () {
              setState(() {
                showGrid = !showGrid;
              });
            },
            backgroundColor: colors.primaryContainer,
            foregroundColor: colors.onPrimaryContainer,
            heroTag: null,
            child: (showGrid)
                ? const Icon(Icons.list_alt_rounded, size: 40)
                : const Icon(Icons.grid_on_rounded, size: 35),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                'Colección de cartas',
                style: TextStyle(
                  fontSize: 22,
                  color: colors.secondary,
                  fontFamily: 'Horizon',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: (!showGrid)
                ? const InventoryListView()
                : const InventoryGridView(),
          ),
        ],
      ),
    );
  }
}
