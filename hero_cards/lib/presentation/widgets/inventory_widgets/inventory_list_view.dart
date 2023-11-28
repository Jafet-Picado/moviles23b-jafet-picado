import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';

class InventoryListView extends StatefulWidget {
  const InventoryListView({super.key});

  @override
  State<InventoryListView> createState() => _InventoryListViewState();
}

class _InventoryListViewState extends State<InventoryListView> {
  @override
  Widget build(BuildContext context) {
    final heroes = context.watch<AuthCubit>().state.heroesMinimal;
    return (!context.watch<AuthCubit>().state.isLoading)
        ? (heroes.isNotEmpty)
            ? Column(
                children: [
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: heroes.length,
                      itemBuilder: (context, index) {
                        return CustomListCard(
                          title: heroes[index].name,
                          elevation: 2,
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
        : const CustomLoadingWidget();
  }
}
