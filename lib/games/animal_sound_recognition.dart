import 'package:flutter/material.dart';

class AnimalSoundRecognitionGame extends StatefulWidget {
  const AnimalSoundRecognitionGame({super.key});

  @override
  State<AnimalSoundRecognitionGame> createState() =>
      _AnimalSoundRecognitionGameState();
}

class _AnimalSoundRecognitionGameState extends State<AnimalSoundRecognitionGame>
    with TickerProviderStateMixin {
  late String targetAnimal;
  late List<String> options;
  bool gameComplete = false;
  late AnimationController _celebrationController;

  final Map<String, String> animalEmojis = {
    'Dog': '🐶',
    'Cat': '🐱',
    'Cow': '🐮',
    'Pig': '🐷',
  };

  final Map<String, String> animalSoundsText = {
    'Dog': 'WOOF WOOF!',
    'Cat': 'MEOW!',
    'Cow': 'MOOOOO!',
    'Pig': 'OINK OINK!',
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
      options = animalEmojis.keys.toList()..shuffle();
      targetAnimal = options[0];
      options.shuffle();
      gameComplete = false;
    });
  }

  void _checkMatch(String selectedAnimal) {
    if (gameComplete) return;

    if (selectedAnimal == targetAnimal) {
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
      backgroundColor: const Color(0xFFFFF0F4),
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
                        'WHO SAYS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF6B2E3E),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF48FB1),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFFF48FB1,
                              ).withAlpha((0.4 * 255).toInt()),
                              blurRadius: 20,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.volume_up,
                              color: Colors.white,
                              size: 64,
                            ),
                            const SizedBox(width: 24),
                            Text(
                              animalSoundsText[targetAnimal]!,
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),
                      Wrap(
                        spacing: 32,
                        runSpacing: 32,
                        alignment: WrapAlignment.center,
                        children: options.map((animal) {
                          return GestureDetector(
                            onTap: () => _checkMatch(animal),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: gameComplete && animal == targetAnimal
                                    ? Colors.greenAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(
                                      (0.08 * 255).toInt(),
                                    ),
                                    blurRadius: 16,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  animalEmojis[animal]!,
                                  style: const TextStyle(fontSize: 100),
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
                        Icons.star,
                        size: 160,
                        color: Color(0xFFFFD700),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'WELL DONE!',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFE91E63),
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
