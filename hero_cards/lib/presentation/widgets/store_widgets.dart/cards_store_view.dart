import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:hero_cards/presentation/blocs/hero_cubit/hero_cubit.dart';
import 'package:hero_cards/presentation/widgets.dart';

class CardsStoreView extends StatefulWidget {
  const CardsStoreView({super.key});

  @override
  State<CardsStoreView> createState() => _CardsStoreViewState();
}

class _CardsStoreViewState extends State<CardsStoreView> {
  //Map con los diferentes precios posibles para una carta de la tienda
  static final Map<String, int> _prices = {
    '1': 1000,
    '2': 2000,
    '3': 3000,
    '4': 4000,
  };

  final List<Widget> _heroCards = [];
  bool _cardsLoaded = false;
  int _currentTrending = 0;
  int _currentRecent = 0;
  final CarouselController _controllerTrending = CarouselController();
  final CarouselController _controllerRecent = CarouselController();

  //Método encargado de añadir la carta a la lista del usuario si tiene los fondos
  //suficientes y de mostrar un mensaje informativo al finalizar o al dar error
  void _buyCard(AuthCubit authCubit, ColorScheme colors, int price, int id) {
    if ((authCubit.state.balance - price) < 0) {
      _showDialog(
        context: context,
        message: 'Insuficientes HeroCoins para realizar la compra',
        icon: Icons.error_rounded,
        color: Colors.red,
        colors: colors,
        otherMessage: '¿Desea comprar más HeroCoins?',
        path: '/balance_store',
        height: 200,
      );
    } else {
      authCubit.updateBalance(amount: -price);
      authCubit.addCard(id: id);
      _showDialog(
        context: context,
        message: 'Compra exitosa',
        icon: Icons.check_circle_rounded,
        color: colors.onBackground,
        colors: colors,
        height: 120,
      );
    }
  }

  //Método encargado de retornar una lista de Cards para el carrusel de cartas
  List<Widget> _getHeroCards(
      HeroCubit heroCubit, AuthCubit authCubit, ColorScheme colors) {
    if (!_cardsLoaded) {
      for (HeroInfoMinimal hero in heroCubit.state.heroesMinimal) {
        int price = Random().nextInt(4) + 1;
        _heroCards.add(CustomSliderCard(
          name: hero.name,
          image: hero.image.smallUrl,
          publisher: hero.publisher,
          price: _prices['$price'].toString(),
          onTap: () {
            _buyCard(authCubit, colors, _prices['$price']!, hero.id);
          },
        ));
      }
      _cardsLoaded = true;
    }
    return _heroCards;
  }

  //Método encargado de mostrar un popup personalizado con un mensaje informativo
  void _showDialog({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color color,
    required ColorScheme colors,
    String? otherMessage,
    String? path,
    required double height,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 5,
            child: SizedBox(
              height: height,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Icon(
                    icon,
                    color: color,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  (otherMessage != null)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(this);
                            context.push('$path');
                          },
                          child: Text(
                            otherMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    if (context.read<HeroCubit>().state.heroesMinimal.isEmpty) {
      context.read<HeroCubit>().getRandomHeroesMinimal();
    }
  }

  @override
  Widget build(BuildContext context) {
    final heroCubit = context.read<HeroCubit>();
    final authCubit = context.read<AuthCubit>();
    final colors = Theme.of(context).colorScheme;
    return (!context.watch<HeroCubit>().state.isLoading)
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up_rounded, size: 40),
                      SizedBox(width: 10),
                      Text(
                        'Populares',
                        style: TextStyle(
                          fontFamily: 'Horizon',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    items: _getHeroCards(heroCubit, authCubit, colors)
                        .sublist(0, 5),
                    carouselController: _controllerTrending,
                    options: CarouselOptions(
                        height: 350,
                        viewportFraction: .9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentTrending = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _heroCards.take(5).toList().asMap().entries.map(
                      (entry) {
                        return GestureDetector(
                          onTap: () =>
                              _controllerTrending.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (_currentTrending != entry.key)
                                  ? Colors.white.withOpacity(0.4)
                                  : colors.primary,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.new_releases_rounded, size: 40),
                      SizedBox(width: 10),
                      Text(
                        'Recientes',
                        style: TextStyle(
                          fontFamily: 'Horizon',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    items: _getHeroCards(heroCubit, authCubit, colors)
                        .sublist(5, 8),
                    carouselController: _controllerRecent,
                    options: CarouselOptions(
                        height: 350,
                        viewportFraction: .9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentRecent = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _heroCards.sublist(5, 8).asMap().entries.map(
                      (entry) {
                        return GestureDetector(
                          onTap: () =>
                              _controllerRecent.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (_currentRecent != entry.key)
                                  ? Colors.white.withOpacity(0.4)
                                  : colors.primary,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 5,
              onPressed: () {
                context.push('/random_card');
              },
              backgroundColor: colors.primaryContainer,
              foregroundColor: colors.onBackground,
              heroTag: null,
              child: const Icon(Icons.card_giftcard_rounded),
            ),
          )
        : const CustomLoadingWidget();
  }
}
