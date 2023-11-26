import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InventoryGridView extends StatefulWidget {
  const InventoryGridView({super.key});

  @override
  State<InventoryGridView> createState() => _InventoryGridViewState();
}

class _InventoryGridViewState extends State<InventoryGridView> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final heroes = context.watch<AuthCubit>().state.heroes;

    return (!context.watch<AuthCubit>().state.isLoading)
        ? (heroes.isNotEmpty)
            ? Column(
                children: [
                  const SizedBox(height: 15),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: heroes.length,
                      itemBuilder: (context, index) {
                        return CustomGridCard(
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
