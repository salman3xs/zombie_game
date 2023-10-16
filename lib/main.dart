import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_practice/pages/main_menu_sceen/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/game_over_menu/game_over_menu.dart';
import 'pages/game_screen/game_screen.dart';
import 'pages/game_screen/game_screen_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setLandscape();
  Flame.device.fullScreen();
  runApp( const ProviderScope(
    child: Homegame()
  ));
}
final gameScreenProvider = Provider((ref)=>
  GameScreen(ref)
);

class Homegame extends ConsumerWidget {
  const Homegame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GameWidget(
      game: ref.read(gameScreenProvider),
      overlayBuilderMap: {
        GameSceenOverlay.id: (BuildContext context, GameScreen gameRef) =>
            GameSceenOverlay(gameRef: gameRef),
        GameOverMenu.id: (BuildContext context, GameScreen gameRef) =>
            GameOverMenu(gameRef: gameRef),
        MainMenuSceen.id: (BuildContext context, GameScreen gameRef) =>
            MainMenuSceen(gameRef: gameRef),
        
      },
    );
  }
}