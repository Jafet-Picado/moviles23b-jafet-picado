import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InventoryListView extends StatefulWidget {
  const InventoryListView({super.key});

  @override
  State<InventoryListView> createState() => _InventoryListViewState();
}

class _InventoryListViewState extends State<InventoryListView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserCards();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final heroes = context.watch<AuthCubit>().state.heroes;
    return (!context.watch<AuthCubit>().state.isLoading)
        ? (heroes.isNotEmpty)
            ? Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Colección de cartas',
                          style: TextStyle(fontSize: 22, color: colors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: heroes.length,
                      itemBuilder: (context, index) {
                        return CustomListCard(
                          title: heroes[index].name,
                          elevation: 2,
                          onPressedView: () {
                            context.push('/hero/${heroes[index].id}');
                          },
                          image: heroes[index].image.url,
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'No hay cartas actualmente',
                  style: TextStyle(fontSize: 22),
                ),
              )
        : Scaffold(
            body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: colors.primary,
                size: 100,
              ),
            ),
          );
  }
}
