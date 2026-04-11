import 'package:flutter/material.dart';

class ShapeMatchingGame extends StatefulWidget {
  const ShapeMatchingGame({super.key});

  @override
  State<ShapeMatchingGame> createState() => _ShapeMatchingGameState();
}

class _ShapeMatchingGameState extends State<ShapeMatchingGame>
    with TickerProviderStateMixin {
  late String targetShape;
  late List<String> options;
  bool gameComplete = false;
  late AnimationController _celebrationController;

  final Map<String, IconData> shapeIcons = {
    'Circle': Icons.circle,
    'Square': Icons.square,
    'Star': Icons.star,
    'Triangle': Icons.change_history,
  };

  final Map<String, Color> shapeColors = {
    'Circle': Colors.red,
    'Square': Colors.blue,
    'Star': Colors.amber,
    'Triangle': Colors.green,
  };

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _startNewRound();
  }

  void _startNewRound() {
    setState(() {
      options = shapeIcons.keys.toList()..shuffle();
      targetShape = options[0];
      options.shuffle();
      gameComplete = false;
    });
  }

  void _checkMatch(String selectedShape) {
    if (gameComplete) return;

    if (selectedShape == targetShape) {
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
    }
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
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
                        'FIND THE',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF00796B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          shapeIcons[targetShape],
                          size: 140,
                          color: shapeColors[targetShape],
                        ),
                      ),
                      const SizedBox(height: 64),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: options.map((shape) {
                          return GestureDetector(
                            onTap: () => _checkMatch(shape),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: gameComplete && shape == targetShape
                                    ? Colors.greenAccent
                                    : Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: shapeColors[shape]!.withAlpha(
                                      (0.3 * 255).toInt(),
                                    ),
                                    blurRadius: 16,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  shapeIcons[shape],
                                  size: 80,
                                  color: gameComplete && shape == targetShape
                                      ? Colors.white
                                      : shapeColors[shape],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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
                        Icons.check_circle,
                        size: 160,
                        color: Color(0xFF4CAF50),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'YAY!',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4CAF50),
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 12),
                          ],
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
