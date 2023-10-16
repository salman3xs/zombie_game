import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'game_screen.dart';
import 'providers/game_screen_provider.dart';

class GameSceenOverlay extends ConsumerWidget {
  static const String id = 'GameScreenOverlay';
  final GameScreen gameRef;
  const GameSceenOverlay({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameScreenNotifier);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.black54,
        ),
        child: Text(
          'Points:${provider.points}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
