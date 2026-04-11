import 'package:flutter/material.dart';

class BalloonState {
  final Color color;
  final bool isPopped;
  BalloonState({required this.color, required this.isPopped});
}

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
        duration: const Duration(milliseconds: 600), vsync: this);
    _resetGame();
  }

  void _resetGame() {
    balloons = [
      BalloonState(color: const Color(0xFFE53935), isPopped: false),
      BalloonState(color: const Color(0xFFFFB300), isPopped: false),
      BalloonState(color: const Color(0xFF1E88E5), isPopped: false),
      BalloonState(color: const Color(0xFF43A047), isPopped: false),
      BalloonState(color: const Color(0xFF8E24AA), isPopped: false),
    ]..shuffle();
    poppedCount = 0;
    gameComplete = false;
    _celebrationController.reset();
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
        _celebrationController.forward();
      }
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFF29B6F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16, left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCA28),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: const [BoxShadow(color: Color(0xFFF57F17), offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 32),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text('POP THEM ALL!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=8..color=const Color(0xFF0277BD))),
                        const Text('POP THEM ALL!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Wrap(
                      spacing: 20, runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: List.generate(balloons.length, (index) {
                        return GestureDetector(
                          onTap: () => _popBalloon(index),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 150),
                            opacity: balloons[index].isPopped ? 0.0 : 1.0,
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 150),
                              scale: balloons[index].isPopped ? 1.5 : 1.0,
                              child: Container(
                                width: 90, height: 110,
                                decoration: BoxDecoration(
                                  color: balloons[index].color,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(45), topRight: Radius.circular(45),
                                    bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40),
                                  ),
                                  border: Border.all(color: Colors.white.withAlpha(150), width: 3),
                                  boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 8), blurRadius: 5)],
                                ),
                                child: Align(
                                  alignment: const Alignment(0.5, -0.6),
                                  child: Container(
                                    width: 15, height: 25,
                                    decoration: BoxDecoration(color: Colors.white.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              if (gameComplete)
                Container(
                  color: Colors.black.withAlpha(100),
                  child: Center(
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _celebrationController, curve: Curves.elasticOut)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF64DD17), Color(0xFF2E7D32)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(40), border: Border.all(color: Colors.white, width: 8),
                          boxShadow: [const BoxShadow(color: Color(0xFF1B5E20), offset: Offset(0, 8)), BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20, offset: const Offset(0, 15))]
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Text('YOU WIN!', style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 10..color = const Color(0xFFF57F17))),
                                const Text('YOU WIN!', style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Color(0xFFFFCA28))),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 64), Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 80), Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 64)]),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (mounted) setState(() { _resetGame(); });
                                  },
                                  child: Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFFFFCA28), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4), boxShadow: const [BoxShadow(color: Color(0xFFF57F17), offset: Offset(0, 4))]), child: const Icon(Icons.replay_rounded, color: Colors.white, size: 36)),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFF4DD0E1), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4), boxShadow: const [BoxShadow(color: Color(0xFF00838F), offset: Offset(0, 4))]), child: const Icon(Icons.home_rounded, color: Colors.white, size: 36)),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    if (mounted) setState(() { _resetGame(); });
                                  },
                                  child: Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFFFF7043), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4), boxShadow: const [BoxShadow(color: Color(0xFFD84315), offset: Offset(0, 4))]), child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 36)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
