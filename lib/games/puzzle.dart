import 'package:flutter/material.dart';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({super.key});

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> with TickerProviderStateMixin {
  bool leftPlaced = false;
  bool rightPlaced = false;
  late AnimationController _celebrationController;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  void _onLeftAccept() {
    setState(() {
      leftPlaced = true;
      _checkWin();
    });
  }

  void _onRightAccept() {
    setState(() {
      rightPlaced = true;
      _checkWin();
    });
  }

  void _checkWin() {
    if (leftPlaced && rightPlaced) {
      _celebrationController.forward();
    }
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  Widget _buildPiece(Color color, String text) {
    return Container(
      width: 100, height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 5)],
      ),
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFCC80), Color(0xFFFF5252)],
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
                        Text('SOLVE THE PUZZLE!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=8..color=const Color(0xFFD50000))),
                        const Text('SOLVE THE PUZZLE!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DragTarget<String>(
                          builder: (context, candidateData, rejectedData) {
                            return leftPlaced
                                ? _buildPiece(const Color(0xFF4CAF50), '1')
                                : Container(width: 100, height: 150, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white30, width: 4, style: BorderStyle.solid)));
                          },
                          onWillAcceptWithDetails: (data) => data.data == 'left',
                          onAcceptWithDetails: (_) => _onLeftAccept(),
                        ),
                        const SizedBox(width: 10),
                        DragTarget<String>(
                          builder: (context, candidateData, rejectedData) {
                            return rightPlaced
                                ? _buildPiece(const Color(0xFF2196F3), '2')
                                : Container(width: 100, height: 150, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white30, width: 4, style: BorderStyle.solid)));
                          },
                          onWillAcceptWithDetails: (data) => data.data == 'right',
                          onAcceptWithDetails: (_) => _onRightAccept(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (!leftPlaced)
                          Draggable<String>(
                            data: 'left',
                            feedback: _buildPiece(const Color(0xFF4CAF50), '1'),
                            childWhenDragging: Opacity(opacity: 0.3, child: _buildPiece(const Color(0xFF4CAF50), '1')),
                            child: _buildPiece(const Color(0xFF4CAF50), '1'),
                          ),
                        if (!rightPlaced)
                          Draggable<String>(
                            data: 'right',
                            feedback: _buildPiece(const Color(0xFF2196F3), '2'),
                            childWhenDragging: Opacity(opacity: 0.3, child: _buildPiece(const Color(0xFF2196F3), '2')),
                            child: _buildPiece(const Color(0xFF2196F3), '2'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              if (leftPlaced && rightPlaced)
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
                                Text(\'YOU WIN!\', style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 10..color = const Color(0xFFF57F17))),
                                const Text(\'YOU WIN!\', style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Color(0xFFFFCA28))),
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
                                    if (mounted) setState(() { leftPlaced = false; rightPlaced = false; _celebrationController.reset(); });
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
                                    if (mounted) setState(() { leftPlaced = false; rightPlaced = false; _celebrationController.reset(); });
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
