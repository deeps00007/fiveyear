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
    'Square': Icons.square_rounded,
    'Star': Icons.star_rounded,
    'Triangle': Icons.change_history_rounded,
  };

  final Map<String, List<Color>> shapeGradients = {
    'Circle': [const Color(0xFFFFD54F), const Color(0xFFFFB300)],
    'Square': [const Color(0xFFFF8A65), const Color(0xFFF4511E)],
    'Star': [const Color(0xFF81C784), const Color(0xFF388E3C)],
    'Triangle': [const Color(0xFF4DD0E1), const Color(0xFF00897B)],
  };

  final Map<String, Color> shapeShadows = {
    'Circle': const Color(0xFFF57F17),
    'Square': const Color(0xFFBF360C),
    'Star': const Color(0xFF1B5E20),
    'Triangle': const Color(0xFF004D40),
  };

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
      _celebrationController.reset();
    });
  }

  void _checkMatch(String selectedShape) {
    if (gameComplete) return;

    if (selectedShape == targetShape) {
      setState(() {
        gameComplete = true;
      });
      _celebrationController.forward();
    }
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  Widget _buildShapeButton(String shape, {bool isTarget = false}) {
    return GestureDetector(
      onTap: () => isTarget ? null : _checkMatch(shape),
      child: Container(
        width: isTarget ? 150 : 110,
        height: isTarget ? 150 : 110,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: shapeGradients[shape]!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(isTarget ? 35 : 25),
          boxShadow: [
            BoxShadow(
              color: shapeShadows[shape]!,
              offset: const Offset(0, 6),
              blurRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withAlpha(50),
              offset: const Offset(0, 10),
              blurRadius: 10,
            ),
          ],
          border: Border.all(
            color: Colors.white.withAlpha(150),
            width: 3,
          ),
        ),
        child: Center(
          child: Icon(
            shapeIcons[shape],
            size: isTarget ? 90 : 60,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha(40),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFF673AB7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCA28),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFF57F17),
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          \'FIND THE SHAPE!\',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            fontFamily: \'ComicSans\',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 8
                              ..color = const Color(0xFF283593),
                          ),
                        ),
                        const Text(
                          \'FIND THE SHAPE!\',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            fontFamily: \'ComicSans\',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(220),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(30),
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: _buildShapeButton(targetShape, isTarget: true),
                    ),
                    const SizedBox(height: 64),
                    Wrap(
                      spacing: 32,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: options.map((shape) {
                        return _buildShapeButton(shape);
                      }).toList(),
                    ),
                  ],
                ),
              ),
              if (gameComplete)
                Container(
                  color: Colors.black.withAlpha(100),
                  child: Center(
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _celebrationController,
                          curve: Curves.elasticOut,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF64DD17), Color(0xFF2E7D32)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 8),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0xFF1B5E20),
                              offset: Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              blurRadius: 20,
                              offset: const Offset(0, 15),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  \'YOU WIN!\',
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w900,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 10
                                      ..color = const Color(0xFFF57F17),
                                  ),
                                ),
                                const Text(
                                  \'YOU WIN!\',
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFFFCA28),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 64),
                                Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 80),
                                Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 64),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: _startNewRound,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFCA28),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: const [
                                        BoxShadow(color: Color(0xFFF57F17), offset: Offset(0, 4))
                                      ],
                                    ),
                                    child: const Icon(Icons.replay_rounded, color: Colors.white, size: 36),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4DD0E1),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: const [
                                        BoxShadow(color: Color(0xFF00838F), offset: Offset(0, 4))
                                      ],
                                    ),
                                    child: const Icon(Icons.home_rounded, color: Colors.white, size: 36),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: _startNewRound,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF7043),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: const [
                                        BoxShadow(color: Color(0xFFD84315), offset: Offset(0, 4))
                                      ],
                                    ),
                                    child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 36),
                                  ),
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
