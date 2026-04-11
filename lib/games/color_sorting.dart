import 'package:flutter/material.dart';

class ColorItem {
  final int id;
  final String colorName;
  ColorItem({required this.id, required this.colorName});
}

class ColorSortingGame extends StatefulWidget {
  const ColorSortingGame({super.key});

  @override
  State<ColorSortingGame> createState() => _ColorSortingGameState();
}

class _ColorSortingGameState extends State<ColorSortingGame>
    with TickerProviderStateMixin {
  List<ColorItem> items = [];
  bool gameComplete = false;
  late AnimationController _celebrationController;

  final Map<String, Color> colorMap = {
    'Red': const Color(0xFFE53935),
    'Blue': const Color(0xFF1E88E5),
    'Yellow': const Color(0xFFFFB300),
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
      items = [
        ColorItem(id: 1, colorName: 'Red'),
        ColorItem(id: 2, colorName: 'Blue'),
        ColorItem(id: 3, colorName: 'Yellow'),
        ColorItem(id: 4, colorName: 'Red'),
        ColorItem(id: 5, colorName: 'Blue'),
      ]..shuffle();
      gameComplete = false;
      _celebrationController.reset();
    });
  }

  void _onAccept(ColorItem item, String bucketColor) {
    if (item.colorName == bucketColor) {
      setState(() {
        items.removeWhere((element) => element.id == item.id);
        if (items.isEmpty) {
          gameComplete = true;
          _celebrationController.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF80CBC4), Color(0xFF00695C)],
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
                        Text('SORT COLORS!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=8..color=const Color(0xFF004D40))),
                        const Text('SORT COLORS!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: colorMap.keys.map((c) {
                        return DragTarget<ColorItem>(
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: colorMap[c]!.withAlpha(220),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.white, width: 5),
                                boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 5)],
                              ),
                              child: const Center(
                                child: Icon(Icons.arrow_downward_rounded, color: Colors.white, size: 40),
                              ),
                            );
                          },
                          onWillAcceptWithDetails: (data) => true,
                          onAcceptWithDetails: (data) => _onAccept(data.data, c),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 60),
                    if (items.isNotEmpty)
                      Wrap(
                        spacing: 20, runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: items.map((item) {
                          return Draggable<ColorItem>(
                            data: item,
                            feedback: Container(
                              width: 80, height: 80,
                              decoration: BoxDecoration(
                                color: colorMap[item.colorName],
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: Container(
                                width: 80, height: 80,
                                decoration: BoxDecoration(
                                  color: colorMap[item.colorName],
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                              ),
                            ),
                            child: Container(
                              width: 80, height: 80,
                              decoration: BoxDecoration(
                                color: colorMap[item.colorName],
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 5))],
                              ),
                            ),
                          );
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
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        _startNewRound();
                                      });
                                    }
                                  },
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
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
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
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        _startNewRound();
                                      });
                                    }
                                  },
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
