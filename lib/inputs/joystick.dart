import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

JoystickComponent joystickComponent = JoystickComponent(
  knob: CircleComponent(
      radius: 10, paint: BasicPalette.black.withAlpha(200).paint()),
  background: CircleComponent(
    radius: 50,
    paint: BasicPalette.black.withAlpha(200).paint(),
  ),
  margin: const EdgeInsets.only(left: 30, bottom: 40),
);

ButtonComponent buttonComponent = ButtonComponent(
    position: Vector2(650, 300),
    button: CircleComponent(
      radius: 30,
      paint: BasicPalette.red.withAlpha(200).paint(),
    ));
