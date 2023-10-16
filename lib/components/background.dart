import 'package:flame/components.dart';
import 'package:flame_practice/constants/constants.dart';

import '../pages/game_screen/game_screen.dart';

class BackGround extends SpriteComponent with HasGameRef<GameScreen> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(BackGroundImages().bg);
    size = gameRef.size;
  }

  void change() async {
    sprite = await gameRef.loadSprite(BackGroundImages().bg);
  }

  void setToMenuBG() async {
    sprite = await gameRef.loadSprite(BackGroundImages.menuBg);
  }
}
