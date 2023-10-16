import 'dart:math';

class Constants {
  Constants._();
    static const String menuBg = 'assets/images/menu_bg.jpg';
}

class RobotImages {
  RobotImages._();
  static const String idle = 'robo_idle.png';
  static const String run = 'robo_run.png';
  static const String death = 'robo_death.png';
  static const String melee = 'robo_melee.png';
}

class ZombieImages {
  ZombieImages._();
  static const String idle = 'zombie_idle.png';
  static const String run = 'zombie_run.png';
  static const String attack = 'zombie_attack.png';
  static const String death = 'zombie_death.png';
  static const String femaleIdle = 'zombieF_idle.png';
  static const String femaleRun = 'zombieF_run.png';
  static const String femaleDeath = 'zombieF_death.png';
}

class BackGroundImages {
  static const String bg1 = 'bg1.jpg';
  static const String bg2 = 'bg2.jpg';
  static const String bg3 = 'bg3.jpg';
  static const String menuBg = 'menu_bg.jpg';
  String get bg {
    return [bg1, bg2, bg3][Random().nextInt(3)];
  }
}
