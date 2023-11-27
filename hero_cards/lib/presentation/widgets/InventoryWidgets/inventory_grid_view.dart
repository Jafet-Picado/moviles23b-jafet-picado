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
    final heroes = context.watch<AuthCubit>().state.heroesMinimal;

    return (!context.watch<AuthCubit>().state.isLoading)
        ? (heroes.isNotEmpty)
            ? Column(
                children: [
                  const SizedBox(height: 15),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.6),
                      ),
                      itemCount: heroes.length,
                      itemBuilder: (context, index) {
                        return CustomGridCard(
                          title: heroes[index].name,
                          elevation: 5,
                          onPressedView: () {
                            context.push('/hero/${heroes[index].id}');
                          },
                          image: heroes[index].image.smallUrl,
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
