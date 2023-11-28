import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BigHeroCard extends StatefulWidget {
  const BigHeroCard({super.key});

  @override
  State<BigHeroCard> createState() => _BigHeroCardState();
}

class _BigHeroCardState extends State<BigHeroCard> {
  bool isBack = true;
  double angle = 0;

  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.loop);
  final AudioPlayer _tapPlayer = AudioPlayer();
  final AssetSource _audio = AssetSource('sounds/hero.mp3');
  final AssetSource _tapAudio = AssetSource('sounds/cinematic.mp3');

  @override
  void initState() {
    super.initState();
    context.read<HeroCubit>().getHeroMinimalRandom();
    _initPlayer();
  }

  void _initPlayer() async {
    await _audioPlayer.play(_audio, mode: PlayerMode.mediaPlayer);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _tapPlayer.dispose();
    super.dispose();
  }

  void _flip() {
    if (context.read<AuthCubit>().state.balance >= 1000) {
      if (isBack) {
        setState(() {
          angle = (angle + pi) % (2 * pi);
          _audioPlayer.pause();
          _tapPlayer.play(_tapAudio, mode: PlayerMode.mediaPlayer).then(
                (value) => Future.delayed(
                  const Duration(seconds: 5),
                  () {
                    _tapPlayer.pause();
                    _audioPlayer.resume();
                  },
                ),
              );
        });
        context.read<AuthCubit>().addCard(
              id: context.read<HeroCubit>().state.heroMinimal!.id,
            );
        context.read<AuthCubit>().updateBalance(amount: -1000);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 5,
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.error_rounded,
                    color: Colors.red,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Fondos insuficientes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop(this);
                      _audioPlayer.pause();
                      context.push('/balance_store');
                    },
                    child: Text(
                      '¿Desea comprar más HeroCoins?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hero = context.read<HeroCubit>().state.heroMinimal;

    const colorizeColors = [
      Colors.white,
      Colors.purple,
      Colors.blue,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 35.0,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold,
    );

    return (!context.watch<HeroCubit>().state.isLoading)
        ? GestureDetector(
            onTap: _flip,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: angle),
              duration: const Duration(seconds: 1),
              builder: (context, double val, __) {
                if (val >= (pi / 2)) {
                  isBack = false;
                } else {
                  isBack = true;
                }
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(val),
                  child: SizedBox(
                    width: 309,
                    height: 474,
                    child: isBack
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/back.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Column(
                                children: [
                                  Text(
                                    'Toque para comprar.',
                                    style: TextStyle(
                                      fontFamily: 'Horizon',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Coste 1000 HeroCoins',
                                    style: TextStyle(
                                      fontFamily: 'Horizon',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(pi),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/face.png'),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(110),
                                        child: Image.network(
                                          hero!.image.smallUrl,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/noimagen.jpg',
                                              fit: BoxFit.fill,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Flexible(
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            (hero.name == '')
                                                ? 'Desconocido'
                                                : hero.name,
                                            textStyle: colorizeTextStyle,
                                            colors: colorizeColors,
                                            textAlign: TextAlign.center,
                                            speed: const Duration(
                                                milliseconds: 500),
                                          ),
                                        ],
                                        repeatForever: true,
                                      ),
                                    ),
                                    ('xd' != 'null')
                                        ? Text(
                                            (hero.publisher == '')
                                                ? 'Desconocido'
                                                : hero.publisher,
                                            style: const TextStyle(
                                              fontFamily: 'Horizon',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
          )
        : const CustomLoadingWidget();
  }
}
