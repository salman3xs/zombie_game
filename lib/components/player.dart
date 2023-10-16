import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_practice/constants/constants.dart';
import '../pages/game_screen/game_screen.dart';

// enum MovementState { idle, moveUp, moveDown, moveLeft, moveRight }

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<GameScreen> {
  Player({required this.joystick, required this.button});
  final JoystickComponent joystick;
  final ButtonComponent button;
  final double _spriteHeight = 100;
  double _speed = 500;
  bool isAlive = true;
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;
  final double _animationSpeed = 0.2;
  late final SpriteAnimation _standingAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _deathAnimation;
  late final SpriteAnimation _meleeAnimation;
  bool isAttacking = false;
  bool buttonPressed = false;
  int pressedSec = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: Vector2(30, 20)));
    await _loadAnimations().then((_) => {animation = _standingAnimation});

    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 55;
    _downBound = gameRef.size.y - 85;

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 0.70;
    anchor = Anchor.center;
    init();
  }

  @override
  void update(dt) {
    super.update(dt);
    if (!buttonPressed) {
      pressedSec += 1;
    }
    if (pressedSec > 7) {
      isAttacking = false;
    }
    if (isAlive) {
      if (isAttacking) {
        animation = _meleeAnimation;
      } else {
        if (joystick.direction != JoystickDirection.idle) {
          animation = _runAnimation;
        } else {
          animation = _standingAnimation;
        }
      }
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
      position.add(joystick.relativeDelta * _speed * dt);
      if (joystick.relativeDelta.x < 0 && !isFlippedHorizontally) {
        flipHorizontally();
      }
      if (joystick.relativeDelta.x > 0 && isFlippedHorizontally) {
        flipHorizontally();
      }
    }
  }

  Future<void> _loadAnimations() async {
    final spriteSize = Vector2(567, 556);
    //Standing Animation
    final idleImage = SpriteSheet(
      image: await gameRef.images.load(RobotImages.idle),
      srcSize: spriteSize,
    );
    _standingAnimation =
        idleImage.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
    //Running Animation
    final runSpriteSheet = await gameRef.images.load(RobotImages.run);
    SpriteAnimationData runSpriteData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.3, textureSize: spriteSize);
    _runAnimation =
        SpriteAnimation.fromFrameData(runSpriteSheet, runSpriteData);
    //death Animation
    final deathSpriteSheet = await gameRef.images.load(RobotImages.death);
    SpriteAnimationData deathSpriteData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.3, textureSize: spriteSize);
    _deathAnimation =
        SpriteAnimation.fromFrameData(deathSpriteSheet, deathSpriteData);
    //Melee Animation
    final meleeSpriteSheet = await gameRef.images.load(RobotImages.melee);
    SpriteAnimationData meleeSpriteData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.1, textureSize: spriteSize);
    _meleeAnimation =
        SpriteAnimation.fromFrameData(meleeSpriteSheet, meleeSpriteData);
    _meleeAnimation.loop = false;
    _meleeAnimation.onComplete = () {
      isAttacking = false;
    };
  }

  void death() {
    _speed = 0;
    isAlive = false;
    animation = _deathAnimation;
  }

  void init() {
    _speed = 500;
    isAlive = true;
    animation = _standingAnimation;
    position = gameRef.size / 2;
  }
}
