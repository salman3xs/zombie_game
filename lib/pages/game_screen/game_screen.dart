import 'package:flame/game.dart';
import 'package:flame_practice/components/background.dart';
import 'package:flame_practice/components/player.dart';
import 'package:flame_practice/components/male_zombie.dart';
import 'package:flame_practice/pages/game_over_menu/game_over_menu.dart';
import 'package:flame_practice/pages/main_menu_sceen/main_menu_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/female_zombie.dart';
import '../../inputs/joystick.dart';
import '../game_screen/providers/game_screen_provider.dart';
import 'game_screen_overlay.dart';

class GameScreen extends FlameGame
    with HasCollisionDetection, HasDraggables, HasTappables {
  final _player = Player(joystick: joystickComponent, button: buttonComponent);
  final _maleZombie = MaleZombie();
  final _femaleZombie = FemaleZombie();
  final _backGround = BackGround();
  final Ref ref;
  GameScreen(this.ref);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    pauseEngine();
    overlays.add(MainMenuSceen.id);
  }

  void start() async {
    add(_backGround);
    add(_maleZombie);
    await add(_player);
    await add(joystickComponent);
    await add(buttonComponent);
    buttonComponent.onPressed = () {
      _player.pressedSec = 0;
      _player.isAttacking = true;
      _player.buttonPressed = true;
    };
    buttonComponent.onReleased = () {
      _player.buttonPressed = false;
    };
    overlays.add(GameSceenOverlay.id);
    resumeEngine();
  }

  void collideZombie() {
    if (_player.isAttacking) {
      catchZombie();
    } else {
      death();
    }
  }

  void catchZombie() {
    _maleZombie.death();
    ref.read(gameScreenNotifier).addPoint();
  }

  void moveZombie(MaleZombie zombie) {
    zombie.move();
  }

  void death() {
    _maleZombie.moveController.setToEnd();
    _player.death();
    Future.delayed(const Duration(seconds: 1), () {
      pauseEngine();
      overlays.add(GameOverMenu.id);
    });
  }

  void reset() {
    ref.read(gameScreenNotifier).resetPoint();
    _backGround.change();
    _player.init();
    _maleZombie.init();
  }
}
