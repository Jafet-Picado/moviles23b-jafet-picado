import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs/hero_cubit/hero_cubit.dart';
import 'package:hero_cards/presentation/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<HeroCubit>().getHeroDetailedById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final hero = context.read<HeroCubit>().state.heroDetailed;
    final colors = Theme.of(context).colorScheme;
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
