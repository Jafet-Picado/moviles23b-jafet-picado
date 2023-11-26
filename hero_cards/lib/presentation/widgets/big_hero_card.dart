import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs.dart';

class BigHeroCard extends StatefulWidget {
  final int id;
  const BigHeroCard({super.key, required this.id});

  @override
  State<BigHeroCard> createState() => _BigHeroCardState();
}

class _BigHeroCardState extends State<BigHeroCard> {
  bool isBack = true;
  double angle = 0;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AssetSource _audio = AssetSource('sounds/hero.mp3');
  final AssetSource _tapAudio = AssetSource('sounds/cinematic.mp3');

  @override
  void initState() {
    super.initState();
    context.read<HeroCubit>().getHeroById(id: widget.id);
    _initPlayer();
  }

  void _initPlayer() async {
    await _audioPlayer.play(_audio, mode: PlayerMode.mediaPlayer);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _flip() {
    if (isBack) {
      setState(() {
        angle = (angle + pi) % (2 * pi);
        _audioPlayer.pause();
        _audioPlayer
            .play(_tapAudio, mode: PlayerMode.mediaPlayer)
            .then((value) => Future.delayed(const Duration(seconds: 5), () {
                  _audioPlayer.pause();
                  _audioPlayer.play(_audio, mode: PlayerMode.mediaPlayer);
                }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final heroCubit = context.read<HeroCubit>();

    const colorizeColors = [
      Colors.black,
      Colors.purple,
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.pink,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 35.0,
      fontFamily: 'Horizon',
    );

    return GestureDetector(
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
                                  size: const Size.fromRadius(130),
                                  child: Image.network(
                                    heroCubit.state.hero!.image.url,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/noimagen.jpg',
                                        fit: BoxFit.cover,
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
                                      heroCubit.state.hero!.name,
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                      textAlign: TextAlign.center,
                                      speed: const Duration(seconds: 1),
                                    ),
                                  ],
                                  repeatForever: true,
                                ),
                              ),
                              (heroCubit.state.hero!.biography.publisher !=
                                      'null')
                                  ? Text(
                                      heroCubit.state.hero!.biography.publisher,
                                      style: const TextStyle(
                                        fontFamily: 'Horizon',
                                        fontSize: 20,
                                        color: Colors.black,
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
    );
  }
}
