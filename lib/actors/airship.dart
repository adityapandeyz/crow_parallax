import 'dart:math';

import 'package:crow_parallax/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class AirShip extends SpriteComponent with HasGameRef<CrowGame> {
  AirShip() : super() {
    debugMode = true;
  }
  final _random = Random();
  @override
  void onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('airship_shiven.png');
    size = Vector2(gameRef.size.y * 600 / 500, gameRef.size.y) * 0.2;
    flipHorizontallyAroundCenter();
    double yPostion = _random.nextDouble() * game.size.y;

    position = Vector2(gameRef.size.x * 0.95, yPostion);

    add(
      CircleHitbox(
          anchor: Anchor.center, radius: size.y * .35, position: size / 2),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (x > 0 && !gameRef.gameOver) {
      x = x - 100 * dt;
    } else {
      removeFromParent();
    }

    if (gameRef.elapsedTime.elapsed.inSeconds > 30 && x > gameRef.crow.x) {
      if (gameRef.crow.y > y) {
        y += 3 * dt;
      } else {
        y -= 3 * dt;
      }
    }
  }
}
