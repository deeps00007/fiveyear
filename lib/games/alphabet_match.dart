import 'package:flutter/material.dart';

class AlphabetMatchGame extends StatefulWidget {
  const AlphabetMatchGame({super.key});

  @override
  State<AlphabetMatchGame> createState() => _AlphabetMatchGameState();
}

class LetterItem {
  final String letter;
  final String emoji;
  final bool isMatched;
  LetterItem({required this.letter, required this.emoji, required this.isMatched});
}

class _AlphabetMatchGameState extends State<AlphabetMatchGame>
    with TickerProviderStateMixin {
  late List<LetterItem> letters;
  late String targetLetter;
  bool gameComplete = false;
  late AnimationController _celebrationController;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _resetGame();
  }

  void _resetGame() {
    letters = [
      LetterItem(letter: 'A', emoji: '🍎', isMatched: false),
      LetterItem(letter: 'B', emoji: '🎈', isMatched: false),
      LetterItem(letter: 'C', emoji: '🐱', isMatched: false),
    ]..shuffle();
    targetLetter = letters[0].letter;
    letters.shuffle();
    gameComplete = false;
    _celebrationController.reset();
  }

  void _selectLetter(String letter) {
    if (gameComplete) return;

    if (letter == targetLetter) {
      setState(() {
        int index = letters.indexWhere((l) => l.letter == letter);
        letters[index] = LetterItem(
          letter: letters[index].letter,
          emoji: letters[index].emoji,
          isMatched: true,
        );
        gameComplete = true;
      });
      _celebrationController.forward();
    }
  }

  Widget _buildLetterCard(LetterItem item) {
    bool isTarget = gameComplete && item.isMatched;
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: isTarget ? const Color(0xFF64DD17) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isTarget ? Colors.white : const Color(0xFF90CAF9),
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color: isTarget ? const Color(0xFF1B5E20) : const Color(0xFF1976D2),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.letter,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w900,
                color: isTarget ? Colors.white : const Color(0xFF1976D2),
              ),
            ),
            if (isTarget)
              Text(
                item.emoji,
                style: const TextStyle(fontSize: 40),
              )
          ],
        ),
      ),
    );
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
            colors: [Color(0xFFCE93D8), Color(0xFF8E24AA)],
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
                          'FIND THE LETTER!',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'ComicSans',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 8
                              ..color = const Color(0xFF4A148C),
                          ),
                        ),
                        const Text(
                          'FIND THE LETTER!',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'ComicSans',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white, width: 5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFF57F17),
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          targetLetter,
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Color(0xFFF57F17),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 64),
                    Wrap(
                      spacing: 32,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: letters.map((item) {
                        return GestureDetector(
                          onTap: () => _selectLetter(item.letter),
                          child: _buildLetterCard(item),
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
                                  'YOU WIN!',
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
                                  'YOU WIN!',
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
                                  onTap: () => setState(() => _resetGame()),
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
                                  onTap: () => setState(() => _resetGame()),
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
