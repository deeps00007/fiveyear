import 'package:flutter/material.dart';

class AlphabetMatchGame extends StatefulWidget {
  const AlphabetMatchGame({super.key});

  @override
  State<AlphabetMatchGame> createState() => _AlphabetMatchGameState();
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
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _resetGame();
  }

  void _resetGame() {
    letters = [
      LetterItem(letter: 'A', emoji: '🍎', isMatched: false),
      LetterItem(letter: 'B', emoji: '🎈', isMatched: false),
      LetterItem(letter: 'C', emoji: '🐱', isMatched: false),
    ];
    targetLetter = letters[0].letter;
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
      });

      gameComplete = true;
      _celebrationController.forward().then((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _playAgain();
          }
        });
      });
    }
  }

  void _playAgain() {
    setState(() {
      _resetGame();
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
      backgroundColor: const Color(0xFFE0F7FA),
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
                          color: const Color(0xFF00BCD4),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF00BCD4,
                              ).withAlpha((0.4 * 255).toInt()),
                              blurRadius: 20,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            targetLetter,
                            style: const TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'TAP THE RIGHT ONE',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0097A7),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 56),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          letters.length,
                          (index) => GestureDetector(
                            onTap: () => _selectLetter(letters[index].letter),
                            child: _LetterCard(item: letters[index]),
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
                        Icons.favorite,
                        size: 120,
                        color: Color(0xFFE91E63),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 28,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                          elevation: 12,
                        ),
                        onPressed: _playAgain,
                        child: const Text(
                          'PLAY AGAIN',
                          style: TextStyle(
                            fontSize: 36,
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

class LetterItem {
  final String letter;
  final String emoji;
  final bool isMatched;

  LetterItem({
    required this.letter,
    required this.emoji,
    required this.isMatched,
  });
}

class _LetterCard extends StatelessWidget {
  final LetterItem item;

  const _LetterCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: item.isMatched
            ? const Color(0xFF4CAF50)
            : const Color(0xFFFFEB3B),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                (item.isMatched
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFFFEB3B))
                    .withAlpha((0.4 * 255).toInt()),
            blurRadius: 16,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 8),
            Text(
              item.letter,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
