import 'package:flame_practice/constants/constants.dart';
import 'package:flame_practice/pages/game_screen/game_screen.dart';
import 'package:flutter/material.dart';

class MainMenuSceen extends StatelessWidget {
  final GameScreen gameRef;
  const MainMenuSceen({Key? key, required this.gameRef}) : super(key: key);
  static const String id = 'MainMenu';

  @override
  Widget build(BuildContext context) {
    final size = gameRef.size;
    return Container(
      height: size.y,
      width: size.x,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Constants.menuBg), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  color: Colors.white30,
                ),
                child: const Text(
                  'Zombie Game',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(id);
                  gameRef.start();
                },
                child: const Text('Start')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Exit')),
          ],
        ),
      ),
    );
  }
}
