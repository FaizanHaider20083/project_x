import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CatchBallGame extends FlameGame with TapDetector {
  late Ball ball;
  late TextComponent scoreText;
  late TextComponent resultText;
  int score = 0;
  bool isLeftSide = true;

  @override
  Future<void> onLoad() async {
    ball = Ball();
    add(ball);

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 10),
      anchor: Anchor.topLeft,
    );
    add(scoreText);

    resultText = TextComponent(
      text: '',
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );
    add(resultText);
  }

  @override
  void update(double dt) {
    super.update(dt);
    isLeftSide = ball.position.x < size.x / 2;
  }

  void catchBall(bool isLeftButton) {
    if ((isLeftSide && isLeftButton) || (!isLeftSide && !isLeftButton)) {
      score++;
      resultText.text = 'Caught!';
    } else {
      resultText.text = 'Missed!';
    }
    scoreText.text = 'Score: $score';
    resetBall();
  }

  void resetBall() {
    ball.reset();
  }
}

class Ball extends CircleComponent with HasGameRef<CatchBallGame> {
  static const double ballRadius = 10;
  static const double ballSpeed = 100;

  late Vector2 velocity;

  Ball() : super(radius: ballRadius, paint: Paint()..color = Colors.red);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    reset();
  }

  void reset() {
    position = Vector2(gameRef.size.x / 2, gameRef.size.y / 4);
    double angle = (Random().nextDouble() - 0.5) * pi / 2;
    velocity = Vector2(ballSpeed * sin(angle), ballSpeed * cos(angle));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.y > gameRef.size.y) {
      gameRef.resetBall();
    }
  }
}

class CatchBallGameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: CatchBallGame(),
        overlayBuilderMap: {
          'buttons': (context, game) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => (game as CatchBallGame).catchBall(true),
                    child: Text('Left'),
                  ),
                  ElevatedButton(
                    onPressed: () => (game as CatchBallGame).catchBall(false),
                    child: Text('Right'),
                  ),
                ],
              ),
            );
          },
        },
        initialActiveOverlays: const ['buttons'],
      ),
    );
  }
}
