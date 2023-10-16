import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';
import 'package:flame_practice/components/player.dart';
import 'package:flame_practice/constants/constants.dart';
import '../pages/game_screen/game_screen.dart';

class FemaleZombie extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<GameScreen> {
  final double _spriteHeight = 100;
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;
  final double _animationSpeed = 0.2;
  late final SpriteAnimation _standingAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _attackAnimation;
  late final SpriteAnimation _deathAnimation;
  final moveController = EffectController(duration: 10);
  bool moving = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 55;
    _downBound = gameRef.size.y - 85;
    height = _spriteHeight;
    width = _spriteHeight * 0.70;
    anchor = Anchor.center;
    await _loadAnimations().then((_) => {animation = _standingAnimation});
    add(RectangleHitbox(size: Vector2(30, 20)));
    init();
  }

  @override
  void update(dt) {
    super.update(dt);
    if (x >= _rightBound) {
      x = _rightBound - 1;
    }
    if (x <= _leftBound) {
      x = _leftBound + 1;
    }
    if (y <= _upBound) {
      y = _upBound + 1;
    }
    if (y >= _downBound) {
      y = _downBound - 1;
    }
    if (moveController.completed && !moving) {
      animation = _standingAnimation;
      moving = true;
      Future.delayed(const Duration(seconds: 1), () => move());
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      gameRef.collideZombie();
    }
    super.onCollision(intersectionPoints, other);
  }

  Future<void> _loadAnimations() async {
    final spriteSize = Vector2(430, 519);
    //Running Animation
    final spriteSheet = await gameRef.images.load(ZombieImages.femaleRun);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 10, stepTime: 0.1, textureSize: spriteSize);
    _runAnimation = SpriteAnimation.fromFrameData(spriteSheet, spriteData);
    //Standing Animation
    final idleImage = SpriteSheet(
      image: await gameRef.images.load(ZombieImages.femaleIdle),
      srcSize: spriteSize,
    );
    _standingAnimation =
        idleImage.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
    final deathSpriteSheet = await gameRef.images.load(ZombieImages.femaleDeath);
    //death Animation
    SpriteAnimationData deathSpriteData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.3, textureSize: spriteSize);
    _deathAnimation =
        SpriteAnimation.fromFrameData(deathSpriteSheet, deathSpriteData);
  }

  void move() {
    moving = false;
    final double randomX = Random().nextInt(gameRef.size.x.toInt()).toDouble();
    final double randomY = Random().nextInt(gameRef.size.y.toInt()).toDouble();
    animation = _runAnimation;
    moveController.setToStart();
    if (position.x > randomX && !isFlippedHorizontally) {
      flipHorizontally();
    }
    if (position.x < randomX && isFlippedHorizontally) {
      flipHorizontally();
    }
    add(MoveToEffect(Vector2(randomX, randomY), moveController));
  }

  void death() {
    moveController.setToEnd();
    animation = _deathAnimation;
  }

  void init() {
    final double randomX = Random().nextInt(gameRef.size.x.toInt()).toDouble();
    final double randomY = Random().nextInt(gameRef.size.y.toInt()).toDouble();
    position = Vector2(randomX, randomY);
    animation = _standingAnimation;
    moveController.setToEnd();
  }
}
