import 'package:flutter/material.dart';

class CountAndTapGame extends StatefulWidget {
  const CountAndTapGame({super.key});

  @override
  State<CountAndTapGame> createState() => _CountAndTapGameState();
}

class _CountAndTapGameState extends State<CountAndTapGame>
    with TickerProviderStateMixin {
  int targetCount = 0;
  int currentCount = 0;
  bool gameComplete = false;
  late AnimationController _celebrationController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      // ...existing code...
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _startNewRound();
  }

  void _startNewRound() {
    setState(() {
      targetCount = 2 + (DateTime.now().microsecond % 4);
      currentCount = 0;
      gameComplete = false;
      _celebrationController.reset();
    });
  }

  void _tap() {
    if (gameComplete) return;

    setState(() {
      currentCount++;
    });

    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    if (currentCount == targetCount) {
      setState(() {
        gameComplete = true;
      });
      _celebrationController.forward();
    }
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF48FB1), Color(0xFF6A1B9A)],
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
                        Text('TAP  TIMES!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=8..color=const Color(0xFF4A148C))),
                        Text('TAP  TIMES!', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: _tap,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController),
                        child: Container(
                          width: 200, height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE91E63),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 6),
                            boxShadow: const [BoxShadow(color: Color(0xFF880E4F), offset: Offset(0, 10))],
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                Text('', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900, foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=8..color=const Color(0xFF880E4F))),
                                Text('', style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w900, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                                    if (mounted) setState(() { _startNewRound(); });
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
                                    if (mounted) setState(() { _startNewRound(); });
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
