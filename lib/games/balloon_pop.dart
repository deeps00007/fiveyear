import 'package:flutter/material.dart';

class BalloonPopGame extends StatefulWidget {
  const BalloonPopGame({super.key});

  @override
  State<BalloonPopGame> createState() => _BalloonPopGameState();
}

class _BalloonPopGameState extends State<BalloonPopGame>
    with TickerProviderStateMixin {
  late List<BalloonState> balloons;
  int poppedCount = 0;
  bool gameComplete = false;
  late AnimationController _celebrationController;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _resetGame();
  }

  void _resetGame() {
    balloons = [
      BalloonState(color: Colors.red, isPopped: false),
      BalloonState(color: Colors.yellow, isPopped: false),
      BalloonState(color: Colors.blue, isPopped: false),
    ];
    poppedCount = 0;
    gameComplete = false;
  }

  void _popBalloon(int index) {
    if (balloons[index].isPopped) return;

    setState(() {
      balloons[index] = BalloonState(
        color: balloons[index].color,
        isPopped: true,
      );
      poppedCount++;

      if (poppedCount == balloons.length) {
        gameComplete = true;
        _celebrationController.forward().then((_) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              _playAgain();
            }
          });
        });
      }
    });
  }

  void _playAgain() {
    setState(() {
      _resetGame();
      _celebrationController.reset();
    });
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE5CC),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'POP!',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        spacing: 32,
                        runSpacing: 32,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          balloons.length,
                          (index) => GestureDetector(
                            onTap: () => _popBalloon(index),
                            child: _BalloonWidget(state: balloons[index]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        '$poppedCount/${balloons.length}',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (gameComplete)
              Center(
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _celebrationController,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.celebration,
                        size: 120,
                        color: Color(0xFFFFD700),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 28,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                          elevation: 12,
                        ),
                        onPressed: _playAgain,
                        child: const Text(
                          'PLAY AGAIN',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BalloonState {
  final Color color;
  final bool isPopped;

  BalloonState({required this.color, required this.isPopped});
}

class _BalloonWidget extends StatelessWidget {
  final BalloonState state;

  const _BalloonWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isPopped) {
      return Container(
        width: 140,
        height: 200,
        decoration: const BoxDecoration(color: Colors.transparent),
      );
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 140,
      height: 200,
      decoration: BoxDecoration(
        color: state.color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: state.color.withAlpha((0.4 * 255).toInt()),
            blurRadius: 20,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            width: 16,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.brown[300],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
