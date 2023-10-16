import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game_screen/game_screen.dart';
import '../game_screen/providers/game_screen_provider.dart';

class GameOverMenu extends ConsumerWidget {
  static const String id = 'GameOverMenu';
  final GameScreen gameRef;
  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(gameScreenNotifier);
    return Container(
      height: gameRef.size.y,
      width: gameRef.size.x,
      decoration: const BoxDecoration(color: Colors.black54),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Game Over'),
            const SizedBox(
              height: 10,
            ),
            Text("You Scored:${model.points} Points"),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  gameRef.reset();
                  gameRef.resumeEngine();
                  gameRef.overlays.remove(id);
                },
                child: const Text('Play Again')),
          ],
        ),
      ),
    );
  }
}
