import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/presentation/blocs/hero_cubit/hero_cubit.dart';
import 'package:hero_cards/presentation/widgets.dart';
import 'package:photo_view/photo_view.dart';

class HeroInfoScreen extends StatelessWidget {
  final int id;
  const HeroInfoScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => HeroCubit())),
      ],
      child: _HeroInfoScreen(id: id),
    );
  }
}

class _HeroInfoScreen extends StatefulWidget {
  final int id;
  const _HeroInfoScreen({
    required this.id,
  });

  @override
  State<_HeroInfoScreen> createState() => _HeroInfoScreenState();
}

class _HeroInfoScreenState extends State<_HeroInfoScreen> {
  //Método utilizado para construir una lista de filas con los valores
  //de la lista
  List<Widget> _buildRows(List<EntityFirstAppearedInIssue> list) {
    return list.map((friend) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            friend.name!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<HeroCubit>().getHeroDetailedById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final hero = context.read<HeroCubit>().state.heroDetailed;

    return (!context.watch<HeroCubit>().state.isLoading)
        ? Scaffold(
            appBar: AppBar(
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  hero!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Horizon',
                  ),
                ),
              ),
              leading: CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.arrow_back_rounded,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(this);
                              },
                              child: PhotoView(
                                imageProvider: Image.network(
                                  hero.image.mediumUrl,
                                ).image,
                              ),
                            );
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        hero.image.mediumUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            hero.image.smallUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/noimagen.jpg');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    (hero.deck == '') ? '' : '"${hero.deck}"',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nombre real: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Horizon',
                        ),
                      ),
                      Text(
                        (hero.realName == "") ? 'Desconocido' : hero.realName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Raza: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Horizon',
                        ),
                      ),
                      Text(
                        (hero.origin.name == "")
                            ? 'Desconocido'
                            : hero.origin.name!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Aliados: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  (hero.characterFriends.isEmpty)
                      ? const Text(
                          'Desconocido',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Column(
                          children: [
                            ..._buildRows(hero.characterFriends),
                          ],
                        ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enemigos: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  (hero.characterFriends.isEmpty)
                      ? const Text(
                          'Desconocido',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Column(
                          children: [
                            ..._buildRows(hero.characterEnemies),
                          ],
                        ),
                  const SizedBox(height: 10),
                  const Text(
                    'Poderes: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                  ),
                  (hero.powers.isEmpty)
                      ? const Text(
                          'Desconocido',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Column(
                          children: [
                            ..._buildRows(hero.powers),
                          ],
                        ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Publisher: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Horizon',
                        ),
                      ),
                      Text(
                        (hero.publisher.name == "")
                            ? 'Desconocido'
                            : hero.publisher.name!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        : const CustomLoadingWidget();
  }
}
