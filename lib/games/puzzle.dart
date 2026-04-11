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
      duration: const Duration(milliseconds: 800),
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
      _celebrationController.forward().then((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              leftPlaced = false;
              rightPlaced = false;
              _celebrationController.reset();
            });
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
      backgroundColor: const Color(0xFFF7F2FF),
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
                        'FIX THE STAR',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4A2E87),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DragTarget<String>(
                            onWillAcceptWithDetails: (data) =>
                                data.data == 'left',
                            onAcceptWithDetails: (data) => _onLeftAccept(),
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                width: 120,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: leftPlaced
                                      ? Colors.transparent
                                      : Colors.black12,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(120),
                                    bottomLeft: Radius.circular(120),
                                  ),
                                ),
                                child: leftPlaced
                                    ? _HalfStar(isLeft: true)
                                    : null,
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                          DragTarget<String>(
                            onWillAcceptWithDetails: (data) =>
                                data.data == 'right',
                            onAcceptWithDetails: (data) => _onRightAccept(),
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                width: 120,
                                height: 240,
                                decoration: BoxDecoration(
                                  color: rightPlaced
                                      ? Colors.transparent
                                      : Colors.black12,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(120),
                                    bottomRight: Radius.circular(120),
                                  ),
                                ),
                                child: rightPlaced
                                    ? _HalfStar(isLeft: false)
                                    : null,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!rightPlaced)
                            Draggable<String>(
                              data: 'right',
                              feedback: Material(
                                color: Colors.transparent,
                                child: _HalfStar(isLeft: false),
                              ),
                              childWhenDragging: const SizedBox(
                                width: 120,
                                height: 240,
                              ),
                              child: _HalfStar(isLeft: false),
                            )
                          else
                            const SizedBox(width: 120, height: 240),
                          if (!leftPlaced)
                            Draggable<String>(
                              data: 'left',
                              feedback: Material(
                                color: Colors.transparent,
                                child: _HalfStar(isLeft: true),
                              ),
                              childWhenDragging: const SizedBox(
                                width: 120,
                                height: 240,
                              ),
                              child: _HalfStar(isLeft: true),
                            )
                          else
                            const SizedBox(width: 120, height: 240),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (leftPlaced && rightPlaced)
              Center(
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _celebrationController,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 200,
                    color: Color(0xFFFFD700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HalfStar extends StatelessWidget {
  final bool isLeft;
  const _HalfStar({required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 240,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: isLeft
            ? const BorderRadius.only(
                topLeft: Radius.circular(120),
                bottomLeft: Radius.circular(120),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(120),
                bottomRight: Radius.circular(120),
              ),
      ),
      child: Center(
        child: Icon(
          isLeft ? Icons.star_half : Icons.star_half,
          size: 80,
          color: Colors.white,
        ), // Close enough visual representation for a simple app
      ),
    );
  }
}
