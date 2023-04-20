import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';

import 'package:crow_parallax/actors/airship.dart';
import 'package:crow_parallax/main.dart';
import 'package:crow_parallax/gui/elapsed_time.dart';

class GamePlayScreen extends Component with HasGameRef<CrowGame>, TapCallbacks {
  Timer interval = Timer(6, repeat: true);

  @override
  void onLoad() async {
    await super.onLoad();
    gameRef.elapsedTime.start();
    ParallaxComponent mountainBackground = await gameRef.loadParallaxComponent(
      [
        ParallaxImageData('sky.png'),
        ParallaxImageData('clouds_bg.png'),
        ParallaxImageData('glacial_mountains.png'),
        ParallaxImageData('clouds_mg_1.png'),
        ParallaxImageData('cloud_lonely.png')
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0),
    );
    add(mountainBackground);

    addShips();

    add(gameRef.crow);

    add(ElapsedTime());
  }

  void addShips() {
    interval.onTick = () {
      double elapsedSeconds = gameRef.elapsedTime.elapsed.inSeconds.toDouble();
      void addShipsAtSecond(int secondToAdd) {
        Future.delayed(
          Duration(seconds: secondToAdd),
          () => add(AirShip()),
        );
      }

      add(
        AirShip(),
      );

      if (elapsedSeconds > 10.0) {
        addShipsAtSecond(3);
      }

      if (elapsedSeconds > 20.0) {
        addShipsAtSecond(3);
      }
      if (elapsedSeconds > 30.0) {
        addShipsAtSecond(4);
      }
    };
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.gravity.y -= 20;

    super.onTapUp(event);
  }
}
