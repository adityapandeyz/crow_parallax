import 'dart:async';
import 'package:crow_parallax/screens/game_over_screen.dart';
import 'package:crow_parallax/screens/start_screen.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:crow_parallax/screens/game_play_screen.dart';

import 'actors/crow.dart';

void main() {
  runApp(
    GameWidget(
      game: CrowGame(),
    ),
  );
}

class CrowGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  Vector2 gravity = Vector2(0, 30);
  late final RouterComponent router;
  bool gameOver = false;
  bool showingGameOverScreen = false;
  Crow crow = Crow();
  Stopwatch elapsedTime = Stopwatch();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(
      router = RouterComponent(
        initialRoute: 'start',
        routes: {
          'gameplay': Route(GamePlayScreen.new),
          'gameover': Route(GameOverScreen.new),
          'start': Route(StartScreen.new)
        },
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameOver && !showingGameOverScreen) {
      router.pushNamed('gameover');
      showingGameOverScreen = true;
    }
    super.update(dt);
  }
}
