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
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _startNewRound();
  }

  void _startNewRound() {
    setState(() {
      targetCount = 2 + (DateTime.now().microsecond % 4);
      currentCount = 0;
      gameComplete = false;
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
      _celebrationController.forward().then((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _startNewRound();
            _celebrationController.reset();
          }
        });
      });
    } else if (currentCount > targetCount) {
      setState(() {
        currentCount = 0;
      });
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
      backgroundColor: const Color(0xFFE3F2FD),
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
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF2196F3,
                              ).withAlpha((0.4 * 255).toInt()),
                              blurRadius: 20,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$targetCount',
                            style: const TextStyle(
                              fontSize: 96,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'TAP',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$currentCount',
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ScaleTransition(
                        scale: Tween<double>(begin: 1.0, end: 1.15).animate(
                          CurvedAnimation(
                            parent: _scaleController,
                            curve: Curves.elasticOut,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: _tap,
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4CAF50,
                                  ).withAlpha((0.5 * 255).toInt()),
                                  blurRadius: 24,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.touch_app,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                        Icons.star,
                        size: 140,
                        color: Color(0xFFFFD700),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(48),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF4CAF50,
                              ).withAlpha((0.5 * 255).toInt()),
                              blurRadius: 16,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Text(
                          'PERFECT!',
                          style: TextStyle(
                            fontSize: 40,
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
