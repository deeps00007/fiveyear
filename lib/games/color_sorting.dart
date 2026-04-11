import 'package:flutter/material.dart';

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
    'Red': Colors.red,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow,
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
      items = [
        ColorItem(id: 1, colorName: 'Red'),
        ColorItem(id: 2, colorName: 'Blue'),
        ColorItem(id: 3, colorName: 'Yellow'),
        ColorItem(id: 4, colorName: 'Red'),
      ]..shuffle();
      gameComplete = false;
    });
  }

  void _onAccept(ColorItem item, String bucketColor) {
    if (item.colorName == bucketColor) {
      setState(() {
        items.removeWhere((element) => element.id == item.id);
        if (items.isEmpty) {
          gameComplete = true;
          _celebrationController.forward().then((_) {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                _startNewRound();
                _celebrationController.reset();
              }
            });
          });
        }
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
      backgroundColor: const Color(0xFFFFF3E0),
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
                child: Container(
                  width: 800, // Fixed width constraints perfect for horizontal
                  height: 480, // Fixed height constraints suitable for dragging
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'DRAG TO BASKET!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: colorMap.keys.map((colorName) {
                            return DragTarget<ColorItem>(
                              onAcceptWithDetails: (details) =>
                                  _onAccept(details.data, colorName),
                              builder: (context, candidateData, rejectedData) {
                                bool isActive = candidateData.isNotEmpty;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: isActive ? 160 : 140,
                                  height: isActive ? 160 : 140,
                                  decoration: BoxDecoration(
                                    color: colorMap[colorName]!.withAlpha(
                                      (0.2 * 255).toInt(),
                                    ),
                                    border: Border.all(
                                      color: colorMap[colorName]!,
                                      width: 8,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.shopping_basket,
                                      size: 80,
                                      color: colorMap[colorName],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 4,
                        color: Colors.brown,
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: items.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Draggable<ColorItem>(
                                    data: item,
                                    feedback: Material(
                                      color: Colors.transparent,
                                      child: _buildDragItem(item, 100),
                                    ),
                                    childWhenDragging: Opacity(
                                      opacity: 0.3,
                                      child: _buildDragItem(item, 80),
                                    ),
                                    child: _buildDragItem(item, 80),
                                  ),
                                );
                              }).toList(),
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
                  child: const Icon(
                    Icons.star,
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

  Widget _buildDragItem(ColorItem item, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorMap[item.colorName],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}

class ColorItem {
  final int id;
  final String colorName;
  ColorItem({required this.id, required this.colorName});
}
